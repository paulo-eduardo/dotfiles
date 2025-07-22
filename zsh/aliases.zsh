# CLI Tool Aliases
# tui-journal - Terminal-based journaling app
alias tj="tjournal -c ~/.config/tui-journal/config.toml"
alias tt="taskwarrior-tui"
alias awslocal="AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test AWS_DEFAULT_REGION=${${DEFAULT_REGION:-$AWS_DEFAULT_REGION}:-us-west-2} aws --endpoint-url=http://${LOCALSTACK_HOST:-localhost}:4566"

# Smart virtual environment activation
# Detects and activates Python virtual environments based on what's available
smart_venv_activate() {
  # Check for standard .venv directory
  if [[ -f ".venv/bin/activate" ]]; then
    echo "Activating standard .venv environment..."
    source .venv/bin/activate
    return
  fi
  
  # Check for env directory
  if [[ -f "env/bin/activate" ]]; then
    echo "Activating env environment..."
    source env/bin/activate
    return
  fi
  
  # Check for venv directory
  if [[ -f "venv/bin/activate" ]]; then
    echo "Activating venv environment..."
    source venv/bin/activate
    return
  fi

  # Check for Poetry
  if [[ -f "poetry.lock" ]]; then
    echo "Poetry project detected. Activating poetry shell..."
    if command -v poetry &> /dev/null; then
      poetry shell
      return
    else
      echo "Poetry is not installed. Please install it first."
      return 1
    fi
  fi
  
  # Check for Pipenv
  if [[ -f "Pipfile" ]]; then
    echo "Pipenv project detected. Activating pipenv shell..."
    if command -v pipenv &> /dev/null; then
      pipenv shell
      return
    else
      echo "Pipenv is not installed. Please install it first."
      return 1
    fi
  fi
  
  echo "No virtual environment found. Make sure you're in a Python project directory."
  return 1
}

alias sv="smart_venv_activate"
