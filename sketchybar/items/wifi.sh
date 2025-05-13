#!/bin/bash

sketchybar --add item wifi right \
           --set wifi script="$PLUGIN_DIR/wifi.sh" \
                      update_freq=10 \
                      icon.padding_left=10 \
                      label.padding_right=10 \
           --subscribe wifi wifi_change mouse.entered mouse.exited 