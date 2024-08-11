#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

display_colors=("0xfffab387", "0xfffab387")

window_count=$(aerospace list-windows --workspace "$1" | wc -l)

if [ "$window_count" -eq 0 ]; then
    sketchybar --set $NAME display=0
else
    sketchybar --set $NAME display=1
fi

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    # sketchybar --set $NAME background.drawing=on
    sketchybar --set $NAME \
        background.color=0xfff38ba8 \
        display=1
else
    # sketchybar --set $NAME background.drawing=off
    # sketchybar --set $NAME background.color=${display_colors[$2 - 1]}
    sketchybar --set $NAME \
        background.color=0
fi
