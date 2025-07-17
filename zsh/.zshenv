# Set ZDOTDIR to the new configuration directory
export ZDOTDIR="$HOME/.config/zsh"

# Source the zshenv file from the new location (optional but recommended)
# This allows you to have zshenv-specific config within ~/.config/zsh
if [[ -f "$ZDOTDIR/.zshenv" ]]; then
    source "$ZDOTDIR/.zshenv"
fi
