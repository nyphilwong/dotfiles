# Shared PATH and tool setup. Portable across macOS and Linux/WSL.
#
# Every platform-specific block is guarded so this file is safe on every
# machine. Nothing here is work-specific or machine-specific: work config lives
# in ~/configs/work-dotfiles, machine overrides in ~/configs/local.
#
# compinit is intentionally NOT here — init.zsh runs it after all layers have
# loaded, so later layers can still extend $fpath.

# Homebrew (macOS)
if [ -d /opt/homebrew/bin ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  # Homebrew: Python 3.12
  export PATH="/opt/homebrew/opt/python@3.12/libexec/bin:$PATH"
fi

# User-level binaries (uv tools, pipx, vendor installers)
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# Bitwarden SSH agent. Guarded on the socket, so it activates only on a machine
# where the Bitwarden desktop agent is actually running and stays inert
# everywhere else.
if [ -S "$HOME/.bitwarden-ssh-agent.sock" ]; then
  export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"
fi

# Starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
command -v starship >/dev/null && eval "$(starship init zsh)"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                    # loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # loads completion
