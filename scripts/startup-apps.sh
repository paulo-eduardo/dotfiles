#!/bin/bash

# Configuration
YABAI_PATH="/opt/homebrew/bin/yabai"
CONFIG_FILE="$(dirname "$0")/startup-config.json"
LOG_FILE="/tmp/startup-apps.log"

# Enable logging
exec 2>>"$LOG_FILE"
log() {
    echo "$(date): $1" >>"$LOG_FILE"
}

log "Starting startup script"

# Wait for yabai to be ready
log "Waiting for yabai to be ready..."
while ! "$YABAI_PATH" -m query --spaces &>/dev/null; do
    log "yabai not ready, waiting..."
    sleep 1
done
log "yabai is ready"

# Function to open an app with optional command
open_app() {
    local app_name="$1"
    local cmd="$2"
    
    log "Opening $app_name"
    
    if [[ "$app_name" == "Terminal" && -n "$cmd" ]]; then
        local temp_script=$(mktemp)
        echo '#!/bin/bash' >"$temp_script"
        echo "$cmd" >>"$temp_script"
        echo 'exec bash' >>"$temp_script"
        chmod +x "$temp_script"
        open -a "$app_name" "$temp_script"
    else
        open -a "$app_name"
    fi
    
    # Wait for app to appear in yabai
    log "Waiting for $app_name to appear..."
    while ! "$YABAI_PATH" -m query --windows | jq -e ".[] | select(.app | contains(\"$app_name\"))" &>/dev/null; do
        sleep 0.5
    done
    log "$app_name opened successfully"
}

# Function to focus a space
focus_space() {
    local space="$1"
    log "Focusing space $space"
    if ! "$YABAI_PATH" -m space --focus "$space" 2>>"$LOG_FILE"; then
        log "Failed to focus space $space"
        return 1
    fi
    return 0
}

# Check if config file exists
if [[ ! -f "$CONFIG_FILE" ]]; then
    log "Config file not found: $CONFIG_FILE"
    exit 1
fi

# Read and process configuration
log "Reading configuration from $CONFIG_FILE"
spaces_data=$(cat "$CONFIG_FILE" | jq -r '.spaces')
final_space=$(cat "$CONFIG_FILE" | jq -r '.finalSpace')

# Process each space
echo "$spaces_data" | jq -c '.[]' | while read -r space_config; do
    space_num=$(echo "$space_config" | jq -r '.space')
    
    # Focus the space
    focus_space "$space_num"
    
    # Open apps for this space
    echo "$space_config" | jq -c '.apps[]' | while read -r app_config; do
        app_name=$(echo "$app_config" | jq -r '.name')
        app_cmd=$(echo "$app_config" | jq -r '.cmd // empty')
        
        open_app "$app_name" "$app_cmd"
    done
done

# Focus final space
log "Focusing final space $final_space"
focus_space "$final_space"

log "Startup complete"

