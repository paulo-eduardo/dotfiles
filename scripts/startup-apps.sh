#!/bin/bash

open -a "Calendar"

# Create a temporary script to run in Terminal
TEMP_SCRIPT=$(mktemp)
echo '#!/bin/bash' >"$TEMP_SCRIPT"
echo 'tt || taskwarrior-tui' >>"$TEMP_SCRIPT"
echo 'exec bash' >>"$TEMP_SCRIPT"
chmod +x "$TEMP_SCRIPT"

open -a "Terminal" "$TEMP_SCRIPT"

# Loop to check if yabai is working
while ! yabai -m query --windows &>/dev/null; do
  echo "yabai is not working, sleeping..."
  sleep 1
done
echo "yabai is now working"

# # Check if Calendar is already open, if not open it
CALENDAR_WINDOW=$(yabai -m query --windows | jq '.[] | select(.app | contains("Calendar")) | .id' | head -n1)
if [ -z "$CALENDAR_WINDOW" ]; then
  # Wait for Calendar to appear in yabai
  while [ -z "$CALENDAR_WINDOW" ]; do
    sleep 1
    CALENDAR_WINDOW=$(yabai -m query --windows | jq '.[] | select(.app | contains("Calendar")) | .id' | head -n1)
  done
fi
#
# Check if Terminal with taskwarrior is already open, if not open it
TERMINAL_WINDOW=$(yabai -m query --windows | jq '.[] | select(.app | contains("Terminal")) | .id' | head -n1)
if [ -z "$TERMINAL_WINDOW" ]; then
  # Wait for Terminal to appear in yabai
  while [ -z "$TERMINAL_WINDOW" ]; do
    sleep 1
    TERMINAL_WINDOW=$(yabai -m query --windows | jq '.[] | select(.app | contains("Terminal")) | .id' | head -n1)
  done
fi
# Move Calendar to space 9
yabai -m window $CALENDAR_WINDOW --space 9

# Move Terminal to space 9
yabai -m window $TERMINAL_WINDOW --space 9
