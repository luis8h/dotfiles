#!/usr/bin/env bash
# copy-to-clipboard.sh
# Usage: copy-to-clipboard.sh [file]
# If no file is provided, reads from stdin

# Read input either from file or stdin
if [ -n "$1" ]; then
    CONTENT=$(cat "$1")
else
    CONTENT=$(cat)
fi

# Detect clipboard command
if command -v pbcopy >/dev/null 2>&1; then
    printf "%s" "$CONTENT" | pbcopy
elif command -v wl-copy >/dev/null 2>&1; then
    printf "%s" "$CONTENT" | wl-copy
elif command -v xclip >/dev/null 2>&1; then
    printf "%s" "$CONTENT" | xclip -selection clipboard
else
    echo "No clipboard command found!" >&2
    exit 1
fi
