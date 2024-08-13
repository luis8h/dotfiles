#!/bin/bash

sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all); do
    window_count=$(aerospace list-windows --workspace $sid | wc -l)

    # for monitor in $(aerospace list-monitors | awk '{print $1}'); do
    #     for ws in $(aerospace list-workspaces --monitor "$monitor"); do
    #         if [ "$ws" == "$sid" ]; then
    #             monitor_id="$monitor"
    #             break
    #         fi
    #     done
    #     if [ -n "$monitor_id" ]; then
    #         break
    #     fi
    # done

    sketchybar \
        --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
            background.corner_radius=5 \
            background.height=20 \
            background.drawing=on \
            background.border_width=2 \
            label="$sid" \
            click_script="aerospace workspace $sid" \
            script="$PLUGIN_DIR/aerospace.sh $sid $monitor_id"
            # background.border_color=${DISPLAY_COLORS[$monitor_id - 1]} \

    if [ "$window_count" -eq 0 ]; then
        sketchybar --set space.$sid  display=0
    fi
done
