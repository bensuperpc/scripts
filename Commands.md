
## archlinux

Scripts for Archlinux and Manjaro

 - [`clean-arch`](#clean-arch)
 - [`update-arch`](#update-arch)

## archive

 - [`extract`](#extract)

## audio

Scripts for audio (FFMPEG ...)

 - [`extract-audio`](#extract-audio)

## cryptography

For cryptography and security

 - [`digital-signature-check-RSA`](#digital-signature-check-RSA)
 - [`digital-signature-RSA`](#digital-signature-RSA)
 - [`cryptr`](#cryptr)

## debian

Scripts for Debian and Ubuntu

 - [`clean-debian`](#clean-debian)
 - [`update-debian`](#update-debian)

## development

Scripts for C/C++ development and cross platform

 - [`format-code`](#format-code)
 - [`cmake-builder`](#cmake-builder)
 - [`ninja-builder`](#ninja-builder)
 - [`dockcross-builder`](#dockcross-builder)
 - [`meson-builder`](#meson-builder)

## file

For file management or backup

 - [`rsync-archive`](#rsync-archive)
 - [`rsync-check`](#rsync-check)
 - [`rsync-rsa`](#rsync-rsa)
 - [`compress-max`](#compress-max)
 - [`compress-secu`](#compress-secu)
 - [`disable-baloo`](#disable-baloo)

## game

To create archives of game saves

 - [`save-mindustry-linux`](#save-mindustry-linux)
 - [`save-satisfactory-linux`](#save-satisfactory-linux)
 - [`save-terraria-linux`](#save-terraria-linux)
 - [`save-7DaysToDie-linux`](#save-7DaysToDie-linux)

## git

 - [`git-apply-patch`](#git-apply-patch)
 - [`git-changelog`](#git-changelog)
 - [`git-clone-all`](#git-clone-all)
 - [`git-commit-undo`](#git-commit-undo)
 - [`git-commit`](#git-commit)
 - [`git-create-patch`](#git-commit)
 - [`git-find-big`](#git-find-big)
 - [`git-sync-submodule`](#git-sync-submodule)
 - [`git-update-recursive`](#git-update-recursive) 

## hardware

 - [`temperature`](#temperature) 

## image

 - [`image_jpeg_to_avif_aom`](#image_jpeg_to_avif_aom)
 - [`image_jpeg_to_avif_rav1e`](#image_jpeg_to_avif_rav1e)
 - [`image_jpeg_to_heic`](#image_jpeg_to_heic)
 - [`image_jpeg_to_webp`](#image_jpeg_to_webp)
 - [`image_png_to_heic`](#image_png_to_heic)
 - [`image_png_to_webp`](#image_png_to_webp)

## internet

 - [`sms-free`](#sms-free)

## linux

 - [`clean-system`](#clean-system)
 - [`find-broken-link`](#find-broken-link)
 - [`find-duplicate`](#find-duplicate)
 - [`find-empty`](#find-empty)
 - [`history-count`](#history-count)
 - [`make-bootable-usb`](#make-bootable-usb)
 - [`passwordgen`](#passwordgen)
 - [`replace-recursive`](#replace-recursive)
 - [`sysinfo`](#sysinfo)
 - [`update-grub`](#update-grub)

## hash

 - [`hash_check`](#hash_check)
 - [`hash_gen`](#hash_gen)
 - [`hash`](#hash)

## uuid

 - [`uuid`](#uuid)
 - [`uuid-bash`](#uuid-bash)

## partition

For creating partitions (encrypted or in RAM for example)

 - [`luks`](#luks)
 - [`mount-ram`](#mount-ram)

## video

For encoding, creating, recording or downloading videos

 - [`screen-capture`](#screen-capture)
 - [`screen-capture-webcam`](#screen-capture-webcam)
 - [`gource-nvenc`](#gource-nvenc)
 - [`gource-h265`](#gource-h265)
 - [`h265-nvenc`](#h265-nvenc)
 - [`youtube-dl-playlist-full`](#youtube-dl-playlist-full)
 - [`youtube-dl-playlist-audio`](#youtube-dl-playlist-audio)
 - (WIP)
### clean-arch

Clean ArchLinux and Manjaro (Remove old packages...)

```bash
$ sudo clean-arch
```

### update-arch

Update ArchLinux and Manjaro

```bash
$ sudo clean-arch
```

### extract

Script to extract many type of archive (7z, rar, zip, iso...)

```bash
$ extract archive1.zip archive2.7z archive3.rar
```

### extract-audio

Extract audio from video files, with ffmpeg (without re-encoding)

```bash
$ extract-audio myvideo.mkv myextractedsound.mp3
```

### digital-signature-check-RSA

Check document signature with public key and certificate

```bash
$ PUBLIC_KEY=mypublic.pem digital-signature-check-RSA <file>
```

### digital-signature-RSA

Generate (and check) certificate with RSA key (and generate hash by rhash)

```bash
$ digital-signature-RSA sign <file> <password>
$ PUBLIC_KEY=mypublic.pem digital-signature-RSA check <file>
```

### cryptr

A simple shell utility for encrypting and decrypting files using OpenSSL.

```bash
$ cryptr encrypt <file>
$ cryptr decrypt <file.aes>
```

### clean-debian

Clean debian (and ubuntu), remove old packages...

```bash
$ sudo clean-debian
```

### update-debian

Update debian (and ubuntu), by apt update and dist-upgrade

```bash
$ sudo update-debian
```

### format-code

Format all code recursively with clang-format (C/C++...)

```bash
$ format-code # With LLVM style (By default)
$ format-code webkit # Withwebkit
$ format-code my-style.txt # With custom style
```

### cmake-builder

Build cmake project (and create build folder)
Can accept cmake arguments

```bash
$ cmake-builder # Without argument
$ cmake-builder -DCMAKE_BUILD_TYPE=Release # With argument
```

### ninja-builder

Build cmake project with ninja build (and create build folder)
Can accept cmake arguments

```bash
$ ninja-builder # Without argument
$ ninja-builder -DCMAKE_BUILD_TYPE=Release # With argument
```

### meson-builder

Build meson project (and create build folder)
Can accept meson arguments

```bash
$ meson-builder # Without argument
```

### dockcross-builder

Build cmake project with ninja (and create build folder) in docker (cross platform
Can accept CMake arguments.

Dockcross images list:
*android-arm android-arm64 web-wasm*
*linux-x86 linux-x64 linux-mips linux-x64-clang*
*manylinux1-x64 manylinux1-x86 manylinux2010-x64 manylinux2010-x86 manylinux2014-x64 manylinux2014-x86 manylinux2014-aarch64* 
*windows-static-x86 windows-static-x64 windows-static-x64-posix windows-shared-x86 windows-shared-x64 windows-shared-x64-posix*
*linux-arm64 linux-arm64-musl linux-armv7 linux-armv7a linux-armv7l-musl linux-armv6 linux-armv6-musl linux-armv5 linux-armv5-musl*
*linux-ppc64le linux-riscv64 linux-riscv32 linux-m68k-uclibc linux-s390x*

```bash
$ dockcross-builder <dockcross image> <CMake arguments>
```

### rsync-archive

Make perfect copy (backup) directory with rsync

```bash
$ rsync-archive <source directory> <destination directory>
```

### rsync-check

Make perfect copy (backup) directory with rsync and checksum (Can take many hours with big files)

```bash
$ rsync-check <source directory> <destination directory>
```

### rsync-rsa

Make copy directory with rsync and SSH

```bash
$ rsync-archive <port> <key-file> <source directory> <destination directory>
```

### compress-max

Compress directory with 7z with maximum settings

```bash
$ compress-max <directory>
```

### compress-secu

Compress directory with 7z with maximum settings (but without solid archive, more solid against corruption

```bash
$ compress-secu <directory>
```

### disable-baloo

Disable baloo extractor (with KDE plasma)

```bash
$ sudo disable-baloo
```

### save-mindustry-linux

Create archive from save files in mindustry in Linux

```bash
$ save-mindustry-linux
```

### save-satisfactory-linux

Create archive from save files in satisfactory in Linux

```bash
$ save-satisfactory-linux
```

### save-terraria-linux

Create archive from save files in terraria in Linux

```bash
$ save-terraria-linux
```

### save-7DaysToDie-linux

Create archive from save files in 7DaysToDie in Linux

```bash
$ save-7DaysToDie-linux
```

### git-apply-patch

Apply a git patch(s)

```bash
$ git-apply-patch fix1.patch fix2.patch fix3.patch...
```

### git-changelog

Generate git changelog

```bash
$ git-changelog
```

### git-clone-all

Clone git repository with all tags, submodules...

```bash
$ git-clone-all https://github.com/bensuperpc/scripts.git https://github.com/bensuperpc/scripts.git ...
```

### git-commit-undo

Undo last commit (not push)

```bash
$ git-commit-undo
```

### git-commit

Create commit with signature

```bash
$ git-commit "title and comment"
$ git-commit "title" "comment"
```

### git-create-patch

Create git patch

Create patch from last commit:

```bash
$ git-create-patch
```

Create patch from last commit to x commit:

```bash
$ git-create-patch 5 # HEAD to 5 last commit
```

Create patch from hash1 or tag1 to hash2 or tag2:

```bash
$ git-create-patch v1.0.0 v1.1.0
```

### git-find-big

Display biggest files in git repository

```bash
$ git-find-big
```

### git-sync-submodule

Update submodule to latest commit

```bash
$ git-sync-submodule
```

### git-update-recursive

Update repository to latest version in remote (with submodule)

```bash
$ git-update-recursive
```

### temperature

Get temperature from CPU, HDD ect...

```bash
$ temperature
```

### image_jpeg_to_avif_aom

Convert all jpeg to images avif with AOM

```bash
$ image_jpeg_to_avif_aom
```

### image_jpeg_to_avif_rav1e

Convert all jpeg to images avif with rav1e

```bash
$ image_jpeg_to_avif_rav1e
```

### image_jpeg_to_heic

Convert all jpeg images to heic

```bash
$ image_jpeg_to_heic
```

### image_jpeg_to_webp

Convert all jpeg images to webp with cwebp

```bash
$ image_jpeg_to_webp
```

### image_png_to_heic

Convert all png images to heic

```bash
$ image_png_to_heic
```

### image_png_to_webp

Convert all png images to webp with cwebp

```bash
$ image_png_to_webp
```

### sms-free

Send SMS with Free Mobile API (From script to smartphone)

```bash
$ sms-free <user> <API key> <Message (in quotes)>
```

### clean-system

Clean linux system (Tested with ArchLinux and Manjaro)

```bash
$ sudo clean-system
```

### find-broken-link

Find all broken symbole links

```bash
$ find-broken-link
```

### find-duplicate

Find all duplicate files (Calc with sha256)

```bash
$ find-duplicate
```

### find-empty

Find all empty files

```bash
$ find-empty
```

### history-count

Calculate the number of identical commands in the bash history

```bash
$ history-count
```

### make-bootable-usb

Create bootable USB with ISO

```bash
$ make-bootable-usb <iso path> <device path (USB ...)>
```

### passwordgen

Generate strong password

```bash
$ passwordgen # With 48 chars
$ passwordgen X # With X chars
```

### replace-recursive

Replace string in files recursively

```bash
$ replace-recursive <STR1> <STR2> <Extension (wihout point)>
```

### sysinfo

Generate archive with all system info

```bash
$ sudo sysinfo
```

### update-grub

Update Grub

```bash
$ sudo update-grub
```

### hash_check

Check hash file(s)

```bash
$ hash_check <checksums file>
```

### hash_gen

Generate hash of directory

```bash
$ hash_gen <directory>
```

### hash

Generate hash of directory

```bash
$ hash <directory>
```

### uuid

Generate uuid

```bash
$ uuid
```

### uuid-bash

Generate uuid in bash

```bash
$ uuid-bash
```

### luks

Make luks (encrypted) partition with password

```bash
$ sudo luks <Device> <Label>
```

### mount-ram

Mount directory in RAM

```bash
$ mount-ram <path to mount> <size (in MB/Mo)>
```

### screen-capture

Screen capture (Video only) with ffmpeg and x11grab

```bash
$ screen-capture --output <output file> --preset fast --resolution 1920x1080
$ screen-capture --output <output file> --screen :0 --framerate 60 --lib libx265
```

More info :

```bash
$ screen-capture --help
```

### screen-capture-webcam

Screen capture (Video only) with ffmpeg, x11grab, and webcam

```bash
$ screen-capture-webcam <output file>
```

### gource-nvenc

Generate video with all commit and repository evolution (with nvenc)

```bash
$ gource-nvenc <output file>
```

### gource-h265

Generate video with all commit and repository evolution (with H265)

```bash
$ gource-h265 <output file>
```

### h265-nvenc

Convert video to h265 (with nvenc)

```bash
$ h265-nvenc <input file> <output file>
```

### youtube-dl-playlist-full

Download playlist video with best quality

```bash
$ youtube-dl-playlist-full <URL>
```

### youtube-dl-playlist-audio

Download playlist audio only with best quality

```bash
$ youtube-dl-playlist-audio <URL>
```
