<!-- markdownlint-disable MD026 MD033 -->
<!-- cSpell:words Asus choco eloston Flatpak neofetch pacstall popey ungoogled volitank wimpysworld winfetch winget Zorin -->

# initApps

My Personal scripts to download and install scripts for first time run in Linux and Windows. [Unlicensed](LICENSE)-ly licensed.

Note that because this is my personal repo, then the language used in this repo is not the formal one. ¯\\\_(ツ)_/¯

## Disclaimer for Linux Users

1. GNU/Linux in this repo refers to Ubuntu/Debian derivatives. Unfortunately, I don't have prior experience with other Linux derivatives.

2. This script will remove `snap` from your system if it is installed. Comment out the line in [`Linux`](Linux) before init if you don't want to remove it.

   Snap uninstall script provided by [`popey/unsnap`](https://github.com/popey/unsnap).

## Package Source Priority

In this repo, the package source priority is:

* **Windows**: `winget` > `choco` > `scoop` > Binary
* **Linux**: `apt-get`/`nala` > `deb-get` > `flatpak` > `pacstall` > Binary

## What apps will be installed?

This script will install the following apps:

<!-- cSpell:Disable --->

| Package                | Maintainer              |     License     |      Category      |       Windows Source        |            Linux Source             |
| ---------------------- | ----------------------- | :-------------: | :----------------: | :-------------------------: | :---------------------------------: |
| 7zip                   | Igor Pavlov             |    LGPL 2.1     |      Archiver      |          `winget`           |                  -                  |
| Audacity               | Audacity                |     GPL 3.0     |    Audio Editor    |          `winget`           |                `apt`                |
| balenaEtcher           | Balena                  |   Apache 2.0    |    Image Flash     |          `winget`           |              `deb-get`              |
| Brave Browser          | Brave Software          |     MPL 2.0     |      Browser       |          `winget`           |              `deb-get`              |
| calibre                | kovidgoyal              |     GPL 3.0     |    Ebook Reader    |          `winget`           |                `apt`                |
| choco                  | Chocolatey              |   Apache 2.0    |  Package Manager   |           Binary            |                  -                  |
| Clink                  | chrisant996             |     GPL 3.0     |    Shell Prompt    |          `winget`           |                  -                  |
| cURL                   | cURL                    |      curl       |   Data Transfer    |           `choco`           |           Native or `apt`           |
| Cygwin                 | Cygwin                  |      LGPL       |       Shell        |          `winget`           |                  -                  |
| deb-get                | wimpysworld             |       MIT       |  Package Manager   |              -              |               Binary                |
| EarTrumpet             | File-New-Project        |       MIT       |     Customizer     |          `winget`           |                  -                  |
| Epic Games Store       | Epic Games              |   Proprietary   |       Games        |          `winget`           |                  -                  |
| Firefox                | Mozilla                 |     MPL 2.0     |      Browser       |          `winget`           |      `apt`[<sup>2</sup>](#fn2)      |
| Flatpak                | Flatpak                 |    LGPL 2.1     |  Package Manager   |              -              |           Native or `apt`           |
| git                    | Git                     |     GPL 2.0     |  Version Control   |          `winget`           |               Native                |
| GitHub CLI             | GitHub                  |       MIT       |  Version Control   |          `winget`           |              `deb-get`              |
| GitKraken              | GitKraken               |   Proprietary   |  Version Control   |          `winget`           |              `deb-get`              |
| Google Chrome          | Google                  |   Proprietary   |      Browser       |          `winget`           |              `deb-get`              |
| GSConnect              | GSConnect               |     GPL 2.0     |    Productivity    |              -              |           Gnome Extension           |
| iTunes                 | Apple                   |   Proprietary   |    Music Player    |          `winget`           |                  -                  |
| K-Lite Codec Pack Mega | Codec Guide             |   Proprietary   |       Codecs       |          `winget`           |                  -                  |
| Kate                   | KDE                     |    LGPL, GPL    |    Text Editor     |          `winget`           |           Native or `apt`           |
| KDE Connect            | KDE                     |    LGPL, GPL    |    Productivity    |          `winget`           | Native or `apt`[<sup>1</sup>](#fn1) |
| Krita                  | KDE                     |    LGPL, GPL    |       Paint        |          `winget`           |                `apt`                |
| LibreOffice            | The Document Foundation |     MPL 2.0     |    Office Suite    |          `winget`           |           Native or `apt`           |
| micro                  | zyedidia                |       MIT       |    Text Editor     |           `choco`           |              `deb-get`              |
| MusicBee               | Steven Mayall           |   Proprietary   |    Music Player    |           `choco`           |                  -                  |
| nala                   | volitank                |     GPL 3.0     |      Wrapper       |              -              |             `pacstall`              |
| nano                   | GNU                     |     GPL 3.0     |    Text Editor     |           `choco`           |           Native or `apt`           |
| neofetch               | dylanaraps              |       MIT       |    System Info     |              -              |                `apt`                |
| Node.js LTS            | OpenJS                  |       MIT       |      Runtime       |          `winget`           |                `apt`                |
| Notepad++              | Don Ho                  |     GPL 3.0     |    Text Editor     |          `winget`           |                  -                  |
| OnlyOffice             | Ascensio System SIA     |    AGPL 3.0     |    Office Suite    |          `winget`           |              `deb-get`              |
| osu!                   | ppy                     |   Proprietary   |       Games        |          `winget`           |                  -                  |
| pacstall               | pacstall                |     GPL 3.0     |  Package Manager   |              -              |               Binary                |
| Paint.NET              | dotPDN                  |   Proprietary   |       Paint        |          `winget`           |                  -                  |
| Pandoc                 | JohnMacFarlane          |     GPL 2.0     | Document Converter |          `winget`           |                `apt`                |
| PeaZip                 | peazip                  |    LGPL 3.0     |      Archiver      |          `winget`           |              `flatpak`              |
| Pinta                  | Pinta Project           |       MIT       |       Paint        |          `winget`           |                `apt`                |
| PotPlayer              | DAUM                    |   Proprietary   |    Video Player    |          `winget`           |                  -                  |
| PowerShell Core        | Microsoft               |       MIT       |       Shell        |          `winget`           |              `deb-get`              |
| Rufus                  | Pete Batard             |     GPL 3.0     |    Image Flash     |          `winget`           |                  -                  |
| scoop                  | Scoop Contributor       | Unlicensed, MIT |  Package Manager   |           Binary            |                  -                  |
| SMPlayer               | SMPlayer                |     GPL 2.0     |    Video Player    |          `winget`           |              `flatpak`              |
| Spotify                | Spotify                 |   Proprietary   |    Music Player    |          `winget`           |              `deb-get`              |
| Starship               | Starship                |       ISC       |    Shell Prompt    |          `winget`           |               Binary                |
| Steam                  | Valve                   |   Proprietary   |       Games        |          `winget`           |         `apt` or `deb-get`          |
| Taiga                  | erengy                  |     GPL 3.0     |   Media Tracker    |          `winget`           |                  -                  |
| Thunderbird            | Mozilla                 |     MPL 2.0     |   E-mail Client    |          `winget`           |                `apt`                |
| Ungoogled Chromium     | ungoogled-software      |  BSD 3-clause   |      Browser       |          `winget`           |           `apt` with PPA            |
| Visual Code++ Redist   | Microsoft               |   Proprietary   |      Library       |          `winget`           |                  -                  |
| Visual Studio Code     | Microsoft               |       MIT       |    Text Editor     |          `winget`           |              `deb-get`              |
| VLC Media Player       | VideoLAN                |     GPL 2.0     |    Video Player    |          `winget`           |           Native or `apt`           |
| Warp                   | Cloudflare              |   Proprietary   |       Tunnel       |          `winget`           |                `apt`                |
| wget                   | GNU                     |     GPL 3.0     |   Data Transfer    |           `choco`           |           Native or `apt`           |
| WinAero Tweaker        | Sergey Tkachenko        |   Proprietary   |     Customizer     |           `choco`           |                  -                  |
| Windows Terminal       | Microsoft               |       MIT       |      Terminal      |          `winget`           |                  -                  |
| winfetch               | kiedtl                  |       MIT       |    System Info     | `scoop`[<sup>3</sup>](#fn3) |                  -                  |
| winget                 | Microsoft               |       MIT       |  Package Manager   |       Microsoft Store       |                  -                  |
| WinRAR                 | RARLab                  |   Proprietary   |      Archiver      |          `winget`           |                  -                  |
| WizTree                | Antibody Software       |   Proprietary   | Storage Management |          `winget`           |                  -                  |
| XnConvert              | XnSoft                  |   Proprietary   |  Image Converter   |          `winget`           |                  -                  |

<!-- cSpell:Enable -->

## Wait, I saw Google Chrome?? Can't you remove it?

I'd happy to, but technically, *Indonesian being Indonesian* is a thing. I might use the script to help someone in reinstalling apps after reset/format their PC, and majority of them use Google Chrome. Can't argue when [Google Chrome is literally dominating web browser usage by 60% in 2021](https://gs.statcounter.com/browser-market-share/desktop/worldwide/2021).

But I do offer Brave Browser and Ungoogled Chromium for Chromium-based browsers and Firefox for, well, Firefox. You can uninstall unnecessary apps later by using:

* Apt/Nala: `apt remove <package>` or `nala remove <package>`
* Chocolatey: `choco uninstall <package>`
* Flatpak: `flatpak uninstall <package>`
* Pacstall: `pacstall -R <package>`
* Scoop: `scoop uninstall <package>`
* WinGet: `winget uninstall --id <package>`

or... you can tick a comment on unwanted apps in the script, its not that hard, folks.

## Why on Linux Source Priority, you're using native package (deb) than `flatpak`?

This repo project also considers to be used on low spec machines. I owned a 2015 Asus notebook running Ubuntu 22.04, Zorin OS 16.1, and Fedora Workstation 35, and some `flatpak` apps I tried to open loads very slow compared to native package (deb) apps.

However, if the apps only released on `flatpak`, I'll install the apps although previously mentioned issue. ~~I'm looking at you, GNOME Circle apps~~ 👀

## What is...

### What is `nala` on Linux script?

`nala` is an `apt-get` wrapper. It's a wrapper for `apt-get` that makes it easier to use and more user-friendly. You can check their repo at [volitank/nala](https://github.com/volitank/nala).

### What is `deb-get` on Linux script?

Similar to [#`nala`](#what-is-nala-on-linux-script) case, it's a wrapper. But instead adding PPAs to machine, it will grab the binaries from respective software repositories. You can check their repo at [wimpysworld/deb-get](https://github.com/wimpysworld/deb-get).

## Contributing

To contribute, please fork this repo and make a PR. Use Visual Studio Code for the best experience, as the linters and formatted were recommended to install by default when opening the workspace for the first time.

## Footnotes

1. <a id="fn1"></a> If DE is GNOME, try to install extension of GSEConnect for best experience.
2. <a id="fn2"></a> Force switch `firefox` from `snap` to `apt` with PPA if possible since the browser in `snap` version still feels clunky and slow to use.
3. <a id="fn3"></a> Because `neofetch`'s nature built for Linux, we use `winfetch` as alternative in Windows. The package is aliased to `neofetch` in Windows.

<!-- References -->
[ms-winget]: https://apps.microsoft.com/store/detail/app-installer/9NBLGGH4NNS1
