# ~/.config/zsh/init.zsh
#
# Single entry point for the shell configuration. ~/.zshrc sources only this
# file, so the loading order lives here in version control instead of in an
# untracked file that drifts between machines.
#
# Layers, in order:
#
#   1. shared personal base   this repo (public)
#   2. private work overlay   ~/configs/work-dotfiles     (optional)
#   3. machine-local          ~/configs/local             (optional)
#
# Later layers override earlier ones. Layers 2 and 3 are skipped silently when
# absent, so a fresh clone works with no extra setup and no machine needs to
# declare what it is — a machine's role is simply which of these paths exist.

# --- 1. shared personal base --------------------------------------------------
for _f in aliases paths linux; do
  [ -f "$HOME/.config/zsh/$_f.zsh" ] && source "$HOME/.config/zsh/$_f.zsh"
done
unset _f

# --- 2. private work overlay --------------------------------------------------
# Presence of the repository is the opt-in; cloning it requires access to a
# private repo. There is deliberately no marker file and no hostname check.
[ -f "$HOME/configs/work-dotfiles/zsh/work.zsh" ] && source "$HOME/configs/work-dotfiles/zsh/work.zsh"

# --- 3. machine-local overrides -----------------------------------------------
# Last, so it can override anything above without editing a tracked file.
[ -f "$HOME/configs/local/zsh/local.zsh" ] && source "$HOME/configs/local/zsh/local.zsh"

# --- completions --------------------------------------------------------------
# Must run after every layer, since layers 2 and 3 may extend $fpath.
autoload -Uz compinit && compinit
