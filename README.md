# macOS Development Environment

A comprehensive dotfiles setup for macOS that creates a modern, efficient development environment with tiling window management, a custom status bar, and a fully configured Neovim setup.

## What This Setup Provides

### 🪟 **Window Management (Yabai + SKHD)**
- **Binary Space Partitioning (BSP)**: Automatic window tiling that maximizes screen real estate
- **Keyboard-driven navigation**: Move between windows with `Alt + hjkl` (vim-style)
- **Flexible layouts**: Rotate, flip, and balance window arrangements
- **Multi-monitor support**: Seamlessly move windows between displays
- **Space management**: Create, destroy, and navigate between desktop spaces
- **Mouse integration**: Alt + drag to move/resize windows

### 📊 **Custom Status Bar (SketchyBar)**
- **Minimal floating design**: Clean, modern appearance that doesn't clutter your desktop
- **System monitoring**: Real-time CPU, memory, and battery information
- **Media controls**: Current playing music with playback controls
- **Network status**: WiFi connection information
- **Date/time display**: Always visible calendar information
- **Active app indicator**: Shows your current focused application
- **Space indicators**: Visual representation of your desktop spaces

### ⚡ **Neovim Configuration (LazyVim)**
- **LazyVim base**: Built on the popular LazyVim distribution for instant productivity
- **Catppuccin theme**: Beautiful, consistent theming with transparency support
- **Language support**: Pre-configured for TypeScript, JSON, and more
- **Enhanced UI**: Smooth animations and improved visual feedback
- **Plugin management**: Lazy-loading for optimal performance
- **Custom tweaks**: Additional configurations for better workflow

### 🛠 **Development Tools**
- **Homebrew**: Package manager with curated app selection
- **Git integration**: Enhanced git workflow with LazyGit
- **Terminal enhancement**: Optimized Zsh configuration with Oh My Zsh
- **Modern replacements**: btop, wezterm, and other improved CLI tools
- **AI assistants**: Claude and Gemini CLI tools for development assistance

## Visual Preview

Once installed, you'll have:
- **Tiled windows** that automatically organize and resize
- **A floating status bar** at the top showing system info and current app
- **Vim-style navigation** throughout your desktop environment
- **Beautiful, consistent theming** across all applications
- **Distraction-free workspace** with hidden dock and menu bar

## Installation

### Prerequisites
- macOS (tested on recent versions)
- Administrator access for system modifications

### Step 1: Authenticate with GitHub

Before you can clone the repository, you need to authenticate with GitHub. Using SSH is the recommended method, as it's secure and convenient.

**1. Check for Existing SSH Keys:**

First, check if you already have an SSH key. Open your terminal and run:

```bash
ls -al ~/.ssh
```

If you see files named `id_rsa.pub` or `id_ed25519.pub`, you already have a key and can skip to step 3.

**2. Generate a New SSH Key:**

If you don't have a key, generate a new one. The `ed25519` algorithm is recommended as it's more secure and performant. Use your GitHub email address.

```bash
ssh-keygen -t ed25519 -C "your.email@example.com"
```

When prompted to "Enter a file in which to save the key," press Enter to accept the default location. You'll be asked to enter a passphrase, which is optional but highly recommended for security.

**3. Add Your SSH Key to the ssh-agent:**

To ensure your key is automatically used for authentication, start the `ssh-agent` and add your key.

```bash
# Start the ssh-agent in the background
eval "$(ssh-agent -s)"

# Add your private key to the agent
ssh-add ~/.ssh/id_ed25519
```

**4. Add the SSH Key to Your GitHub Account:**

Now, you need to add the public key to your GitHub account.

-   **Copy the public key to your clipboard.** The command depends on your operating system.
    -   **macOS:**
        ```bash
        pbcopy < ~/.ssh/id_ed25519.pub
        ```
-   **Go to your GitHub settings:**
    1.  In the upper-right corner of any page, click your profile photo, then click **Settings**.
    2.  In the "Access" section of the sidebar, click **SSH and GPG keys**.
    3.  Click **New SSH key** or **Add SSH key**.
    4.  In the "Title" field, add a descriptive label for the new key (e.g., "My MacBook Pro").
    5.  In the "Key" field, paste your public key.
    6.  Click **Add SSH key**.

You are now authenticated to use Git and GitHub.

