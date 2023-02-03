#!/usr/bin/env pwsh
# -*- coding: utf-8 -*-
# vim: ft=powershell sw=4 ts=4 et
# ------------------------------------------------------------------------------
#Requires -Version 7
# ------------------------------------------------------------------------------

# Force update JSON files before running this script
.\build\convYamlToJson.ps1

# Load packages.json
$packages = Get-Content -Path .\data\pkgs.json -Raw | ConvertFrom-Json

$pkgsTable = @"
### Packages

> Some packages may not be available on all platforms or installed as [a module](#modules).

<!-- markdownlint-disable MD033 -->
<!-- collapse the table from README -->
<details><summary>Click to expand</summary>
<table>
    <thead>
        <tr>
            <th rowspan=2 style="text-align:center">Package Name</th>
            <th rowspan=2 style="text-align:center">Publisher</th>
            <th rowspan=2 style="text-align:center">Author</th>
            <th rowspan=2 style="text-align:center">Licence</th>
            <th rowspan=2 style="text-align:center">tl;dr support</th>
            <th colspan=3 style="text-align:center">Windows</th>
            <th colspan=10 style="text-align:center">GNU/Linux</th>
            <th colspan=3 style="text-align:center">Android</th>
        </tr>
        <tr>
            <!-- Windows -->
            <th style="text-align:center">winget</th>
            <th style="text-align:center">choco</th>
            <th style="text-align:center">scoop</th>
            <!-- Linux -->
            <th style="text-align:center">apk</th>
            <th style="text-align:center">AppImages</th>
            <th style="text-align:center">aur</th>
            <th style="text-align:center">dnf</th>
            <th style="text-align:center">Flatpak</th>
            <th style="text-align:center">brew</th>
            <th style="text-align:center">nix</th>
            <th style="text-align:center">snap</th>
            <th style="text-align:center">deb</th>
            <th style="text-align:center">pacstall</th>
            <!-- Android -->
            <th style="text-align:center">F-Droid</th>
            <th style="text-align:center">Google Play</th>
            <th style="text-align:center">Termux</th>
        </tr>
    </thead>
    <tbody>
"@

$proprietary = 0

ForEach ($pkg in $packages) {
    If ($pkg.license -eq "Proprietary") { $proprietary++ }

    # Check if package is available to install on each platform
    $winpkg = If ($pkg.packages.windows.winget -or $pkg.packages.windows.choco -or $pkg.packages.windows.scoop) { "🪟" } Else { "" }
    $winget = If ($pkg.packages.windows.winget) { "✅" } Else { "❌" }
    $choco = If ($pkg.packages.windows.choco) { "✅" } Else { "❌" }
    $scoop = If ($pkg.packages.windows.scoop) { "✅" } Else { "❌" }

    $linux = If ($pkg.packages.linux.apk -or $pkg.packages.linux.appimage -or $pkg.packages.linux.aur -or $pkg.packages.linux.dnf -or $pkg.packages.linux.flatpak -or $pkg.packages.linux.brew -or $pkg.packages.linux.nixpkgs -or $pkg.packages.linux.snap -or $pkg.packages.linux.apt -or $pkg.packages.linux.debGet -or $pkg.packages.linux.pacstall) { "🐧" } Else { "" }
    $apk = If ($pkg.packages.linux.apk) { "✅" } Else { "❌" }
    $appimage = If ($pkg.packages.linux.appimage) { "✅" } Else { "❌" }
    $arch = If ($pkg.packages.linux.aur) { "✅" } Else { "❌" }
    $fedora = If ($pkg.packages.linux.dnf) { "✅" } Else { "❌" }
    $flatpak = If ($pkg.packages.linux.flatpak) { "✅" } Else { "❌" }
    $homebrew = If ($pkg.packages.linux.brew) { "✅" } Else { "❌" }
    $nixpkgs = If ($pkg.packages.linux.nixpkgs) { "✅" } Else { "❌" }
    $snapcraft = If ($pkg.packages.linux.snap) { "✅" } Else { "❌" }
    # If package available on apt, debGet, pacstall, or all three, then set to ✅
    $ubuntu = If ($pkg.packages.linux.apt -or $pkg.packages.linux.debGet) { "✅" } Else { "❌" }
    $pacstall = If ($pkg.packages.linux.pacstall) { "✅" } Else { "❌" }

    $androidGui = If ($pkg.packages.android.fdroid -or $pkg.packages.android.play) { "📱" } Else { "" }
    $androidPkg = If ($pkg.packages.android.pkg) { "🤖" } Else { "" }
    $fdroid = If ($pkg.packages.android.fdroid) { "✅" } Else { "❌" }
    $play = If ($pkg.packages.android.play) { "✅" } Else { "❌" }
    $termux = If ($pkg.packages.android.pkg) { "✅" } Else { "❌" }

    # Build the table
    $pkgsTable += @"
`n        <tr><td><a href="$($pkg.homepage)">$($pkg.name)</a></td><td>$($pkg.publisher)</td><td>$($pkg.author)</td><td>$($pkg.license)</td><td>$winpkg$linux$androidGui$androidPkg</td><td>$winget</td><td>$choco</td><td>$scoop</td><td>$apk</td><td>$appimage</td><td>$arch</td><td>$fedora</td><td>$flatpak</td><td>$homebrew</td><td>$nixpkgs</td><td>$snapcraft</td><td>$ubuntu</td><td>$pacstall</td><td>$fdroid</td><td>$play</td><td>$termux</td></tr>
"@
}

$pkgsTable += @"
`n    </tbody>
</table>
</details>
<!-- markdownlint-enable MD033 -->

<!-- trim the avg to 2 decimal places -->
Funfact: the script will install $proprietary proprietary apps/packages out of $($packages.Count) packages. That's about $(($proprietary / $packages.Count * 100).ToString("#.##"))% of the packages!

#### tl;dr's legend

| Icon | Definition         |
| :--: | :----------------- |
| 🪟  | Windows              |
| 🐧  | Linux                |
| 📱  | Android GUI          |
| 🤖  | Android CLI (Termux) |
"@

# load modules.json
$modules = Get-Content -Path .\data\modules.json -Raw | ConvertFrom-Json

$modulesTable = @"
`n### Modules
"@

$lang = @(
    @{node = "Node.js"},
    @{pwsh = "PowerShell"},
    @{python = "Python"},
    @{rust = "Rust"}
)

For ($i = 0; $i -lt $lang.Length; $i++) {
    $modulesTable += @"
`n`n#### $($lang[$i].Values)

| Module Name | Author | License | Package | Installed on | Description |
| :---------: | :----: | :-----: | :-----: | :----------: | :---------- |
"@
    $lval = $lang[$i].Keys
    $modules.$lval = $modules.$lval | Sort-Object -Property name
    foreach ($m in $modules.$lval) {
        $modulesTable += @"
`n| [$($m.name)]($($m.repository)) | $($m.author) | $($m.license) | ``$($m.package)`` | $($m.available -join ", ") | $($m.description.Trim()) |
"@
    }
}

