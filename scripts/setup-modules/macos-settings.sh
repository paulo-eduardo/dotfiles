#!/bin/bash

configure_macos_settings() {
    echo "Configuring macOS settings..."
    
    echo "Setting Dock to auto-hide..."
    defaults write com.apple.dock autohide -bool true
    
    echo "Setting Dock size..."
    defaults write com.apple.dock tilesize -int 48
    
    echo "Setting Menu Bar to auto-hide..."
    defaults write NSGlobalDomain _HIHideMenuBar -bool true
    
    echo "Restarting Dock to apply changes..."
    killall Dock
}

restore_macos_settings() {
    echo "Restoring macOS settings..."
    
    echo "Disabling Dock auto-hide..."
    defaults write com.apple.dock autohide -bool false
    
    echo "Restoring default Dock size..."
    defaults write com.apple.dock tilesize -int 64
    
    echo "Disabling Menu Bar auto-hide..."
    defaults write NSGlobalDomain _HIHideMenuBar -bool false
    
    echo "Restarting Dock to apply changes..."
    killall Dock
}

configure_boot_args() {
    echo "Configuring boot args for Apple Silicon..."
    CURRENT_BOOT_ARGS=$(sudo nvram boot-args 2>/dev/null | cut -d$'\t' -f2 || echo "")
    if [[ "$CURRENT_BOOT_ARGS" != *"-arm64e_preview_abi"* ]]; then
        echo "Setting boot-args for arm64e binaries..."
        sudo nvram boot-args=-arm64e_preview_abi
        echo "✓ Boot args configured. A reboot will be required after installation."
        echo "REBOOT_REQUIRED"
    else
        echo "✓ Boot args already configured"
    fi
}

revert_boot_args() {
    echo "Reverting boot-args..."
    CURRENT_BOOT_ARGS=$(sudo nvram boot-args 2>/dev/null | cut -d$'\t' -f2 || echo "")
    if [[ "$CURRENT_BOOT_ARGS" == "-arm64e_preview_abi" ]]; then
        sudo nvram -d boot-args
        echo "Removed boot-args. A reboot will be required."
        return 0
    elif [[ "$CURRENT_BOOT_ARGS" == *"-arm64e_preview_abi"* ]]; then
        echo "Boot-args contains other values besides -arm64e_preview_abi."
        echo "Please manually review: sudo nvram boot-args"
        return 1
    else
        echo "No boot-args changes needed."
        return 0
    fi
}