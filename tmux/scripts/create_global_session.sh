#!/bin/bash

# Create the global session if it doesn't exist
if ! tmux has-session -t global 2>/dev/null; then
  # Start a new detached session called global
  tmux new-session -d -s global
fi

# Split the current window and join the global session into the new pane
# -v for vertical split (top/bottom)
# -p 25 to make it take 25% of the screen at the bottom
tmux split-window -v -p 25 "tmux attach-session -t global" 