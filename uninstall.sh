#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="$SCRIPT_DIR/scripts/setup-modules"

source "$MODULES_DIR/system-checks.sh"
source "$MODULES_DIR/package-management.sh"
source "$MODULES_DIR/services.sh"
source "$MODULES_DIR/macos-settings.sh"
source "$MODULES_DIR/utilities.sh"

echo "Starting uninstallation..."
echo "This will remove all configurations and packages installed by install.sh"
echo ""

prompt_confirmation "Are you sure you want to continue?" || exit 1

stop_all_services

remove_sudoers

restore_macos_settings

revert_boot_args

remove_font

remove_zshenv

uninstall_from_brewfile

remove_oh_my_zsh

uninstall_homebrew

print_completion_message false false