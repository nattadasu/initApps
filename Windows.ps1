#!/usr/bin/env pwsh

#############
# Functions #
#############

function Write-None {
    Write-Host ""
}

function Invoke-ScoopBuckets {
    scoop update
    scoop bucket add extras
    scoop bucket add nonportable
    scoop bucket add nerd-fonts
}

#############

# Skip if not on Windows
if (-not ($IsWindows)) {
    Write-None
    Write-Host "This script only works on Windows." -ForegroundColor Red
    exit 1
}

Write-Host "nattadasu's Personal First-Run OS Setup"
Write-Host "======================================="

Write-None
Write-Host "This script will install using winget, Chocolatey, Scoop, and PowerShell's Invoke-WebRequest." -ForegroundColor Yellow
$Prompt = Read-Host -Prompt "Do you agree? (y/n)"

if ($Prompt -eq "n") {
    Write-Host "Exiting..." -ForegroundColor Red
    exit 1
}

# Check if user run the script as admin, otherwise exit
if ([Security.Principal.WindowsIdentity]::GetCurrent().Groups -contains 'S-1-5-32-544') {
    if (-not (Get-Command "scoop" -ErrorAction SilentlyContinue)) {
        Write-Host "If you want to install Scoop, please rerun the script as non-admin." -ForegroundColor DarkYellow
    }
} else {
    Write-None
    # Check if scoop is installed, if not, install it
    if (Get-Command "scoop" -ErrorAction SilentlyContinue) {
        Write-Host "Scoop is installed" -ForegroundColor Green
        Invoke-ScoopBuckets
    } else {
        Write-Host "Installing Scoop..." -ForegroundColor Blue
        Invoke-RestMethod -useb get.scoop.sh | Invoke-Expression
        Invoke-ScoopBuckets
    }

    Write-Host "To install the rest of packages, you must run this script as admin." -ForegroundColor Red
    Write-Host "Exiting..."
    exit 1
}

Write-None
# Check winget is available, if not prompt user to open Microsoft Store and Update "App Installer"
if (Get-Command "winget" -ErrorAction SilentlyContinue) {
    Write-Host "winget is installed" -ForegroundColor Green
} else {
    Write-Host "winget is not installed" -ForegroundColor Red
    Write-Host "Opening Microsoft Store..." -ForegroundColor Blue
    Start-Process -FilePath "ms-windows-store://pdp/?productid=9NBLGGH4NNS1&referrer=powershell" -Verb "open" -ArgumentList "-force"
    Write-Host "Please update App Installer to install winget." -ForegroundColor Red
    exit 1
}

