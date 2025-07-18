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

if [ ! -d "$HOME/.config/oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  export KEEP_ZSHRC=yes
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "Oh My Zsh is already installed."
fi

echo "Installing apps from Brewfile..."
brew bundle install --file ./Brewfile

echo "Installing sketchybar-app-font..."
if [ ! -f "$HOME/Library/Fonts/sketchybar-app-font.ttf" ]; then
  curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.16/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf
else
  echo "sketchybar-app-font is already installed."
fi


echo "Installing latest Node.js with nvm..."
export NVM_DIR="$HOME/.nvm"
. "$(brew --prefix)/opt/nvm/nvm.sh"
nvm install node
nvm alias default node

echo "Checking for Gemini CLI..."
if ! command -v gemini &>/dev/null; then
  echo "Gemini CLI not found. Installing..."
  npm install -g @google/gemini-cli
else
  echo "Gemini CLI is already installed."
fi

echo "Checking for Claude CLI..."
if ! command -v claude &>/dev/null; then
  echo "Claude CLI not found. Installing..."
  npm install -g @anthropic-ai/claude-code
else
  echo "Claude CLI is already installed."
fi

echo "Creating .zshenv file..."
cat <<'EOF' >~/.zshenv
export ZDOTDIR="$HOME/.config/zsh"

if [[ -f "$ZDOTDIR/.zshenv" ]]; then
    source "$ZDOTDIR/.zshenv"
fi
EOF

echo "Setup complete!"
