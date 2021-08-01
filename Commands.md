
## archlinux

 - [`clean-arch`](#clean-arch)
 - [`update-arch`](#update-arch)

## archive

 - [`extract`](#extract)

## audio

 - [`extract-audio`](#extract-audio)

## cryptography
 - [`digital-signature-check-RSA`](#digital-signature-check-RSA)
 - [`digital-signature-RSA`](#digital-signature-RSA)

## debian

 - [`clean-debian`](#clean-debian)
 - [`update-debian`](#update-debian)

## development

 - [`format-code`](#format-code)
 - [`cmake-builder`](#cmake-builder)
 - [`ninja-builder`](#ninja-builder)
 - [`dockcross-builder`](#dockcross-builder)
 - [`meson-builder`](#meson-builder)

## file

 - [`rsync-archive`](#rsync-archive)
 - [`rsync-check`](#rsync-check)
 - [`rsync-rsa`](#rsync-rsa)
 - [`compress-max`](#compress-max)
 - [`compress-secu`](#compress-secu)
 - [`disable-baloo`](#disable-baloo)

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