# build readme

$readme = @"
<!-- omit in toc -->
# Natsu's Personal First Init Script

> **WARNING**
>
> This script/package link database is still under development, so some information might be inaccurate or incomplete.
> This also means you can not use this script to install packages/modules yet until it's ready to avoid any unexpected errors.

This is collection of my personal first init script for Windows, Linux, and Android.

All scripts mostly written in PowerShell, but for some cases, a bash script will be generated beforehand.

> BTW, this README file is generated by a PowerShell script, so don't edit it manually, but [edit it in the script](./updateReadme.ps1) instead. ( ͡° ͜ʖ ͡°)

<!-- omit in toc -->
## Table of Contents

* [Packages, Modules, and Dependencies Available to Install](#packages-modules-and-dependencies-available-to-install)
  * [Packages](#packages)
    * [tl;dr's legend](#tldrs-legend)
  * [Modules](#modules)
    * [Node.js](#nodejs)
    * [PowerShell](#powershell)
    * [Python](#python)
    * [Rust](#rust)
* [Instalation Priority](#instalation-priority)
  * [Windows](#windows)
  * [Linux](#linux)
  * [Android](#android)
* [Contributing](#contributing)

## Packages, Modules, and Dependencies Available to Install

$pkgsTable
$modulesTable

## Instalation Priority

Depends on where the app/packages/modules available, we will install them in this order:

### Windows

1. ``winget``
2. ``choco``
3. ``scoop``

### Linux

1. Flatpak
2. Depends on distro:
   * Ubuntu/Debian:
     1. ``apt``
     2. ``deb-get``
     3. ``pacstall``
   * Arch:
     1. ``aur``
   * Fedora:
     1. ``dnf``
   * Alpine:
     1. ``apk``
3. ``brew``
4. ``nix-pkgs``
5. ``snap``
6. ``appimage``

### Android

For Android, we offered Termux packages and APKs via Google Play Store.

1. F-Droid
2. Google Play Store
3. Termux

## Contributing

To contribute, please fork this repo and make a PR. Use Visual Studio Code for the best experience, as the linters and formatted were recommended to install by default when opening the workspace for the first time.
"@

# Write to README.md
$readme | Out-File -FilePath README.md -Encoding utf8 -Force
