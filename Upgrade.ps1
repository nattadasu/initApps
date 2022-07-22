#!/usr/bin/env pwsh

if ($IsWindows) {
    sudo winget upgrade --all
    scoop update
    sudo scoop update *
    sudo choco upgrade all
} elseif ($IsLinux) {
    Write-Host "This script only support Debian/Ubuntu derivatives."
    $woi = whoami
    if ($woi -eq "root") {
        pacstall -Up
        nala upgrade
        brew update
        brew upgrade
    } else {
        Write-Host "You need to run this script as root, otherwise we only upgrade Flatpak packages."
    }
    flatpak update
}
