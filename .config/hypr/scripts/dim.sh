#!/bin/bash
# Usage: dim.sh 0.1  or  dim.sh 1.0
BRIGHTNESS="${1:-1.0}"
hyprctl monitors -j \
  | grep -oP '"name":\s*"\K[^"]+' \
  | xargs -I{} wlr-randr --output {} --brightness "$BRIGHTNESS"
