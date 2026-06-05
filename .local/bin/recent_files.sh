#!/bin/bash

save_mode=false
print_mode=false
positional=()
for arg in "$@"; do
    case "$arg" in
    --save) save_mode=true ;;
    --print) print_mode=true ;;
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
    fzf --multi \
        --prompt="Recent files> " \
        --height=80% \
        --preview="fzf_preview.sh $(printf '%q' "$search_dir")/{}" \
        --preview-window='right:70%:border:wrap')

[ -z "$selected" ] && exit 0

if $print_mode; then
    while IFS= read -r sel; do
        printf '%s\n' "$search_dir/$sel"
    done <<< "$selected"
elif $save_mode; then
    paths=$(printf '"%s"' "$search_dir/$selected" | paste -sd,)
    printf '%s' "$paths" | wl-copy
else
    while IFS= read -r sel; do
        gio open "$search_dir/$sel"
    done <<< "$selected"
fi
