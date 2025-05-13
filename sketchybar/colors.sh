#!/bin/bash

# Catppuccin Mocha Color Palette
export ROSEWATER='#f5e0dc'
export FLAMINGO='#f2cdcd'
export PINK='#f5c2e7'
export MAUVE='#cba6f7'
export RED='#f38ba8'
export MAROON='#eba0ac'
export PEACH='#fab387'
export YELLOW='#f9e2af'
export GREEN='#a6e3a1'
export TEAL='#94e2d5'
export SKY='#89dceb'
export SAPPHIRE='#74c7ec'
export BLUE='#89b4fa'
export LAVENDER='#b4befe'
export TEXT='#cdd6f4'
export SUBTEXT1='#bac2de'
export SUBTEXT0='#a6adc8'
export OVERLAY2='#9399b2'
export OVERLAY1='#7f849c'
export OVERLAY0='#6c7086'
export SURFACE2='#585b70'
export SURFACE1='#45475a'
export SURFACE0='#313244'
export BASE='#1e1e2e'
export MANTLE='#181825'
export CRUST='#11111b'
export LAVENDER='#89b4fa'

# Custom dark theme as requested
export DARK_GRAY='#1a1a1a'      # Darker gray for background
export LIGHT_GRAY='#b4befe'     # Lighter gray for item backgrounds
export PINK_TEXT='#ff80bf'      # Pink for text
export BRACKET_COLOR='#313244'  # Dark gray for brackets
export SELECTED_COLOR='#89b4fa' # Brighter pink for selected items

# Main colors for sketchybar
export BAR_COLOR="0xff${DARK_GRAY:1}"       # Dark gray background
export ITEM_BG_COLOR="0xff${LIGHT_GRAY:1}"  # Light gray items
export ACCENT_COLOR="0xff${LIGHT_GRAY:1}"    # Pink accent
export ACCENT_COLOR2="0xff${SELECTED_COLOR:1}" # Selected items
export ACCENT_COLOR3="0xff${GREEN:1}"       # Keep green for other accents
export WHITE="0xff${CRUST:1}"           # Pink for text

# Status colors for different states
export WARNING_COLOR="0xff${YELLOW:1}"     # Warning state
export DANGER_COLOR="0xff${RED:1}"         # Danger/Error state
export SUCCESS_COLOR="0xff${GREEN:1}"      # Success state

# Some opacity variations for visual hierarchy
export TRANSPARENT="0x00000000"            # Fully transparent
export ITEM_BG_COLOR_ALT="0xcc${LIGHT_GRAY:1}"  # Slightly transparent alternative
export BRACKET_BG_COLOR="0xff${BRACKET_COLOR:1}" # Dark gray for brackets

# You can comment out everything below this line - keeping for reference
# -- Old color schemes --

# -- Teal Scheme --
# export BAR_COLOR=0xff001f30
# export ITEM_BG_COLOR=0xff003547
# export ACCENT_COLOR=0xff2cf9ed

# -- Gray Scheme --
# export BAR_COLOR=0xff101314
# export ITEM_BG_COLOR=0xff353c3f
# export ACCENT_COLOR=0xffffffff

# -- Purple Scheme --
# export BAR_COLOR=0xff140c42
# export ITEM_BG_COLOR=0xff2b1c84
# export ACCENT_COLOR=0xffeb46f9

# -- Red Scheme ---
# export BAR_COLOR=0xff23090e
# export ITEM_BG_COLOR=0xff591221
# export ACCENT_COLOR=0xffff2453

# -- Blue Scheme ---
# export BAR_COLOR=0xff021254
# export ITEM_BG_COLOR=0xff093aa8
# export ACCENT_COLOR=0xff15bdf9

# -- Green Scheme --
# export BAR_COLOR=0xff003315
# export ITEM_BG_COLOR=0xff008c39
# export ACCENT_COLOR=0xff1dfca1

# -- Orange Scheme --
# export BAR_COLOR=0xff381c02
# export ITEM_BG_COLOR=0xff99440a
# export ACCENT_COLOR=0xfff97716

# -- Yellow Scheme --
# export BAR_COLOR=0xff2d2b02
# export ITEM_BG_COLOR=0xff8e7e0a
# export ACCENT_COLOR=0xfff7fc17