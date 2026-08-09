# tmux configuration

This configuration is loaded automatically by tmux from:

```text
~/.config/tmux/tmux.conf
```

## Basic workflow

```bash
tmux new -s work
tmux ls
tmux attach -t work
```

Detach with `Ctrl-a d`. The tmux server and its sessions continue running.

## Prefix

The tmux prefix is `Ctrl-a`. Most tmux commands are entered by pressing the
prefix, releasing it, then pressing the command key.

| Keys | Action |
| --- | --- |
| `Ctrl-a d` | Detach from the current session |
| `Ctrl-a c` | New window in the current directory |
| `Ctrl-a |` | Split left/right |
| `Ctrl-a -` | Split top/bottom |
| `Ctrl-a h/j/k/l` | Move between panes |
| `Ctrl-a H/J/K/L` | Resize the active pane |
| `Ctrl-a z` | Zoom/unzoom the active pane |
| `Ctrl-a r` | Reload this configuration |
| `Ctrl-a [` | Enter vi-style copy mode |

## Mouse and copying on macOS

Mouse support is enabled. Scrolling over a pane enters tmux copy mode and lets
you inspect that pane's scrollback. A drag selects text in the pane where the
drag begins; release or press `y`/Enter in copy mode to copy it to the macOS
system clipboard.

Use `Ctrl-a [` when keyboard scrolling is preferable. In copy mode, `h/j/k/l`
move the selection cursor, Space starts a selection, and `y` copies it.

## Pi and modified keys

`extended-keys` is enabled using CSI-u, which allows applications such as Pi
to distinguish modified keys like Shift+Enter and Ctrl+Enter. This requires
tmux 3.5 or newer; this machine uses tmux 3.7b.

After changing server-level options, restart the tmux server if an existing
server does not pick them up:

```bash
tmux kill-server
tmux new -s work
```

## Porting

The portable files are `tmux.conf`, `conf/10-options.conf`,
`conf/20-keybindings.conf`, and `conf/30-status.conf`. The macOS file is loaded
only on Darwin. A future Linux-specific file can be added without changing
the portable core.

There is no work- or machine-specific tmux overlay — everything here is meant
to be identical on every machine.
