# dotfiles

Personal config files, checked out directly into `~/.config`. This repo *is*
`~/.config` — there's no separate dotfiles folder and no symlink farm for
XDG-aware apps, just clone it straight into place.

## Layering

Shell configuration loads in three layers, in order:

```text
~/.config/                  this repo — shared, personal, portable, public
~/configs/work-dotfiles/    private work overlay          (optional)
~/configs/local/            machine-local overrides, 700  (optional)
```

`zsh/init.zsh` is the single entry point and owns that order. Later layers
override earlier ones, and layers 2 and 3 are skipped silently when absent — so
a fresh clone works with nothing else installed.

**Machine roles are implicit.** A machine's role is simply which of those paths
exist. There is no profile file, no marker file, and no hostname detection:

| Machine | Layers present |
|---|---|
| Personal laptop | this repo only |
| Personal Linux/WSL | this repo only |
| Work laptop | this repo + private overlay |

Platform differences live in the shared files behind guards (`uname -s`, `-d`,
`-S`) rather than in per-OS forks, so the same `paths.zsh` is correct everywhere:
Homebrew activates only where `/opt/homebrew` exists, CUDA only on Linux with the
toolkit installed, the Bitwarden SSH agent only where its socket is live.

## What's tracked

| Path | App | Notes |
|---|---|---|
| `zsh/init.zsh` | Zsh | Entry point; loads all layers, then runs `compinit` |
| `zsh/aliases.zsh` | Zsh | Shared aliases |
| `zsh/paths.zsh` | Zsh | Shared PATH and tool setup, all guarded |
| `zsh/linux.zsh` | Zsh | Linux-only SSH agent persistence |
| `nvim/` | Neovim | lazy.nvim config, plugins in `nvim/lua/plugins/` |
| `vim/.vimrc` | Vim | Fallback config for plain vim |
| `starship/starship.toml` | [Starship](https://starship.rs) | Shell prompt |
| `ghostty/` | [Ghostty](https://ghostty.org) | Terminal config + `scripts/editor` 3-pane helper |
| `tmux/` | tmux | `tmux.conf` entry point, `conf/` fragments |
| `git/ignore` | Git | **Global** ignore list, applied to every repo on the machine |
| `AGENTS.md` | — | Rules for coding agents working in this repo |

## What's *not* tracked (and why)

Because this repo is `~/.config`, applications write their own state into the
working tree. Per `.gitignore`, that state stays on disk and out of git:

- `gcloud/`, `gh/` — credentials and token databases
- `cagent/`, `cmux/`, `mlflow/` — generated IDs and telemetry
- `venvs/` — ad-hoc virtualenvs, regenerate as needed
- `git/config` — git's own machine-level config, including commit identity
- `*.log`, `configstore`, `.DS_Store`

**This repo is public, so never `git add -A` here.** Stage explicit paths. See
`AGENTS.md`.

Two bootstrap files live in `$HOME`, outside this repo, and are recreated by hand
per machine: `~/.zshrc` and `~/.vimrc`.

## Setting up a new machine

1. **Install Homebrew** (macOS):
   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Install the apps these configs are for:**
   ```sh
   brew install neovim starship tmux nvm
   brew install --cask ghostty font-jetbrains-mono-nerd-font
   ```

3. **Clone this repo into `~/.config`.** If `~/.config` already exists — most
   apps create it on first run — initialize in place instead of cloning:
   ```sh
   git clone git@github.com:nyphilwong/dotfiles.git ~/.config

   # or, if ~/.config already exists:
   cd ~/.config
   git init && git remote add origin git@github.com:nyphilwong/dotfiles.git
   git fetch origin && git reset --hard origin/master
   ```
   `reset --hard` overwrites tracked files but never touches untracked files, so
   existing application state is left alone.

4. **Create `~/.zshrc`** (one line, not tracked because it lives outside
   `~/.config`):
   ```sh
   cat > ~/.zshrc <<'EOF'
   [ -f "$HOME/.config/zsh/init.zsh" ] && source "$HOME/.config/zsh/init.zsh"
   EOF
   ```

5. **Create `~/.vimrc`** so plain vim finds its config:
   ```sh
   cat > ~/.vimrc <<'EOF'
   if filereadable(expand('~/.config/vim/.vimrc'))
     execute 'source' fnameescape(expand('~/.config/vim/.vimrc'))
   endif
   EOF
   ```

6. **Check the commit identity** before committing anything:
   ```sh
   git -C ~/.config var GIT_AUTHOR_IDENT
   ```
   If the machine's global git email is a work address, add an exception to
   `~/.gitconfig` rather than a repo-local setting, which is lost on re-clone:
   ```ini
   [includeIf "gitdir:~/.config/"]
   	path = ~/.gitconfig-personal
   ```

7. **Restart the shell**, then open `nvim` once — it bootstraps
   [lazy.nvim](https://github.com/folke/lazy.nvim) and installs plugins from
   `nvim/lazy-lock.json` on first launch.

8. **Sanity check:** `starship`, `ghostty`, and `tmux` pick up their configs
   automatically from `~/.config/<app>/` (XDG), no symlinking needed.

## Upgrading an existing checkout to the layered layout

For a machine that already has `~/.config` as a clone of this repo, from before
`zsh/init.zsh` existed:

1. **Check for local edits first** — step 2 destroys uncommitted work:
   ```sh
   git -C ~/.config status
   ```
   Stop and classify anything dirty before continuing.

2. **Sync.** Use `fetch` + `reset --hard`, not `pull` — history was rewritten:
   ```sh
   git -C ~/.config fetch origin
   git -C ~/.config reset --hard origin/master
   ```

3. **Replace `~/.zshrc` with the one-liner from step 4 above. Do this in the same
   sitting.** `compinit` moved out of `paths.zsh` and into `init.zsh`, so a
   `~/.zshrc` that still sources `aliases.zsh` and `paths.zsh` directly will
   appear to work while silently losing tab completion.

4. Create `~/.vimrc` if absent (step 5 above), and check the identity (step 6).

5. **Confirm no application state is newly exposed:**
   ```sh
   git -C ~/.config status --porcelain
   ```
   Anything untracked that isn't covered by `.gitignore` needs a PR to add it.

6. **Verify the guards fired as expected for that machine:**
   ```sh
   echo $SSH_AUTH_SOCK        # Bitwarden socket only where the agent runs
   echo $PATH | tr ':' '\n'   # CUDA / /opt/nvim only on Linux where installed
   tmux -V                    # CSI-u is guarded for tmux < 3.5
   nvim --headless +q
   ```

## Notes / gotchas

- `zsh/paths.zsh` assumes Homebrew at `/opt/homebrew` (Apple Silicon). Intel Macs
  use `/usr/local`.
- `tmux/conf/10-options.conf` guards `extended-keys-format csi-u` behind a tmux
  3.5+ check, because Ubuntu 24.04 still ships 3.4.
- `git/ignore` is git's **global** ignore file and applies to every repo on the
  machine. It works with no configuration, since git's default
  `core.excludesFile` is `$XDG_CONFIG_HOME/git/ignore`.
