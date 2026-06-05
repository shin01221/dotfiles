#!/bin/bash

save_mode=false
print_mode=false
no_picker=false
positional=()
for arg in "$@"; do
    case "$arg" in
    --save) save_mode=true ;;
    --print) print_mode=true ;;
    --no-picker) no_picker=true ;;
    --help)
        echo "Usage: recent_files.sh [--save|--print|--no-picker] [COUNT] [DIR]"
        echo "  --save       Copy paths to clipboard (wl-copy)"
        echo "  --print      Print selected paths to stdout"
        echo "  --no-picker  Skip fzf, print N most recent files directly"
        echo "  COUNT        Number of recent files to show (default: 5)"
        echo "  DIR          Directory to scan (default: .)"
        exit 0
        ;;
    *) positional+=("$arg") ;;
    esac
done
set -- "${positional[@]}"

count="${1:-5}"
[[ "$count" =~ ^[0-9]+$ ]] && shift || count=5

search_dir="${1:-.}"
search_dir="${search_dir/#\~/$HOME}"
search_dir="${search_dir%/}"

[ -d "$search_dir" ] || {
    echo "Error: '$search_dir' is not a directory" >&2
    exit 1
}

files=$(find "$search_dir" -mindepth 1 -maxdepth 1 -not -name 'recent_files.sh' \
    -printf '%T+ %p\n' 2>/dev/null |
    sort -r |
    head -n "$count" |
    cut -d' ' -f2-)

[ -z "$files" ] && {
    echo "No files found" >&2
    exit 1
}

if $no_picker; then
    printf '%s\n' "$files"
    exit 0
fi

command -v fzf >/dev/null 2>&1 || {
    echo "Error: fzf not found" >&2
    exit 1
}

[ -t 1 ] && clear

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
    printf '%s\n' "$search_dir/$selected"
elif $save_mode; then
    paths=$(printf '"%s"' "$search_dir/$selected" | paste -sd,)
    printf '%s' "$paths" | wl-copy
else
    while IFS= read -r sel; do
        gio open "$search_dir/$sel"
    done <<<"$selected"
fi
