#!/usr/bin/env bash
# Prints the tiled layout of the active workspace as waybar JSON.

layout=$(hyprctl activeworkspace -j 2>/dev/null | jq -r '.tiledLayout // .tiled_layout // empty')

case "$layout" in
  scrolling) icon="⇄" ;;
  dwindle)   icon="◧" ;;
  master)    icon="◨" ;;
  monocle)   icon="□" ;;
  "")        icon="?"; layout="unknown" ;;
  *)         icon="•" ;;
esac

jq -nc --arg t "$icon" --arg c "$layout" --arg tt "Layout: $layout" \
  '{text:$t, class:$c, tooltip:$tt}'
