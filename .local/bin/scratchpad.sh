#!/usr/bin/env bash

# kitty --class kitty-dropterm env NO_TMUX=1 fish -c 'tmux attach -t scratch-term 2>/dev/null || tmux new -s scratch-term'
kitty --class kitty-dropterm env NO_TMUX=1 fish -c 'tmux attach -t scratch-term 2>/dev/null || tmux new -s scratch-term'
