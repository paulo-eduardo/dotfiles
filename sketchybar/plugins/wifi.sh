#!/bin/bash

# Get Wi-Fi info using wdutil
WIFI_INFO=$(sudo wdutil info)
echo "$WIFI_INFO"

# Check connection status by looking for SSID
# If SSID is present and not empty, we are connected.
SSID=$(echo "$WIFI_INFO" | grep -E '^\s+SSID\s+:\s+' | awk -F': ' '{print $2}')

if [ -z "$SSID" ] || [ "$SSID" == "<null>" ]; then
  # Not connected, or SSID is null, hide the item
  sketchybar --set $NAME drawing=off
  exit 0
fi

# Get RSSI (signal strength)
# Grab the first line matching RSSI to avoid duplicates (e.g., Bluetooth RSSI)
RSSI_LINE=$(echo "$WIFI_INFO" | grep -E '^\s+RSSI\s+:\s+' | head -n 1)
RSSI=$(echo "$RSSI_LINE" | awk '{print $3}') # Get the 3rd field which is the RSSI value

# Determine icon (using macOS standard Wi-Fi symbol)
ICON="􀙇"

# Update Sketchybar item - Ensure drawing is on and set icon/label
sketchybar --set $NAME drawing=on icon="$ICON" label="${RSSI}dBm" 