#!/usr/bin/env bash

CLASS="$1"

if [ -z "$1" ]; then
    echo "Error: No class name provided."
    exit 1
fi

if pgrep -f "kitty.*--class $CLASS" >/dev/null; then
    pkill -f "kitty.*--class $CLASS"
else
    kitty --class $CLASS env NO_TMUX=1 fish -c \
        'tmux attach -t scratch-term 2>/dev/null || tmux new -s scratch-term'
fi
