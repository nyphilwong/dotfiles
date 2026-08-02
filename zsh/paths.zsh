# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
# Homebrew: Python 3.12
export PATH="/opt/homebrew/opt/python@3.12/libexec/bin:$PATH"

# Autocomplete
autoload -Uz compinit
compinit

# Bitwarden SSH Agent
export SSH_AUTH_SOCK=$HOME/.bitwarden-ssh-agent.sock

# Starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

# NeoVim
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

