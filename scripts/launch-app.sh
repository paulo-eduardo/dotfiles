#!/bin/bash

# Set PATH to ensure we can find system tools
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:/usr/local/bin:$PATH"

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

log() {
  echo "$(date): $1" >>"$LOG_FILE"
}

launch_app() {
  local name="$1"
  local cmd="$2"
  local space="$3"
  local position="$4"

  log "Starting $name for space $space (position: $position)"

  # Launch the application
  if [[ "$name" == "Terminal" && -n "$cmd" ]]; then
    local temp_script=$(mktemp)
    echo '#!/bin/bash' >"$temp_script"
    echo "$cmd" >>"$temp_script"
    echo 'exec bash' >>"$temp_script"
    chmod +x "$temp_script"
    open -a "$name" "$temp_script"
  else
    open -a "$name"
  fi

  # Wait for application window to appear
  log "Waiting for $name to appear..."
  local window_id=""
  local attempts=0
  while [[ -z "$window_id" && $attempts -lt 50 ]]; do
    window_id=$("$YABAI_PATH" -m query --windows 2>/dev/null | jq -r ".[] | select(.app | contains(\"$name\")) | .id" | head -n1)
    if [[ -n "$window_id" ]]; then
      break
    fi
    sleep 0.2
    ((attempts++))
  done

  if [[ -z "$window_id" ]]; then
    log "Failed to find window for $name after 10 seconds"
    return 1
  fi

  # Move window to specified space
  log "Found window $window_id for $name, moving to space $space"
  if "$YABAI_PATH" -m window "$window_id" --space "$space" 2>>"$LOG_FILE"; then
    log "Successfully moved $name to space $space"
    
    # Apply positioning if specified
    if [[ -n "$position" && "$position" != "empty" ]]; then
      log "Applying position: $position for $name"
      case "$position" in
        "left")
          "$YABAI_PATH" -m window "$window_id" --warp west 2>>"$LOG_FILE"
          ;;
        "right")
          "$YABAI_PATH" -m window "$window_id" --warp east 2>>"$LOG_FILE"
          ;;
        *)
          log "Unknown position: $position for $name"
          ;;
      esac
    fi
  else
    log "Failed to move $name to space $space"
  fi

  log "Completed $name setup"
}

# Main execution if called directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  name="$1"
  cmd="$2"
  space="$3"
  position="$4"
  
  if [[ -z "$name" || -z "$space" ]]; then
    echo "Usage: $0 <app_name> [command] <space> [position]"
    exit 1
  fi
  
  launch_app "$name" "$cmd" "$space" "$position"
fi