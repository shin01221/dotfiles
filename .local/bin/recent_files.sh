#!/bin/bash

save_mode=false
positional=()
for arg in "$@"; do
    case "$arg" in
    --save) save_mode=true ;;
    *) positional+=("$arg") ;;
    esac
done
set -- "${positional[@]}"

count="${1:-5}"
[[ "$count" =~ ^[0-9]+$ ]] && shift || count=5

search_dir="${1:-.}"
search_dir="${search_dir/#\~/$HOME}"
search_dir="${search_dir%/}"

clear

files=$(find "$search_dir" -mindepth 1 -maxdepth 1 -not -name 'recent_files.sh' \
    -printf '%T+ %p\n' 2>/dev/null |
    sort -r |
    head -n "$count" |
    cut -d' ' -f2-)

selected=$(printf '%s\n' "$files" |
    while IFS= read -r fullpath; do
        printf "%s\n" "${fullpath#$search_dir/}"
    done |
    fzf --prompt="Recent files> " \
        --height=80% \
        --preview="fzf_preview.sh $(printf '%q' "$search_dir")/{}" \
        --preview-window='right:70%:border:wrap')

[ -z "$selected" ] && exit 0

full_path="$search_dir/$selected"

if $save_mode; then
    printf '"%s"' "$full_path" | wl-copy
else
    gio open "$full_path"
fi
