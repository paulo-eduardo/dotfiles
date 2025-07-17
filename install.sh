set -e

echo "Starging setup..."

if ! command -v brew &>/dev/null; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo >> /Users/paulo/.zprofile
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/paulo/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Homebrew is already installed."
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Installing apps from Brewfile..."

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

brew bundle install --file ./Brewfile

yabai --start-service
skhd --start-service
