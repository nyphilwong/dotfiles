# Agent guidance for this repository

This repository **is** `~/.config`. Cloning it puts a git working tree directly
over the directory that every XDG-aware application on the machine writes into.
That single fact drives every rule below.

## Non-negotiable

1. **This repository is public.** Never commit work configuration, employer
   identifiers, credentials, tokens, bearer values, private keys, or
   authentication databases.
2. **Never `git add -A` or `git commit -a` here.** Applications write
   credentials and token databases into this working tree at paths they choose.
   `.gitignore` is the only thing preventing publication, and a new tool can
   create an unignored path at any time. Always stage explicit paths and read
   `git diff --cached` before committing.
3. **Never blind-append to `~/.zshrc`.** It is a one-line loader. Installers
   that append to it cause silent duplication — overwrite it or edit in place.
4. **Stop for human review before any commit or push.**

## Layout

Three layers, loaded in this order by `zsh/init.zsh`:

```text
~/.config/                  this repo — shared, personal, portable, PUBLIC
~/configs/work-dotfiles/    private work overlay (optional)
~/configs/local/            machine-local overrides, mode 700 (optional)
```

Later layers override earlier ones. Layers 2 and 3 are skipped silently when
absent.

**Machine identity is implicit.** A machine's role is which of those paths
exist. There is no profile file, no marker file, and no hostname detection — all
three were deliberately removed. Do not reintroduce them.

## Conventions

- **Platform differences stay in shared files behind guards** (`uname -s`, `-d`,
  `-S`), not in per-OS forks. A block that cannot activate on the wrong machine
  is preferred over a block that is absent from it.
- **`compinit` runs once, in `init.zsh`, after every layer.** Never call it from
  a layer file: later layers extend `$fpath`, and completions registered before
  `$fpath` is final are silently lost.
- **`git/ignore` is tracked; `git/config` is ignored.** `~/.config/git/` is git's
  own user-level config directory, which happens to sit inside this repo. The
  global ignore list is portable and worth sharing. Identity is not — and
  `git config --global` writes to `git/config` on a machine that has no
  `~/.gitconfig`, which would publish it.
- **Commit identity.** Verify with `git var GIT_AUTHOR_IDENT` before committing.
  On a machine whose global git email is a work address, scope an exception with
  `includeIf "gitdir:~/.config/"` in `~/.gitconfig` rather than a repo-local
  setting, which is lost whenever the repo is re-cloned.
- **Files that belong in `$HOME`, not here:** `~/.zshrc` and `~/.vimrc` are
  bootstrap shims, untracked, recreated per machine. See `README.md`.

## Before committing

```sh
git status --short                 # no state dirs, no stray tool files
git diff --cached                  # read every line
git check-ignore -v <suspect path> # confirm state is ignored
git var GIT_AUTHOR_IDENT           # confirm the identity is personal
```
