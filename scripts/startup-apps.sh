#!/bin/bash

# Set PATH to ensure we can find system tools when run by OS
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:/usr/local/bin:$PATH"

# Get absolute script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/startup-config.json"
LAUNCH_SCRIPT="$SCRIPT_DIR/launch-app.sh"
LOG_FILE="/tmp/startup-apps.log"
YABAI_PATH="/opt/homebrew/bin/yabai"

# Ensure yabai path exists, fallback to PATH search
if [[ ! -x "$YABAI_PATH" ]]; then
  YABAI_PATH="$(command -v yabai)"
  if [[ -z "$YABAI_PATH" ]]; then
    echo "$(date): ERROR: yabai not found in PATH" >>"$LOG_FILE"
    exit 1
  fi
fi

# Ensure we can write to log file and redirect stderr
exec 2>>"$LOG_FILE"
log() {
  echo "$(date): $1" >>"$LOG_FILE"
}

# Validation
if [[ ! -f "$CONFIG_FILE" ]]; then
  log "Config file not found: $CONFIG_FILE"
  exit 1
fi

if [[ ! -f "$LAUNCH_SCRIPT" ]]; then
  log "Launch script not found: $LAUNCH_SCRIPT"
  exit 1
fi

log "Starting startup script"

# Wait for yabai to be ready
while ! "$YABAI_PATH" -m query --spaces &>/dev/null; do
  log "Waiting for yabai..."
  sleep 1
done
log "yabai ready"

# Launch each app in parallel using the separate script
log "Reading apps from config and launching in parallel..."

# Use process substitution to avoid subshell issues with arrays
declare -a pids=()
while read -r app; do
  name=$(echo "$app" | jq -r '.name')
  cmd=$(echo "$app" | jq -r '.cmd // empty')
  space=$(echo "$app" | jq -r '.space')
  position=$(echo "$app" | jq -r '.position // empty')

  log "Launching $name in background for space $space (position: $position)"
  "$LAUNCH_SCRIPT" "$name" "$cmd" "$space" "$position" &
  pids+=($!)
done < <(jq -c '.[]' "$CONFIG_FILE")

# Wait for all background processes
if [[ ${#pids[@]} -gt 0 ]]; then
  log "Waiting for ${#pids[@]} app(s) to complete setup..."
  for pid in "${pids[@]}"; do
    wait "$pid"
  done
else
  log "No apps were launched"
fi

log "All apps setup completed"

# Focus on space 1
log "Focusing on space 1"
"$YABAI_PATH" -m space --focus 1
