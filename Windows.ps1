#############
# Functions #
#############

function Invoke-ScoopBuckets {
    scoop update
    scoop bucket add extras
    scoop bucket add nonportable
}

#############

Write-Host "nattadasu's Personal First-Run OS Setup"
Write-Host "======================================="

Write-Host "This script will install using WinGet, Chocolatey, Scoop, and PowerShell's Invoke-WebRequest."
$Prompt = Read-Host -Prompt "Do you agree? (y/n)"

if ($Prompt -eq "n") {
    Write-Host "Exiting..."
    exit
}

# Check if user run the script as admin, otherwise exit
if ([Security.Principal.WindowsIdentity]::GetCurrent().Groups -contains 'S-1-5-32-544') {
    if (Get-Command "scoop" -ErrorAction SilentlyContinue) {} else {
        Write-Host "If you want to install Scoop, please rerun the script as non-admin." -ForegroundColor Yellow
    }
} else {
    # Check if scoop is installed, if not, install it
    if (Get-Command "scoop" -ErrorAction SilentlyContinue) {
        Write-Host Scoop is installed
        Invoke-ScoopBuckets
    } else {
        Write-Host "Installing Scoop..."
        Invoke-RestMethod -useb get.scoop.sh | Invoke-Expression
        Invoke-ScoopBuckets
    }

    Write-Host "To install the rest of packages, you must run this script as admin." -ForegroundColor Red
    Write-Host "Exiting..."
    exit
}

if (Get-Command "choco" -ErrorAction SilentlyContinue) {
    Write-Host Chocolatey is installed
} else {
    Write-Host "Installing Chocolatey..."
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

# Get a list of essential WinGet packages to install
$wgEssentials = @(
    # Browsers
    "Mozilla.Firefox",
    "Google.Chrome",

    # Development Tools
    "Microsoft.WindowsTerminal",
    "Notepad++.Notepad++",
    "Git.Git",
    "GitHub.Cli",

    "Microsoft.PowerShell",
    "Microsoft.VisualStudioCode",
    "OpenJS.NodeJS.LTS",

    # Archiver
    "RARLab.WinRAR",
    "7zip.7zip",
    "GiorgioTani.PeaZip",

    # Multimedia
    "CodecGuide.K-LiteCodecPack.Mega",
    "Audacity.Audacity",
    "Apple.iTunes",
    "Daum.PotPlayer",
    "VideoLAN.VLC",
    "SMPlayer.SMPlayer",
    "Spotify.Spotify",
    "erengy.Taiga",

    # Office Suites
    "TheDocumentFoundation.LibreOffice"
)

$chEssentials = @(
    "gitkraken"
)

$scEssentials = @(
)

# Try to install WinGet packages from $wgEssentials
Write-Host "Installing WinGet packages..."
ForEach ($package in $wgEssentials) {
    Write-Host "Installing $package..."
    WinGet install --id $package -e
}

# Try to install Scoop packages from $scEssentials
Write-Host "Installing Scoop packages..."
ForEach ($package in $scEssentials) {
    Write-Host "Installing $package..."
    scoop install $package
}

# Try to install Chocolatey packages from $chEssentials
Write-Host "Installing Chocolatey packages..."
ForEach ($package in $chEssentials) {
    Write-Host "Installing $package..."
    choco install $package -y
}

$wgGames = @(
    "Valve.Steam",
    "EpicGames.EpicGamesLauncher",
    "Discord.Discord",
    "Peppy.Osu!",
    "Microsoft.VC++2015-2022Redist-x86",
    "Microsoft.VC++2015-2022Redist-x64",
    "Microsoft.VC++2013Redist-x64",
    "Microsoft.VC++2013Redist-x86",
    "Microsoft.VC++2012Redist-x64",
    "Microsoft.VC++2012Redist-x86",
    "Microsoft.VC++2005Redist-x86",
    "Microsoft.VC++2008Redist-x64",
    "Microsoft.VC++2008Redist-x86",
    "Microsoft.VC++2010Redist-x86",
    "Microsoft.VC++2010Redist-x64"
)

$wgGames_Ask = Read-Host -Prompt "Do you want to install Games pack? (y/n)"
if ($wgGames_Ask -eq "y") {
    Write-Host "Installing WinGet Games packages..."
    ForEach ($package in $wgGames) {
        Write-Host "Installing $package..."
        WinGet install --id $package -e
    }
}