### Step 2: Clone the Repository

First, clone this repository into your `~/.config` directory. This location is intentionally chosen so that applications that follow the XDG Base Directory Specification will find their configurations automatically without needing symbolic links.

```bash
git clone git@github.com:paulo-eduardo/dotfiles.git ~/.config
```

### Step 3: Disable System Integrity Protection (SIP)

`yabai` requires SIP to be partially disabled to allow its scripting addition to control windows, spaces, and displays.

**1. Boot into Recovery Mode:**
   - **Intel Macs:** Hold down `Command ⌘ + R` while booting your device.
   - **Apple Silicon Macs:** Press and hold the power button until "Loading startup options" appears. Then, click "Options" and "Continue".

**2. Open the Terminal:**
   - In the menu bar, go to `Utilities` > `Terminal`.

**3. Run the appropriate command:**
   - **For Apple Silicon (macOS 13.x or newer):**
     ```bash
     csrutil enable --without fs --without debug --without nvram
     ```
   - **For Apple Silicon (macOS 12.x.x):**
     ```bash
     csrutil disable --with kext --with dtrace --with basesystem
     ```
   - **For Intel (macOS 11.x.x or newer):**
     ```bash
     csrutil disable --with kext --with dtrace --with nvram --with basesystem
     ```

**4. Reboot your Mac.**

**5. Verify SIP Status:**
   - You can check if SIP is disabled by running `csrutil status` in the terminal. The output should be `System Integrity Protection status: disabled.` (or `unknown` on some newer macOS versions).

### Step 4: Run the Installation Script

The `install.sh` script will handle the automated setup. It will:
- Check that SIP is properly disabled for yabai
- Configure boot-args for Apple Silicon
- Install Homebrew if it's not already present
- Install all applications and tools listed in the `Brewfile`
- Configure sudoers for passwordless yabai operation
- Configure macOS settings (auto-hide dock and menu bar)
- Start all services (yabai, skhd, sketchybar)

Navigate to the configuration directory and run the script:
```bash
cd ~/.config
./install.sh
```

### Step 5: Grant System Permissions

The installation script will attempt to start services, which will prompt for permissions. If you miss any prompts, manually grant permissions:

1. Go to `System Settings > Privacy & Security > Accessibility`.
2. Enable access for `yabai` and `skhd`.
3. Go to `System Settings > Privacy & Security > Screen Recording`.
4. Enable access for `yabai`.

### Step 6: Reboot

A final reboot is recommended to ensure all services and settings are correctly loaded.

```bash
sudo reboot
```

Your Mac should now be fully configured. Enjoy!

## Keyboard Shortcuts

This setup includes comprehensive keyboard shortcuts for window management and system control. 

📋 **[View complete keyboard shortcuts reference →](skhd/README.md)**

## Customization

### Modifying Window Management
Edit `~/.config/yabai/yabairc` to adjust:
- Window gaps and padding
- Layout behavior
- Application-specific rules

### Customizing Status Bar
Edit `~/.config/sketchybar/` files to modify:
- Bar appearance and position
- Item configurations
- Colors and styling

### Neovim Configuration
Extend `~/.config/nvim/lua/plugins/` to add:
- Additional language support
- Custom key bindings
- New plugins and themes

## Uninstallation

To remove the entire setup:
```bash
./uninstall.sh
```

This will:
- Stop all services
- Remove installed packages (using `brew bundle cleanup`)
- Restore original system settings
- Clean up configuration files

## Troubleshooting

### Services Won't Start
1. Check permissions in System Settings > Privacy & Security
2. Manually start services: `yabai --start-service`, `skhd --start-service`
3. Restart the services: `brew services restart sketchybar`

### SIP Issues
- Verify SIP status: `csrutil status`
- Ensure partial disabling includes required components
- Check boot-args: `sudo nvram boot-args`

## Contributing

Feel free to fork this repository and customize it for your needs. If you make improvements that could benefit others, pull requests are welcome!

## Credits

This configuration builds upon the excellent work of:
- [LazyVim](https://github.com/LazyVim/LazyVim) - Neovim configuration
- [Yabai](https://github.com/koekeishiya/yabai) - Window manager
- [SketchyBar](https://github.com/FelixKratz/SketchyBar) - Status bar
- [Catppuccin](https://github.com/catppuccin/nvim) - Color scheme