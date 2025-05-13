#!/bin/sh

# Ensure tmux is available
if ! command -v tmux > /dev/null 2>&1; then
    exit 1
fi

# Get numerically named sessions, sorted numerically
# Use a temporary file to avoid issues with command substitution and loops
tmpfile=$(mktemp)
# Ensure the temp file is removed on exit, hangup, interrupt, quit, or termination
trap 'rm -f "$tmpfile"' EXIT HUP INT QUIT TERM

# List numerical sessions and sort them, exiting if the command fails
tmux ls -F '#S' 2>/dev/null | grep '^[0-9][0-9]*$' | sort -n > "$tmpfile" || exit 1

# Expected session number starts at 0
expected_num=0

# Read sorted session names line by line from the temporary file
while IFS= read -r current_name; do
    # Check if the current name matches the expected number using arithmetic comparison
    if [ "$current_name" -ne "$expected_num" ]; then
        # Rename the session if it doesn't match. Ignore errors (e.g., session closed during script run).
        tmux rename-session -t "$current_name" "$expected_num" > /dev/null 2>&1
    fi
    # Increment the expected number for the next session using arithmetic expansion
    expected_num=$((expected_num + 1))
done < "$tmpfile"

# Exit successfully
exit 0 