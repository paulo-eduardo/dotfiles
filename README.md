# macOS Configuration Setup

This repository contains the configuration files and setup script to quickly configure a new macOS installation to my personal preferences.

It automates the installation of applications and command-line tools using [Homebrew](https://brew.sh/) and sets up window management with [yabai](https://github.com/koekeishiya/yabai) and [skhd](https://github.com/koekeishiya/skhd).

## Setup Instructions

Follow these steps in order to set up a new Mac.

### Step 1: Clone the Repository

First, clone this repository into your `~/.config` directory. This location is intentionally chosen so that applications that follow the XDG Base Directory Specification will find their configurations automatically without needing symbolic links.

```bash
git clone <your-repository-url> ~/.config
```

### Step 2: Disable System Integrity Protection (SIP)

`yabai` requires SIP to be partially disabled to allow its scripting addition to control windows, spaces, and displays.

**1. Boot into Recovery Mode:**
   - **Apple Silicon:** Shut down your Mac. Press and hold the power button until you see "Loading startup options". Click **Options**, then **Continue**.
   - **Intel:** Shut down your Mac. Hold down `Command (⌘) + R` while booting.

**2. Open the Terminal:**
   - In the recovery screen, navigate to `Utilities > Terminal` from the menu bar.

**3. Disable SIP:**
   - Execute the following command in the recovery terminal:
     ```sh
     # This is the recommended setting for yabai, as it's less permissive than fully disabling SIP.
     csrutil disable --with-dtrace
     ```

**4. Reboot your Mac.**

You can verify the status after rebooting by running `csrutil status` in a normal terminal.

### Step 3: Run the Installation Script

The `install.sh` script will handle the rest of the automated setup. It will:
- Install Homebrew if it's not already present.
- Install all applications and tools listed in the `Brewfile`.
- Start the `yabai`, `skhd`, and `sketchybar` services.

Navigate to the configuration directory and run the script:
```bash
cd ~/.config
./install.sh
```

### Step 4: Manual Post-Installation Steps

After the script finishes, a few manual steps are required to grant permissions.

**1. Configure Passwordless `sudo` for Yabai:**
   - `yabai` needs to run a `sudo` command on startup to load its scripting addition. To avoid typing your password every time, you need to add a custom rule to `sudoers`.
   - First, find the exact path of your `yabai` installation:
     ```bash
     which yabai
     # It should output something like /opt/homebrew/bin/yabai
     ```
   - Now, open the `sudoers` file for editing (this is the safe way to do it):
     ```bash
     sudo visudo -f /private/etc/sudoers.d/yabai
     ```
   - Add the following line to the file, replacing `YOUR_USERNAME` with the output of `whoami` and `/path/to/yabai` with the output of `which yabai`:
     ```
     YOUR_USERNAME ALL=(root) NOPASSWD: /path/to/yabai --load-sa
     ```
   - Save and exit the editor.

**2. Grant System Permissions:**
   - Go to `System Settings > Privacy & Security > Accessibility`.
   - Enable access for `yabai` and `skhd`.
   - Go to `System Settings > Privacy & Security > Screen Recording`.
   - Enable access for `yabai`.

### Step 5: Reboot

A final reboot is recommended to ensure all services and settings are correctly loaded.

```bash
sudo reboot
```

Your Mac should now be fully configured. Enjoy!
