#!/bin/bash

set -e

echo "Starting setup..."

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

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  export KEEP_ZSHRC=yes
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "Oh My Zsh is already installed."
fi

echo "Installing Catppuccin theme for Oh My Zsh..."
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
if [ ! -d "${ZSH_CUSTOM}/themes/catppuccin-zsh" ]; then
  git clone https://github.com/catppuccin/zsh-theme.git "${ZSH_CUSTOM}/themes/catppuccin-zsh"
else
  echo "Catppuccin theme is already installed."
fi

echo "Installing apps from Brewfile..."
brew bundle install --file ./Brewfile

echo "Installing latest Node.js with nvm..."
export NVM_DIR="$HOME/.nvm"
. "$(brew --prefix)/opt/nvm/nvm.sh"
nvm install node
nvm alias default node

echo "Creating .zshenv file..."
cat <<'EOF' >~/.zshenv
export ZDOTDIR="$HOME/.config/zsh"

if [[ -f "$ZDOTDIR/.zshenv" ]]; then
    source "$ZDOTDIR/.zshenv"
fi
EOF

echo "Setup complete!"
