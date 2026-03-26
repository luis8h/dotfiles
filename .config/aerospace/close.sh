#!/bin/bash
focused_app=$(osascript -e 'tell application "System Events" to get name of first process whose frontmost is true')

if [ "$focused_app" = "ghostty" ]; then
    # osascript -e "display notification \"triggered\""
    osascript -e "tell application \"Ghostty\" to quit"
else
    # osascript -e "display notification \"triggered else\""
    osascript -e "tell application \"$focused_app\" to close front window"
fi
