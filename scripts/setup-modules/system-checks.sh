#!/bin/bash

check_sip_status() {
    echo "Checking System Integrity Protection (SIP) status for yabai..."
    SIP_STATUS=$(csrutil status)
    if [[ "$SIP_STATUS" == *"System Integrity Protection status: enabled."* ]]; then
        echo "❌ ERROR: System Integrity Protection is fully enabled."
        echo ""
        echo "Yabai requires SIP to be partially disabled to function properly."
        echo "Please follow Step 2 in the README:"
        echo ""
        echo "  \033[4mhttps://github.com/paulo-eduardo/dotfiles#step-2-disable-system-integrity-protection-sip\033[0m"
        echo ""
        echo "After disabling SIP, run this script again."
        return 1
    fi
    echo "✓ SIP status is compatible with yabai"
    return 0
}


configure_sudoers() {
    echo "Configuring sudoers for yabai..."
    YABAI_PATH=$(which yabai 2>/dev/null || echo "/opt/homebrew/bin/yabai")
    USERNAME=$(whoami)
    SUDOERS_FILE="/private/etc/sudoers.d/yabai"
    SUDOERS_LINE="$USERNAME ALL=(root) NOPASSWD: $YABAI_PATH --load-sa"
    
    if [ ! -f "$SUDOERS_FILE" ] || ! sudo grep -q "$SUDOERS_LINE" "$SUDOERS_FILE" 2>/dev/null; then
        echo "Adding yabai to sudoers..."
        echo "$SUDOERS_LINE" | sudo tee "$SUDOERS_FILE" >/dev/null
        sudo chmod 440 "$SUDOERS_FILE"
    else
        echo "Yabai sudoers configuration already exists."
    fi
    
    echo "Configuring sudoers for wdutil (SketchyBar WiFi)..."
    WDUTIL_SUDOERS_FILE="/private/etc/sudoers.d/wdutil"
    WDUTIL_SUDOERS_LINE="$USERNAME ALL=(root) NOPASSWD: /usr/bin/wdutil"
    
    if [ ! -f "$WDUTIL_SUDOERS_FILE" ] || ! sudo grep -q "$WDUTIL_SUDOERS_LINE" "$WDUTIL_SUDOERS_FILE" 2>/dev/null; then
        echo "Adding wdutil to sudoers..."
        echo "$WDUTIL_SUDOERS_LINE" | sudo tee "$WDUTIL_SUDOERS_FILE" >/dev/null
        sudo chmod 440 "$WDUTIL_SUDOERS_FILE"
    else
        echo "Wdutil sudoers configuration already exists."
    fi
}

remove_sudoers() {
    echo "Removing sudoers configuration for yabai..."
    SUDOERS_FILE="/private/etc/sudoers.d/yabai"
    if [ -f "$SUDOERS_FILE" ]; then
        sudo rm -f "$SUDOERS_FILE"
        echo "Removed yabai sudoers configuration."
    else
        echo "No yabai sudoers configuration found."
    fi
}