if (Get-Command "choco" -ErrorAction SilentlyContinue) {
    Write-Host "Chocolatey is installed" -ForegroundColor Green
} else {
    Write-None
    Write-Host "Installing Chocolatey..." -ForegroundColor Blue
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

# Get a list of essential winget packages to install
# Try to avoid Microsoft Store as a package source
$wgEssentials = @(
    # Browsers
    "Mozilla.Firefox",
    "Google.Chrome",
    "GnuWin32.Wget",
    "BraveSoftware.BraveBrowser",
    "eloston.ungoogled-chromium",

    # Development Tools
    "Microsoft.WindowsTerminal",
    "Notepad++.Notepad++",
    "Git.Git",
    "GitHub.Cli",
    "Axosoft.GitKraken",
    "Microsoft.PowerShell",
    "Microsoft.VisualStudioCode",
    "OpenJS.NodeJS.LTS",
    "SublimeHQ.SublimeText",
    "Cygwin.Cygwin",
    "Starship.Starship",
    "chrisant996.Clink"

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
    "Pinta.Pinta",
    "XnSoft.XnConvert",
    "KDE.Krita",

    # Office Suites
    "TheDocumentFoundation.LibreOffice",
    "KDE.Kate",
    "calibre.calibre",
    "JohnMacFarlane.Pandoc",
    "ONLYOFFICE.DesktopEditors",

    # Productivity
    "KDE.KDEConnect",
    "File-New-Project.EarTrumpet",

    # Other
    "Rufus.Rufus",
    "Balena.Etcher",
    "Cloudflare.Warp"
)

$scEssentials = @(
    # Others
    "winfetch"
)

$chEssentials = @(
    # Browsers
    "curl"

    # Multimedia
    "paint.net",
    "musicbee",

    # Development Tools
    "micro",
    "nano",

    # Customizer
    "winaero-tweaker"
)

# Try to install winget packages from $wgEssentials
Write-Host "Installing winget packages..." -ForegroundColor Blue
foreach ($package in $wgEssentials) {
    Write-None
    Write-Host "Installing $package..." -ForegroundColor Blue
    winget install --id $package -e
}

# Try to install Scoop packages from $scEssentials
Write-None
Write-Host "Installing Scoop packages..." -ForegroundColor Blue
Write-Host "We will install the following packages:" -ForegroundColor Yellow
Write-Host "$($scEssentials -join ', ')"
Write-None
scoop install $scEssentials --global

Write-None
# Try to install Chocolatey packages from $chEssentials
Write-Host "Installing Chocolatey packages..." -ForegroundColor Blue
Write-Host "We will install the following packages:" -ForegroundColor Yellow
Write-Host "$($chEssentials -join ', ')"
Write-None
choco install $chEssentials -y

# Install nerdfont
Write-None
Write-Host "Downloading fonts..." -ForegroundColor Blue
$nerdFont = @(
    "3270",
    "Iosevka"
)

ForEach ($font in $nerdFont) {
    Write-None
    Write-Host "Downloading $font..." -ForegroundColor Blue
    Invoke-WebRequest -Uri "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$($font).zip" -OutFile "$($File).zip"
    Expand-Archive -Path "$($File).zip" -DestinationPath ".\Fonts" -Force
}

Write-None
Write-Host "Please manually install the fonts in the Fonts folder." -ForegroundColor DarkYellow
explorer.exe .\Fonts

$wgGames = @(
    "Valve.Steam",
    "EpicGames.EpicGamesLauncher",
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
    Write-Host "Installing winget Games packages..."
    foreach ($package in $wgGames) {
        if ($package -eq "Peppy.Osu!") {
            $osuPrompt = Read-Host -Prompt "Install osu!? (y/n)"
            if ($osuPrompt -eq "y") {
                Write-Host "Installing osu!" -ForegroundColor Blue
                winget install --id $package -e
            }
        } else {
            Write-Host "Installing $package..."
            winget install --id $package -e
        }
    }
}

Write-None
Write-Host "Windows Configurations"
Write-Host "======================"

Write-None
$setSystemAsUtc = Read-Host -Prompt "Read BIOS time as UTC, useful if dual-boot with Linux? (y/n)"
if ($setSystemAsUtc -eq "y") {
    $archiveLink = "https://www.howtogeek.com/wp-content/uploads/2017/08/Make-Windows-Use-UTC-Time.zip"
    Write-Host "Configuring Windows to read BIOS time as UTC..." -ForegroundColor Blue

    # Download file
    Invoke-WebRequest -Uri $archiveLink -OutFile "Make-Windows-Use-UTC-Time.zip"

    # Unarchive file
    Write-Host "Unarchiving file..." -ForegroundColor Blue
    Expand-Archive -Path "Make-Windows-Use-UTC-Time.zip" -DestinationPath "." -Force

    # Run .reg file
    Write-Host "Running .reg file..." -ForegroundColor Blue
    Start-Process -FilePath "Make Windows Use UTC Time.reg" -Verb "open" -ArgumentList "-force"

    # Delete files
    Write-Host "Deleting files..." -ForegroundColor Blue
    Remove-Item -Path "Make-Windows-Use-UTC-Time.zip" -Force
    Remove-Item -Path "Make Windows Use UTC Time.reg" -Force
    Remove-Item -Path "Make Windows Use Local Time.reg" -Force
} else {
    Write-Host "Skipping..."
}

Write-None
Write-Host "We will configure PowerShell for you." -ForegroundColor Blue
Write-Host "This includes: " -ForegroundColor Yellow -NoNewline
Write-Host "PSReadLine, PSScriptAnalyzer, PowerShell-Beautifier, Get-ChildItemColor"
$setPowerShell = Read-Host -Prompt "Configure PowerShell? (y/n)"
if ($setPowerShell -eq "y") {
    Write-Host "Configuring PowerShell..." -ForegroundColor Blue
    # Configuring in Windows PowerShell
    Install-Module -Name PSReadLine -AcceptLicense -Confirm -AllowPrerelease -SkipPublisherCheck
    Install-Module -Name PowerShell-Beautifier -AcceptLicense -Confirm
    Install-Module -Name PSScriptAnalyzer -AcceptLicense -Confirm
    Install-Module -Name Get-ChildItemColor -AcceptLicense -Confirm
    $changeProfile = '$psProfile = Get-Content -Path ".\config\Microsoft.PowerShell_profile.ps1"; $psProfile >> $PROFILE'
    powershell -Command "$changeProfile"

    # Configuring in PowerShell Core
    pwsh -Command 'Install-Module -Name PSReadLine -AcceptLicense -Confirm -AllowPrerelease -SkipPublisherCheck'
    pwsh -Command 'Install-Module -Name PowerShell-Beautifier -AcceptLicense -Confirm'
    pwsh -Command 'Install-Module -Name PSScriptAnalyzer -AcceptLicense -Confirm'
    pwsh -Command 'Install-Module -Name Get-ChildItemColor -AcceptLicense -Confirm'
    pwsh -Command "$changeProfile"
} else {
    Write-Host "Skipping..."
}

Write-None
$setStarshipAsTUI = Read-Host -Prompt "Set Starship as shell interface? (y/n)"
if ($setStarshipAsTUI -eq "y") {
    # Configuring $PROFILE for Windows PowerShell
    "Invoke-Expression (&starship init powershell)" >> $PROFILE

    # Configuring LUA Clink script for Batch
    $starshipLua = Get-Content -Path ".\scripts\starship.lua"
    $starshipLua >> $env:LOCALAPPDATA\clink\starship.lua
} else {
    Write-Host "Skipping..."
}
