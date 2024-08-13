#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

export DISPLAY_COLORS=("0xff94e2d5", "0xfffab387", "0xffa6e3a1", "0xffcba6f7")

window_count=$(aerospace list-windows --workspace "$1" | wc -l)

# # showing displays with different colors (very slow...)
# for monitor in $(aerospace list-monitors | awk '{print $1}'); do
#     for ws in $(aerospace list-workspaces --monitor "$monitor"); do
#         if [ "$ws" == "$1" ]; then
#             monitor_id="$monitor"
#             break
#         fi
#     done
#     if [ -n "$monitor_id" ]; then
#         break
#     fi
# done


# # Alternative but also slow
# workspace_ids=()
# monitor_ids=()
# for monitor in $(aerospace list-monitors | awk '{print $1}'); do
#     for workspace in $(aerospace list-workspaces --monitor $monitor --format "%{workspace}"); do
#         workspace_ids+=("$workspace")
#         monitor_ids+=("$monitor")
#     done
# done
# for i in "${!workspace_ids[@]}"; do
#     if [ ${workspace_ids[$i]} == $1 ]; then
#         monitor_id=${monitor_ids[$i]}
#         break;
#     fi
# done


if [ "$window_count" -eq 0 ]; then
    sketchybar --set $NAME display=0
else
    sketchybar --set $NAME \
        display=1 \
        # background.border_color=${DISPLAY_COLORS[$monitor_id - 1]} \

fi

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    # sketchybar --set $NAME background.drawing=on
    sketchybar --set $NAME \
        background.color=0xff585b70 \
        display=1
else
    # sketchybar --set $NAME background.drawing=off
    # sketchybar --set $NAME background.color=${display_colors[$2 - 1]}
    sketchybar --set $NAME \
        background.color=0
fi
