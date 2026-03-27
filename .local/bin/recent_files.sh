#!/bin/bash

count="${1:-5}"

find . -maxdepth 1 -not -path '*/.*' -not -name '.' -not -name 'recent_files.sh' -printf '%T+ %p\n' 2>/dev/null |
    sort -r |
    head -n "$count" |
    cut -d' ' -f2- |
    while IFS= read -r name; do
        printf "%s\n" "${name#./}"
    done |
    fzf --prompt="Recent files> " |
    while IFS= read -r file; do
        [ -n "$file" ] && gio open "$file"
    done
