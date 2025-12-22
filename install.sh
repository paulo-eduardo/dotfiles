#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="$SCRIPT_DIR/scripts/setup-modules"

source "$MODULES_DIR/system-checks.sh"
source "$MODULES_DIR/package-management.sh"
source "$MODULES_DIR/services.sh"
source "$MODULES_DIR/macos-settings.sh"
source "$MODULES_DIR/utilities.sh"

show_help() {
    echo "Usage: ./install.sh [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --only <module>    Run only a specific module"
    echo "  --help             Show this help message"
    echo ""
    echo "Available modules:"
    echo "  sip-check       Check SIP status"
    echo "  boot-args       Configure boot arguments"
    echo "  homebrew        Install Homebrew"
    echo "  xcode-cli       Install Xcode CLI tools"
    echo "  oh-my-zsh       Install Oh My Zsh"
    echo "  brewfile        Install from Brewfile"
    echo "  font            Install SketchyBar font"
    echo "  claude          Install Claude Code"
    echo "  zshenv          Create .zshenv file"
    echo "  sudoers         Configure sudoers for yabai"
    echo "  macos-settings  Apply macOS settings"
    echo "  services        Start all services"
    echo ""
    echo "Examples:"
    echo "  ./install.sh                     # Run full installation"
    echo "  ./install.sh --only macos-settings"
    echo "  ./install.sh --only brewfile"
}

run_module() {
    local module=$1
    case $module in
        sip-check)
            check_sip_status
            ;;
        boot-args)
            configure_boot_args
            ;;
        homebrew)
            install_homebrew
            ;;
        xcode-cli)
            install_xcode_cli
            ;;
        oh-my-zsh)
            install_oh_my_zsh
            ;;
        brewfile)
            install_from_brewfile
            ;;
        font)
            install_font
            ;;
        claude)
            install_claude
            ;;
        zshenv)
            create_zshenv
            ;;
        sudoers)
            configure_sudoers
            ;;
        macos-settings)
            configure_macos_settings
            ;;
        services)
            start_all_services
            ;;
        *)
            echo "Unknown module: $module"
            echo "Run './install.sh --help' for available modules"
            exit 1
            ;;
    esac
}

# Parse arguments
if [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
    show_help
    exit 0
fi

if [[ "$1" == "--only" ]]; then
    if [[ -z "$2" ]]; then
        echo "Error: --only requires a module name"
        echo "Run './install.sh --help' for available modules"
        exit 1
    fi
    echo "Running module: $2"
    run_module "$2"
    echo "Done!"
    exit 0
fi

# Full installation
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
