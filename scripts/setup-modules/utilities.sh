#!/bin/bash

create_zshenv() {
    echo "Creating .zshenv file..."
    cat <<'EOF' >~/.zshenv
export ZDOTDIR="$HOME/.config/zsh"

if [[ -f "$ZDOTDIR/.zshenv" ]]; then
    source "$ZDOTDIR/.zshenv"
fi
EOF
}

remove_zshenv() {
    echo "Removing .zshenv file..."
    if [ -f "$HOME/.zshenv" ]; then
        if grep -q 'export ZDOTDIR="$HOME/.config/zsh"' "$HOME/.zshenv" 2>/dev/null; then
            rm -f "$HOME/.zshenv"
            echo "Removed .zshenv file."
        else
            echo ".zshenv exists but appears to have been modified. Skipping removal."
        fi
    fi
}

prompt_confirmation() {
    local message=$1
    echo "$message"
    read -p "Are you sure you want to continue? (y/N) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        return 1
    fi
    return 0
}

print_completion_message() {
    local install_mode=$1
    local reboot_required=$2
    
    echo ""
    echo "Setup complete!"
    echo ""
    
    if [ "$install_mode" = true ]; then
        echo "If any services failed to start:"
        echo "1. Grant permissions in System Settings > Privacy & Security > Accessibility"
        echo "2. For yabai, also check System Settings > Privacy & Security > Screen Recording"
        echo "3. Run the start commands manually once permissions are granted"
        
        if [ "$reboot_required" = true ]; then
            echo ""
            echo "⚠️  IMPORTANT: A reboot is required for the boot-args changes to take effect."
            echo "   Please restart your Mac when convenient."
        fi

        echo ""
        echo "📱 For iOS/React Native development:"
        echo "   1. Install Xcode from the App Store"
        echo "   2. Run: xcode-select --install"
        echo "   3. Run: sudo xcodebuild -license accept"
    else
        echo "Note: The following items require manual intervention:"
        echo "1. Re-enable SIP if you disabled it (requires recovery mode)"
        echo "2. Remove arm64e boot args if set: sudo nvram -d boot-args"
        echo "3. Remove any remaining configuration files in ~/.config if desired"
        echo "4. Revoke SSH keys from GitHub if no longer needed"
    fi
}