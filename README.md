<!-- markdownlint-disable MD026 MD033 -->
<!-- cSpell:words choco eloston Flatpak ungoogled volitank wimpysworld winget -->

# initApps

My Personal scripts to download and install scripts for first time run in Linux and Windows. [Unlicensed](LICENSE)-ly licensed.

Note that because this is my personal repo, then the language used in this repo is not the formal one. ¯\\\_(ツ)_/¯

Also, some softwares will be named after their WinGet's package id, if available.

## What apps will be installed?

This script will install the following apps:

<!-- cSpell:Disable --->

|                            Packages |      Category      |        Windows Source        | Ubuntu Source            |
| ----------------------------------: | :----------------: | :--------------------------: | :----------------------- |
|                         `7zip.7zip` |      Archiver      |           `winget`           | -                        |
|                      `Apple.iTunes` |    Music Player    |           `winget`           | -                        |
|                 `Audacity.Audacity` |    Audio Editor    |           `winget`           | `apt`                    |
|                 `Axosoft.GitKraken` |     Dev Tools      |           `winget`           | `deb-get`                |
|                     `Balena.Etcher` |    Image Burner    |           `winget`           | `deb-get`                |
|        `BraveSoftware.BraveBrowser` |      Browser       |           `winget`           | `deb-get`                |
|                   `calibre.calibre` |    Ebook Reader    |           `winget`           | `apt`                    |
|                             `choco` |  Package Manager   |            Binary            | -                        |
|                 `chrisant996.Clink` |   Terminal/Shell   |           `winget`           | -                        |
|                   `Cloudflare.Warp` |     DNS Tunnel     |           `winget`           | `apt`                    |
|   `CodecGuide.K-LiteCodecPack.Mega` |       Codecs       |           `winget`           | -                        |
|                              `curl` |     Downloader     |           `choco`            | Native or `apt`          |
|                     `Cygwin.Cygwin` |   Terminal/Shell   |           `winget`           | -                        |
|                    `Daum.PotPlayer` |    Video Player    |           `winget`           | -                        |
|                           `deb-get` |      Wrapper       |              -               | Binary                   |
|        `eloston.ungoogled-chromium` |      Browser       |           `winget`           | `apt` with PPA           |
|                      `erengy.Taiga` |   Media Tracker    |           `winget`           | -                        |
|       `File-New-Project.EarTrumpet` |   Customization    |           `winget`           | -                        |
|                           `flatpak` |  Package Manager   |              -               | Native or `apt`          |
|                `GiorgioTani.PeaZip` |      Archiver      |           `winget`           | `flatpak`                |
|                           `Git.Git` |     Dev Tools      |           `winget`           | Native                   |
|                        `GitHub.Cli` |     Dev Tools      |           `winget`           | `deb-get`                |
|                     `GnuWin32.Wget` |     Downloader     |           `winget`           | Native or `apt`          |
|                     `Google.Chrome` |      Browser       |           `winget`           | `deb-get`                |
|             `JohnMacFarlane.Pandoc` | Document Converter |           `winget`           | `apt`                    |
|                          `KDE.Kate` |    Text Editor     |           `winget`           | Native or `apt`          |
|                    `KDE.KDEConnect` |    Productivity    |           `winget`           | `apt`[1](#fn1) |
|                         `KDE.Krita` |       Paint        |           `winget`           | `apt`                    |
|                             `micro` |    Text Editor     |           `choco`            | `deb-get`                |
|              `Microsoft.PowerShell` |   Terminal/Shell   |           `winget`           | `snap`                   |
|        `Microsoft.VisualStudioCode` |    Text Editor     |           `winget`           | `deb-get`                |
|         `Microsoft.WindowsTerminal` |   Terminal/Shell   |           `winget`           | -                        |
|                   `Mozilla.Firefox` |      Browser       |           `winget`           | `apt` with PPA[2](#fn2)  |
|                          `musicbee` |    Music Player    |           `choco`            | -                        |
|                              `nala` |      Wrapper       |              -               | `pacstall`               |
|                              `nano` |    Text Editor     |           `choco`            | Native or `apt`          |
|                          `neofetch` |    System Info     |           `scoop`            | `apt`                    |
|               `Notepad++.Notepad++` |    Text Editor     |           `winget`           | -                        |
|                 `OpenJS.NodeJS.LTS` |      Runtime       |           `winget`           | `apt`                    |
|                          `pacstall` |      Wrapper       |              -               | Binary                   |
|                         `paint.net` |       Paint        |           `choco`            | -                        |
|                       `Pinta.Pinta` |       Paint        |           `winget`           | `apt`                    |
|                     `RARLab.WinRAR` |      Archiver      |           `winget`           | -                        |
|                       `Rufus.Rufus` |    Image Burner    |           `winget`           | -                        |
|                             `scoop` |  Package Manager   |            Binary            | -                        |
|                 `SMPlayer.SMPlayer` |    Video Player    |           `winget`           | `flatpak`                |
|                              `snap` |  Package Manager   |              -               | Native or `apt`          |
|                   `Spotify.Spotify` |    Music Player    |           `winget`           | `deb-get`                |
|                 `Starship.Starship` |   Terminal/Shell   |           `winget`           | Binary                   |
|             `SublimeHQ.SublimeText` |    Text Editor     |           `winget`           | `deb-get`                |
|               `Terminals.Terminals` |   Terminal/Shell   |           `winget`           | -                        |
| `TheDocumentFoundation.LibreOffice` |    Office Suite    |           `winget`           | Native or `apt`          |
|                      `VideoLAN.VLC` |    Video Player    |           `winget`           | Native or `apt`          |
|                   `winaero-tweaker` |   Customization    |           `choco`            | -                        |
|                            `winget` |  Package Manager   | [Microsoft Store][ms-winget] | -                        |
|                  `XnSoft.XnConvert` |  Photo Converter   |           `winget`           | -                        |

<!-- cSpell:Enable -->

## Wait, I saw Google Chrome?? Can't you remove it?

I'd happy to, but technically, *Indonesian being Indonesian* is a thing. I might use the script to help someone in reinstalling apps after reset/format their PC, and majority of them use Google Chrome. Can't argue when [Google Chrome is literally dominating web browser usage by 60% in 2021](https://gs.statcounter.com/browser-market-share/desktop/worldwide/2021).

But I do offer `BraveSoftware.BraveBrowser` and `eloston.ungoogled-chromium` for Chromium-based browsers and `Mozilla.Firefox` for, well, Firefox. You can uninstall unnecessary apps later by using:

* WinGet: `winget uninstall --id <package>`
* Chocolatey: `choco uninstall <package>`
* Scoop: `scoop uninstall <package>`
* Apt/Nala: `apt remove <package>` or `nala remove <package>`
* Snap: `snap remove <package>`
* Flatpak: `flatpak uninstall <package>`

or... you can tick a comment on unwanted apps in the script, its not that hard, folks.

## What is...

### What is `nala` on Linux script?

`nala` is an `apt-get` wrapper. It's a wrapper for `apt-get` that makes it easier to use and more user-friendly. You can check their repo at [volitank/nala](https://github.com/volitank/nala).

### What is `deb-get` on Linux script?

Similar to [#`nala`](#what-is-nala-on-linux-script) case, it's a wrapper. But instead adding PPAs to machine, it will grab the binaries from respective software repositories. You can check their repo at [wimpysworld/deb-get](https://github.com/wimpysworld/deb-get).

## Footnotes

1. <a id="fn1"></a> If DE is GNOME, try to install extension of GSEConnect for best experience.
2. <a id="fn2"></a> Force switch `firefox` from snapd to `apt` with PPA if possible since the browser in `snap` version still feels clunky and slow to use.

<!-- References -->
[ms-winget]: https://apps.microsoft.com/store/detail/app-installer/9NBLGGH4NNS1
