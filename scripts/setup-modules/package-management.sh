#!/bin/bash

install_homebrew() {
    if ! command -v brew &>/dev/null; then
        echo "Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        echo >>"$HOME/.zprofile"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>"$HOME/.zprofile"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        echo "Homebrew is already installed."
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
}

uninstall_homebrew() {
    echo ""
    echo "Do you want to completely uninstall Homebrew?"
    echo "WARNING: This will remove ALL Homebrew packages, not just those from this setup!"
    read -p "Uninstall Homebrew? (y/N) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Uninstalling Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
        
        if [ -f "$HOME/.zprofile" ]; then
            sed -i '' '/eval "$(/opt/homebrew/bin/brew shellenv)"/d' "$HOME/.zprofile"
        fi
    else
        echo "Homebrew preserved."
    fi
}

install_oh_my_zsh() {
    if [ ! -d "$HOME/.config/oh-my-zsh" ]; then
        echo "Installing Oh My Zsh..."
        export KEEP_ZSHRC=yes
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        echo "Oh My Zsh is already installed."
    fi
}

remove_oh_my_zsh() {
    echo "Removing Oh My Zsh..."
    if [ -d "$HOME/.config/oh-my-zsh" ]; then
        rm -rf "$HOME/.config/oh-my-zsh"
        echo "Removed Oh My Zsh from .config directory."
    fi
}

install_from_brewfile() {
    echo "Installing apps from Brewfile..."
    brew bundle install --file ./Brewfile
}

uninstall_from_brewfile() {
    echo "Cleaning up Homebrew packages not in Brewfile..."
    if [ -f "./Brewfile" ]; then
        echo "This will remove all packages NOT listed in the Brewfile."
        echo "WARNING: This may remove packages you installed separately!"
        echo ""
        echo "The following packages will be removed:"
        brew bundle cleanup --file ./Brewfile
        echo ""
        read -p "Continue with cleanup? (y/N) " -n 1 -r
        echo ""
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            brew bundle cleanup --file ./Brewfile --force
            echo "Homebrew packages cleaned up."
        else
            echo "Skipped Homebrew package cleanup."
        fi
    fi
}

install_node_with_nvm() {
    echo "Installing latest Node.js with nvm..."
    export NVM_DIR="$HOME/.nvm"
    . "$(brew --prefix)/opt/nvm/nvm.sh"
    nvm install node
    nvm alias default node
}

install_npm_package() {
    local package_name=$1
    local command_name=$2
    
    echo "Checking for $command_name..."
    if ! command -v "$command_name" &>/dev/null; then
        echo "$command_name not found. Installing..."
        npm install -g "$package_name"
    else
        echo "$command_name is already installed."
    fi
}

uninstall_npm_package() {
    local package_name=$1
    local command_name=$2
    
    if command -v "$command_name" &>/dev/null; then
        npm uninstall -g "$package_name"
        echo "Uninstalled $command_name."
    fi
}

install_font() {
    echo "Installing sketchybar-app-font..."
    if [ ! -f "$HOME/Library/Fonts/sketchybar-app-font.ttf" ]; then
        curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.16/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf
    else
        echo "sketchybar-app-font is already installed."
    fi
}

remove_font() {
    echo "Removing installed fonts..."
    if [ -f "$HOME/Library/Fonts/sketchybar-app-font.ttf" ]; then
        rm -f "$HOME/Library/Fonts/sketchybar-app-font.ttf"
        echo "Removed sketchybar-app-font."
    fi
}