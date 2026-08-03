# SSH agent persistence (Linux/WSL only — macOS handles this natively via
# ssh-agent + the system Keychain, see UseKeychain in ~/.ssh/config)
if [[ "$(uname -s)" == "Linux" ]]; then
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
      start_ssh_agent
    fi
  else
    start_ssh_agent
  fi
fi
