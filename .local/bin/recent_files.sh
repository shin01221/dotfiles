#!/bin/bash

clear

count="${1:-5}"

# If first arg is a number, shift so $1 becomes the directory
[[ "$count" =~ ^[0-9]+$ ]] && shift || count=5

search_dir="${1:-.}"
search_dir="${search_dir/#\~/$HOME}" # expand tilde

find "$search_dir" -maxdepth 1 -not -name '.' -not -name 'recent_files.sh' -printf '%T+ %p\n' 2>/dev/null |
    sort -r |
    head -n "$count" |
    cut -d' ' -f2- |
    while IFS= read -r name; do
        # Strip search_dir prefix for cleaner display
        printf "%s\n" "${name#$search_dir/}"
    done |
    fzf --prompt="Recent files> " \
        --height=80% \
        --preview='$HOME/.local/bin/fzf_preview.sh {}' \
        --preview-window='right:70%:border:wrap' |
    while IFS= read -r file; do
        [ -n "$file" ] && gio open "$file"
    done
