#!/bin/bash

configure_macos_settings() {
    echo "Configuring macOS settings..."
    
    echo "Setting Dock to auto-hide..."
    defaults write com.apple.dock autohide -bool true
    
    echo "Setting Dock size..."
    defaults write com.apple.dock tilesize -int 48
    
    echo "Setting Menu Bar to auto-hide..."
    defaults write NSGlobalDomain _HIHideMenuBar -bool true
    
    echo "Disabling space switching animation..."
    defaults write com.apple.dock workspaces-swoosh-animation-off -bool YES
    
    echo "Reduce motion effects..."
    defaults write com.apple.universalaccess reduceMotion -bool true
    
    echo "Disable window animations..."
    defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
    
    echo "Speed up window resize animations..."
    defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
    
    echo "Disable smooth scrolling..."
    defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false
    
    echo "Speed up Mission Control animations..."
    defaults write com.apple.dock expose-animation-duration -float 0.1
    
    echo "Remove Dock show/hide delay..."
    defaults write com.apple.dock autohide-delay -float 0
    defaults write com.apple.dock autohide-time-modifier -float 0.15
    
    echo "Enable press-and-hold for accents..."
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool true
    
    echo "Set default key repeat rate..."
    defaults write NSGlobalDomain KeyRepeat -int 2
    defaults write NSGlobalDomain InitialKeyRepeat -int 15
    
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
    
    echo "Enabling space switching animation..."
    defaults write com.apple.dock workspaces-swoosh-animation-off -bool NO
    
    echo "Restore default motion effects..."
    defaults write com.apple.universalaccess reduceMotion -bool false
    
    echo "Enable window animations..."
    defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool true
    
    echo "Restore default window resize animations..."
    defaults write NSGlobalDomain NSWindowResizeTime -float 0.2
    
    echo "Enable smooth scrolling..."
    defaults write NSGlobalDomain NSScrollAnimationEnabled -bool true
    
    echo "Restore default Mission Control animations..."
    defaults write com.apple.dock expose-animation-duration -float 0.5
    
    echo "Restore default Dock show/hide delay..."
    defaults write com.apple.dock autohide-delay -float 0.5
    defaults write com.apple.dock autohide-time-modifier -float 0.5
    
    echo "Enable press-and-hold for keys..."
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool true
    
    echo "Restore default key repeat rate..."
    defaults write NSGlobalDomain KeyRepeat -int 2
    defaults write NSGlobalDomain InitialKeyRepeat -int 15
    
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