# GlazeWM Keybindings

## General Keybindings

| Bindings | Commands | Description |
| :--- | :--- | :--- |
| `alt+h`, `alt+left` | `focus --direction left` | Focus window to the left |
| `alt+l`, `alt+right` | `focus --direction right` | Focus window to the right |
| `alt+k`, `alt+up` | `focus --direction up` | Focus window above |
| `alt+j`, `alt+down` | `focus --direction down` | Focus window below |
| `alt+shift+h`, `alt+shift+left` | `move --direction left` | Move window to the left |
| `alt+shift+l`, `alt+shift+right` | `move --direction right` | Move window to the right |
| `alt+shift+k`, `alt+shift+up` | `move --direction up` | Move window up |
| `alt+shift+j`, `alt+shift+down` | `move --direction down` | Move window down |
| `alt+u` | `resize --width -2%` | Resize width -2% |
| `alt+p` | `resize --width +2%` | Resize width +2% |
| `alt+o` | `resize --height +2%` | Resize height +2% |
| `alt+i` | `resize --height -2%` | Resize height -2% |
| `alt+r` | `wm-enable-binding-mode --name resize` | Enter Resize mode |
| `alt+shift+p` | `wm-enable-binding-mode --name pause` | Enter Pause mode (disable all bindings) |
| `alt+v` | `toggle-tiling-direction` | Toggle tiling direction (Horizontal/Vertical) |
| `alt+shift+space` | `toggle-floating --centered` | Toggle floating mode (centered) |
| `alt+t` | `toggle-tiling` | Toggle tiling mode |
| `alt+f` | `toggle-fullscreen` | Toggle fullscreen |
| `alt+m` | `toggle-minimized` | Minimize window |
| `alt+shift+q` | `close` | Close window |
| `alt+shift+e` | `wm-exit` | Exit GlazeWM |
| `alt+shift+r` | `wm-reload-config` | Reload configuration |
| `alt+shift+w` | `wm-redraw` | Redraw all windows |
| `alt+enter` | `shell-exec wezterm-gui` | Launch WezTerm |

## Workspace Management

| Bindings | Commands | Description |
| :--- | :--- | :--- |
| `alt+s` | `focus --next-workspace` | Focus next workspace |
| `alt+a` | `focus --prev-workspace` | Focus previous workspace |
| `alt+d` | `focus --recent-workspace` | Focus recent workspace |
| `alt+1` ... `alt+9` | `focus --workspace 1` ... | Switch to workspace 1-9 |
| `alt+shift+a` | `move-workspace --direction left` | Move workspace to left monitor |
| `alt+shift+f` | `move-workspace --direction right` | Move workspace to right monitor |
| `alt+shift+d` | `move-workspace --direction up` | Move workspace to up monitor |
| `alt+shift+s` | `move-workspace --direction down` | Move workspace to down monitor |
| `alt+shift+1` ... `alt+shift+9` | `move --workspace 1`, `focus ...` | Move window to workspace 1-9 and follow |

## Binding Modes

### Resize Mode (`alt+r`)

| Bindings | Commands | Description |
| :--- | :--- | :--- |
| `h`, `left` | `resize --width -2%` | Shrink width |
| `l`, `right` | `resize --width +2%` | Grow width |
| `k`, `up` | `resize --height +2%` | Grow height |
| `j`, `down` | `resize --height -2%` | Shrink height |
| `escape`, `enter` | `wm-disable-binding-mode ...` | Exit Resize mode |

### Pause Mode (`alt+shift+p`)

| Bindings | Commands | Description |
| :--- | :--- | :--- |
| `alt+shift+p` | `wm-disable-binding-mode ...` | Exit Pause mode |
