# Aliases
alias vim="nvim"
alias ll="ls -lah"
alias rm="rm -vi"

alias venv="python -m venv .venv"
alias activate="source .venv/bin/activate"

# ghostty editor
# alias editor="~/.config/ghostty/scripts/editor"
editor() {
  ~/.config/ghostty/scripts/editor "$PWD" "$1"
}
