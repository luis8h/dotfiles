#!/usr/bin/env bash

# Kill existing bars
killall -q polybar

# Wait until they're really gone
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  PRIMARY=$(xrandr --query | grep " primary" | cut -d" " -f1)
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if [[ $m == $PRIMARY ]]; then
      MONITOR=$m polybar --reload main & disown
    else
      MONITOR=$m polybar --reload secondary & disown
    fi
  done
else
  polybar --reload main & disown
fi

