#!/usr/bin/env pwsh

winfetch

Import-Module PSReadLine

# Shows navigable menu of all options when hitting Tab
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# Autocompleteion for Arrow keys
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-PSReadLineOption -ShowToolTips
Set-PSReadLineOption -PredictionSource History

Import-Module Get-ChildItemColor

If (-Not (Test-Path Variable:PSise)) {  # Only run this in the console and not in the ISE
    Import-Module Get-ChildItemColor

    Set-Alias l Get-ChildItemColor -option AllScope

    function Get-ChildItemWide {
        Get-ChildItemColorFormatWide -HideHeader -TrailingSlashDirectory
    }

    Set-Alias ls Get-ChildItemWide -option AllScope
}

if ($IsWindows) {
    Set-Alias neofetch winfetch
}
