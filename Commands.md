
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
