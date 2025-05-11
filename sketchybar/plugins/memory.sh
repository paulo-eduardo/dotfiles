#!/bin/bash

# Get used memory from vm_stat (pages * 4KB page size) and convert to MB
# Alternative: top -l 1 -s 0 | grep PhysMem | awk '{print $2}'
USED_MEM_PAGES=$(vm_stat | awk '/Pages active/ {active=$3} /Pages inactive/ {inactive=$3} /Pages wired down/ {wired=$3} /Pages speculative/ {speculative=$3} END {print active+inactive+wired+speculative}')
USED_MEM_MB=$(echo "$USED_MEM_PAGES * 4096 / 1024 / 1024" | bc)

# Convert to GB and format
USED_MEM_GB=$(awk -v used="$USED_MEM_MB" 'BEGIN {printf "%.1f", used/1024}')
TOTAL_MEM_GB=$(awk -v total="$TOTAL_MEM_MB" 'BEGIN {printf "%.1f", total/1024}')

sketchybar --set memory label="${USED_MEM_GB}GB"