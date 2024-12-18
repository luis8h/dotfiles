#!/bin/sh

if uname | grep -qi darwin; then
    echo "set -g @thumbs-command 'echo -n {} | pbcopy'"
fi
