#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="$SCRIPT_DIR/scripts/setup-modules"

source "$MODULES_DIR/system-checks.sh"
source "$MODULES_DIR/package-management.sh"
source "$MODULES_DIR/services.sh"
source "$MODULES_DIR/macos-settings.sh"
source "$MODULES_DIR/utilities.sh"

echo "Starting setup..."

check_sip_status || exit 1

BOOT_ARGS_OUTPUT=$(configure_boot_args)
echo "$BOOT_ARGS_OUTPUT"
if [[ "$BOOT_ARGS_OUTPUT" == *"REBOOT_REQUIRED"* ]]; then
    REBOOT_REQUIRED=true
else
    REBOOT_REQUIRED=false
fi

install_homebrew

install_xcode_cli

install_oh_my_zsh

install_from_brewfile

install_font

install_claude

create_zshenv

configure_sudoers

configure_macos_settings

start_all_services

print_completion_message true "$REBOOT_REQUIRED"