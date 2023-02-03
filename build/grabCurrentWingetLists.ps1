#!/usr/bin/env pwsh
#Requires -Version 7.0

# export winget list to JSON
winget export --output ./lists.json

# Grab lists.txt from User Home as JSON, and import it as a hashtable
$lists = Get-Content -Path ./lists.json -Raw | ConvertFrom-Json
$lists = $lists.Sources[0].Packages

$arr = @()

# grab total number of packages
$page = $lists.Count; $n = 1

# Grab information of each package from winget
foreach ($pkg in $lists) {
    $pkg = $pkg.PackageIdentifier
    Write-Host "`r[$n/$page] Getting information for $($pkg): winget`r" -NoNewline -ForegroundColor Yellow
    $pkgInfo = winget show $pkg
    # Grab application name from "Found" line and remove the id in bracket part
    $appName = $pkgInfo | Select-String -Pattern "Found" | ForEach-Object { $_.Line } | ForEach-Object { $_.Replace("Found ", "") } | ForEach-Object { $_.Replace(" [$($pkg)]", " ") }
    # Split application name by newline and take the first part
    $appName = $appName.Split("`n")[0]
    # Grab publisher name from "Publisher" line
    $publisher = $pkgInfo | Select-String -Pattern "Publisher" | ForEach-Object { $_.Line } | ForEach-Object { $_.Replace("Publisher: ", "") }
    # Split publisher name by newline and take the first part
    $publisher = $publisher.Split("`n")[0]
    # Grab author name from "Author" line
    $author = $pkgInfo | Select-String -Pattern "Author" | ForEach-Object { $_.Line } | ForEach-Object { $_.Replace("Author: ", "") }
    # Split author name by newline and take the first part
    if ($null -ne $author) {
        $author = $author.Split("`n")[0]
    } else {
        $author = $publisher
    }
    # Grab description from "Description" line
    $description = $pkgInfo | Select-String -Pattern "Description" | ForEach-Object { $_.Line } | ForEach-Object { $_.Replace("Description: ", "") }
    # Grab homepage from "Homepage" line
    $homepage = $pkgInfo | Select-String -Pattern "Homepage" | ForEach-Object { $_.Line } | ForEach-Object { $_.Replace("Homepage: ", "") }
    # Grab license from "License" line
    $license = $pkgInfo | Select-String -Pattern "License" | ForEach-Object { $_.Line } | ForEach-Object { $_.Replace("License: ", "") }
    # Split license by newline and take the first part
    $license = $license.Split("`n")[0]

    Write-Host "`r[$n/$page] Getting information for $($pkg): chocolatey`r" -NoNewline -ForegroundColor Yellow
    # Lookup the package if it's available on chocolatey
    $choco = choco search $pkg -r -y
    # If the package is available on chocolatey, grab the package id from the first line, assumes the first line is "id|version"
    if ($choco) {
        $choco = $choco | Select-String -Pattern "^[a-zA-Z0-9\-_]" | ForEach-Object { $_.Line } | ForEach-Object { $_.Split("|")[0] }
        # if its array, grab the first one, else just use the string
        if ($choco -is [array]) {
            $choco = $choco[0]
        }
    } else {
        $choco = $Null
    }

    Write-Host "`r[$n/$page] Getting information for $($pkg): scoop`r" -NoNewline -ForegroundColor Yellow
    # Lookup the package if it's available on scoop
    $scoop = $Null

    # Build hashtable and add to array
    $hash = [ordered]@{
        name = $appName.Trim()
        publisher = $publisher
        author = $author
        description = $description
        homepage = $homepage
        license = $license
        available = @(
            "windows"
        )
        packages = [ordered]@{
            windows = [ordered]@{
                winget = $pkg
                choco = $choco
                scoop = $scoop
            }
            linux = [ordered]@{
                apt = $Null
                dnf = $Null
                apk = $Null
                pacman = $Null
                snap = $Null
                flatpak = $Null
            }
            macos = [ordered]@{
                brew = $Null
                macports = $Null
                cask = $Null
            }
            android = [ordered]@{
                pkg = $Null
            }
        }
    }
    $arr += [PSCustomObject]$hash
    $n++
}

# Export array as JSON
$arr | ConvertTo-Json -Depth 10 | Out-File -FilePath ./packages.json -Encoding UTF8 -Force
