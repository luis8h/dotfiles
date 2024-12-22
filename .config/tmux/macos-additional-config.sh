#!/bin/sh

if uname | grep -qi darwin; then
    echo "set -g @thumbs-command 'echo -n {} | pbcopy'"
    # echo 'bind-key -n MouseDragEnd1Pane run "tmux copy-mode -M \; tmux save-buffer - | pbcopy"'
    # echo 'bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel \; run "tmux save-buffer - | pbcopy"'
fi
