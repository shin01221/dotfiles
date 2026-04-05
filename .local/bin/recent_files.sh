#!/bin/bash

clear

count="${1:-5}"

find . -maxdepth 1 -not -path '*/.*' -not -name '.' -not -name 'recent_files.sh' -printf '%T+ %p\n' 2>/dev/null |
    sort -r |
    head -n "$count" |
    cut -d' ' -f2- |
    while IFS= read -r name; do
        printf "%s\n" "${name#./}"
    done |
    fzf --prompt="Recent files> " \
        --height=80% \
        --preview='$HOME/.local/bin/fzf_preview.sh {}' \
        --preview-window='right:70%:border:wrap' |
    while IFS= read -r file; do
        [ -n "$file" ] && gio open "$file"
    done
