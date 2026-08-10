# Linux/WSL-only shell config. init.zsh only sources this file when
# `uname -s` is Linux, so nothing in here needs its own OS check.

# Neovim from the official tarball (macOS gets it from Homebrew instead)
if [ -d /opt/nvim/bin ]; then
  export PATH="/opt/nvim/bin:$PATH"
fi

# CUDA toolkit (inference host only)
if [ -d /usr/local/cuda/bin ]; then
  export PATH="/usr/local/cuda/bin:$PATH"
fi

# Snap-installed binaries (e.g. glow). /snap/bin isn't on PATH by default.
if [ -d /snap/bin ]; then
  export PATH="/snap/bin:$PATH"
fi

# SSH agent persistence (macOS handles this natively via ssh-agent + the
# system Keychain, see UseKeychain in ~/.ssh/config)
SSH_ENV="$HOME/.ssh/agent-environment"

start_ssh_agent() {
  ssh-agent -s > "$SSH_ENV"
  chmod 600 "$SSH_ENV"
  source "$SSH_ENV" > /dev/null
  ssh-add ~/.ssh/id_ed25519
}

if [ -f "$SSH_ENV" ]; then
  source "$SSH_ENV" > /dev/null
  if ! kill -0 "$SSH_AGENT_PID" 2>/dev/null; then
    # Agent process is gone (reboot, killed, etc.) — start a fresh one.
    start_ssh_agent
  elif ! ssh-add -l > /dev/null 2>&1; then
    # Agent is alive but holds no identities — e.g. an earlier ssh-add in
    # this session failed or was cancelled. kill -0 alone can't see this,
    # so without this check the empty agent would persist all day and every
    # git/ssh call would fall back to prompting for the passphrase directly.
    ssh-add ~/.ssh/id_ed25519
  fi
else
  start_ssh_agent
fi
