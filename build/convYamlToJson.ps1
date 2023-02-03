# Convert pkgs.yaml to pkgs.json, follows strict order and format

# Load pkgs.yaml
$pkgs = Get-Content -Path .\packages\pkgs.yaml -Raw | ConvertFrom-Yaml

# Sort pkgs.yaml by name alphabetically
$pkgs = $pkgs | Sort-Object -Property name

$entry = @()

# Loop through pkgs.yaml
ForEach ($i in $pkgs) {
    # Write-Host "Converting $($i.name)"
    $avaibility = @()
    if ($i.packages.windows.winget -or $i.packages.windows.choco -or $i.packages.windows.scoop) {
        $avaibility += "Windows"
    }
    if ($i.packages.linux.apk -or $i.packages.linux.appimage -or $i.packages.linux.apt -or $i.packages.linux.aur -or $i.packages.linux.brew -or $i.packages.linux.debGet -or $i.packages.linux.dnf -or $i.packages.linux.flatpak -or $i.packages.linux.nixpkgs -or $i.packages.linux.pacstall -or $i.packages.linux.snap) {
        $avaibility += "Linux"
    }
    if ($i.packages.android.pkg -or $i.packages.android.play -or $i.packages.android.fdroid) {
        $avaibility += "Android"
    }
    if (!$i.id) {
        if ($i.packages.linux.flatpak) {
            $id = $i.packages.linux.flatpak
        } elseif ($i.packages.android.play) {
            $id = $i.packages.android.play
            Write-Warning "No flatpak ID for $($i.name), set to Google Play ID."
        } elseif ($i.packages.windows.winget) {
            $id = $i.packages.windows.winget
            Write-Warning "No flatpak ID for $($i.name), set to winget ID."
        }
    } else {
        $id = $i.id
    }
    $data = [ordered]@{
        id = $id
        name = $i.name
        publisher = $i.publisher
        author = $i.author
        # description = $i.description
        homepage = $i.homepage
        license = $i.license
        available = $avaibility
        packages = [ordered]@{
            windows = [ordered]@{
                choco = $i.packages.windows.choco
                scoop = $i.packages.windows.scoop
                winget = $i.packages.windows.winget
            }
            linux = [ordered]@{
                apk = $i.packages.linux.apk
                appimage = $i.packages.linux.appimage
                apt = $i.packages.linux.apt
                aur = $i.packages.linux.aur
                brew = $i.packages.linux.brew
                debGet = $i.packages.linux.debGet
                dnf = $i.packages.linux.dnf
                flatpak = $i.packages.linux.flatpak
                nixpkgs = $i.packages.linux.nixpkgs
                pacstall = $i.packages.linux.pacstall
                snap = $i.packages.linux.snap
            }
            android = [ordered]@{
                pkg = $i.packages.android.pkg
                play = $i.packages.android.play
            }
        }
    }
    $entry += [PSCustomObject]$data
}

# Convert to JSON
$entry | ConvertTo-Json -Depth 10 | Out-File -FilePath .\data\pkgs.json -Encoding UTF8

# ---------------------------------------------------------------------------------------------

# Convert modules.yaml to modules.json, follows strict order and format

# Load modules.yaml
$modules = Get-Content -Path .\packages\modules.yaml -Raw | ConvertFrom-Yaml

$entry = @{}
$lang = @(
    "node",
    "pwsh",
    "python",
    "rust"
)

# Loop through modules.yaml
ForEach ($a in $lang) {
    $langEntry = @()
    ForEach ($i in $modules.$a) {
        # Write-Host "Converting $($i.name)"
        $data = [ordered]@{
            name = $i.name
            package = $i.package
            author = $i.author
            description = $i.description
            repository = $i.repository
            license = $i.license
            available = $i.available
            executables = $i.executables
        }
        $langEntry += [PSCustomObject]$data
    }
    $entry += [ordered]@{
        $a = [PSCustomObject]$langEntry
    }
}

# Convert to JSON
$entry | ConvertTo-Json -Depth 10 | Out-File -FilePath .\data\modules.json -Encoding UTF8
