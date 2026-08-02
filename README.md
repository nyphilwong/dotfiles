# dotfiles

Personal config files, checked out directly into `~/.config` on macOS. This
repo *is* `~/.config` — there's no separate dotfiles folder or symlink farm,
just clone it straight into place.

## What's tracked

| Path | App | Notes |
|---|---|---|
| `zsh/` | Zsh | `aliases.zsh`, `paths.zsh` — sourced from `~/.zshrc` (see below) |
| `nvim/` | Neovim | Lazy.nvim-based config, plugins in `nvim/lua/plugins/` |
| `vim/.vimrc` | Vim | Fallback config for plain vim |
| `starship/starship.toml` | [Starship](https://starship.rs) | Shell prompt |
| `ghostty/` | [Ghostty](https://ghostty.org) | Terminal config + `scripts/editor` helper for opening a 3-pane layout |
| `aerospace/.aerospace.toml` | [AeroSpace](https://github.com/nikitabobko/AeroSpace) | Tiling window manager |

## What's *not* tracked (and why)

Per `.gitignore`:

- `git/` — local git excludes file, machine-specific
- `venvs/` — ad-hoc Python virtualenvs, regenerate as needed
- `configstore/` — app-generated local state (e.g. update-notifier caches)
- `.DS_Store`

`~/.zshrc` itself also lives **outside** this repo (it's in `$HOME`, not
`$HOME/.config`), so it has to be recreated by hand on a new machine — see
step 4 below.

## Setting up a new machine

1. **Install Homebrew** (if not already):
   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Install the apps these configs are for:**
   ```sh
   brew install neovim starship tmux nvm
   brew install --cask ghostty nikitabobko/tap/aerospace font-jetbrains-mono-nerd-font
   ```

3. **Clone this repo into `~/.config`.**

   Make sure your GitHub SSH key is set up first (or swap the URL for the
   HTTPS clone) since this repo *is* the SSH config source, chicken-and-egg:
   ```sh
   git clone git@github.com:nyphilwong/dotfiles.git ~/.config
   ```
   If `~/.config` already exists (some apps create it on first run before
   you get here), initialize in place instead:
   ```sh
   cd ~/.config
   git init
   git remote add origin git@github.com:nyphilwong/dotfiles.git
   git fetch origin
   git checkout -f master
   ```

4. **Recreate `~/.zshrc`** (not tracked, since it lives outside `~/.config`):
   ```sh
   cat > ~/.zshrc <<'EOF'
   # Aliases
   [ -f "$HOME/.config/zsh/aliases.zsh" ] && source "$HOME/.config/zsh/aliases.zsh"

   # Paths
   [ -f "$HOME/.config/zsh/paths.zsh" ] && source "$HOME/.config/zsh/paths.zsh"
   EOF
   ```

5. **Restart the shell**, then open `nvim` once — it bootstraps
   [lazy.nvim](https://github.com/folke/lazy.nvim) and installs plugins from
   `nvim/lazy-lock.json` automatically on first launch.

6. **Sanity check:** `starship`, `aerospace`, and `ghostty` should all pick up
   their configs automatically since they read from `~/.config/<app>/` by
   default (XDG convention) — no extra symlinking needed.

### Notes / gotchas

- `zsh/paths.zsh` assumes Homebrew lives at `/opt/homebrew` (Apple Silicon).
  Adjust `paths.zsh` if you're on an Intel Mac (`/usr/local`).
- The Bitwarden SSH agent socket (`$HOME/.bitwarden-ssh-agent.sock`) is
  expected by `paths.zsh` — install the Bitwarden desktop app and enable its
  SSH agent, or comment that line out.
- `zsh/conda.zsh` is currently a no-op (conda init block is commented out) —
  uncomment it if you install miniforge on the new machine.
