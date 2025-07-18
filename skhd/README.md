# Keyboard Shortcuts (SKHD)

This document contains all keyboard shortcuts for window management and system control using SKHD (Simple Hotkey Daemon) with Yabai.

## Navigation

### Window Focus
Move focus between windows in the current space:
- `Alt + h` - Focus window to the left
- `Alt + j` - Focus window below
- `Alt + k` - Focus window above
- `Alt + l` - Focus window to the right

### Display Focus
Switch focus between external displays:
- `Alt + s` - Focus display to the left
- `Alt + g` - Focus display to the right

### Space Navigation
Navigate between desktop spaces:
- `Ctrl + 1` - Focus space 1
- `Ctrl + 2` - Focus space 2
- `Ctrl + 3` - Focus space 3
- `Ctrl + 4` - Focus space 4
- `Ctrl + 5` - Focus space 5
- `Ctrl + 6` - Focus space 6
- `Ctrl + 7` - Focus space 7

## Window Management

### Window Arrangement
Swap windows within the current space:
- `Shift + Alt + h` - Swap with window to the left
- `Shift + Alt + j` - Swap with window below
- `Shift + Alt + k` - Swap with window above
- `Shift + Alt + l` - Swap with window to the right

### Window Movement
Move window and create new splits:
- `Ctrl + Alt + h` - Move window left and warp
- `Ctrl + Alt + j` - Move window down and warp
- `Ctrl + Alt + k` - Move window up and warp
- `Ctrl + Alt + l` - Move window right and warp

### Window Sizing
Control window size and layout:
- `Shift + Alt + m` - Toggle fullscreen/zoom
- `Shift + Alt + e` - Balance all windows (equal sizes)
- `Shift + Alt + t` - Toggle floating window (4x4 grid, centered)

## Layout Modifications

### Layout Transformations
Transform the current space layout:
- `Shift + Alt + r` - Rotate layout clockwise (270°)
- `Shift + Alt + y` - Flip layout along Y-axis (horizontal flip)
- `Shift + Alt + x` - Flip layout along X-axis (vertical flip)

## Multi-Display Management

### Move Windows Between Displays
Move the current window to different displays:
- `Shift + Alt + s` - Move window to left display and follow focus
- `Shift + Alt + g` - Move window to right display and follow focus

## Space Management

### Moving Windows Between Spaces
Move windows to different desktop spaces:
- `Shift + Alt + 1` - Move window to space 1 and follow focus
- `Shift + Alt + 2` - Move window to space 2
- `Shift + Alt + 3` - Move window to space 3
- `Shift + Alt + 4` - Move window to space 4
- `Shift + Alt + 5` - Move window to space 5
- `Shift + Alt + 6` - Move window to space 6
- `Shift + Alt + 7` - Move window to space 7

### Navigate to Adjacent Spaces
Move windows to previous/next spaces:
- `Shift + Alt + p` - Move window to previous space and follow focus
- `Shift + Alt + n` - Move window to next space and follow focus

### Space Creation/Destruction
Manage desktop spaces:
- `Cmd + Alt + n` - Create new space and focus it
- `Cmd + Alt + d` - Destroy current space (preserves window focus)

## System Control

### Yabai Service Management
Control the Yabai window manager:
- `Ctrl + Alt + q` - Stop Yabai service
- `Ctrl + Alt + s` - Start Yabai service
- `Ctrl + Alt + r` - Restart Yabai service

## Tips and Notes

### Modifier Key Reference
- `Alt` - Option key (⌥)
- `Shift` - Shift key (⇧)
- `Ctrl` - Control key (⌃)
- `Cmd` - Command key (⌘)

### Understanding Window Management
- **Focus**: Changes which window receives input
- **Swap**: Exchanges positions of two windows
- **Warp**: Moves a window and creates a new split
- **Float**: Removes window from tiling layout

### Best Practices
1. **Start with navigation**: Master `Alt + hjkl` for basic window focus
2. **Learn swapping**: Use `Shift + Alt + hjkl` to organize windows
3. **Use spaces**: Organize different workflows in separate spaces
4. **Balance layouts**: Use `Shift + Alt + e` when windows become uneven

### Troubleshooting
- If shortcuts don't work, check that SKHD has accessibility permissions
- Restart SKHD service: `brew services restart skhd`
- Check configuration: `skhd --reload`
- View logs: `tail -f /usr/local/var/log/skhd/skhd.out.log`

## Configuration

The shortcuts are defined in `~/.config/skhd/skhdrc`. You can modify this file to:
- Change key bindings
- Add new shortcuts
- Remove unwanted shortcuts
- Customize window behavior

After making changes, reload the configuration:
```bash
skhd --reload
```