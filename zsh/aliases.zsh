# Daily Commands
alias vim="nvim"
alias ll="ls -lah"
alias rm="rm -vi"

# Python Dev
alias python="python3.11"
alias pip="pip3"
alias venv="python -m venv .venv"
alias activate="source .venv/bin/activate"

# Git
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gd="git diff"

# tmux
alias tl="tmux ls"
alias ta="tmux attach -t"
alias tn="tmux new -s"
alias tk="tmux kill-session -t" 

# ghostty editor
editor() {
  ~/.config/ghostty/scripts/editor "$PWD" "$1"
}
