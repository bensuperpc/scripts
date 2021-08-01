

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
