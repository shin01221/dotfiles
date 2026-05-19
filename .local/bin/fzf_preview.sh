#!/bin/bash

file="$1"
mime_type=$(file -b --mime-type "$file" 2>/dev/null)

usage() {
    cat <<'EOF'
Usage: fzf_preview.sh <file>

Preview file for fzf. Uses kitty icat for images when available.
EOF
    exit 1
}

[ -z "$file" ] && usage

clear_image() {
    [ -n "$KITTY_WINDOW_ID" ] && kitty +kitten icat --clear 2>/dev/null
}

display_image_kitty() {
    local img="$1"
    [ ! -f "$img" ] && return 1
    magick "$img" -resize 1200x1200 -strip jpg:- 2>/dev/null |
        kitty +kitten icat --clear --transfer-mode=memory \
            --place="${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0" - 2>/dev/null
}

display_image_chafa() {
    local img="$1"
    [ ! -f "$img" ] && return 1
    chafa -f symbols --scale=max "$img" 2>/dev/null
}

case "$mime_type" in
    image/*)
        if [ -n "$KITTY_WINDOW_ID" ] && command -v kitty >/dev/null 2>&1; then
            display_image_kitty "$file"
        elif command -v chafa >/dev/null 2>&1; then
            display_image_chafa "$file"
        else
            echo "Image: $(basename "$file")"
        fi
        ;;
    video/*)
        if command -v ffmpegthumbnailer >/dev/null 2>&1; then
            tmp_thumb=$(mktemp /tmp/fzf_preview_thumb.XXXXXX.jpg)
            if ffmpegthumbnailer -i "$file" -o "$tmp_thumb" -s 480 2>/dev/null; then
                if [ -n "$KITTY_WINDOW_ID" ] && command -v kitty >/dev/null 2>&1; then
                    display_image_kitty "$tmp_thumb"
                elif command -v chafa >/dev/null 2>&1; then
                    display_image_chafa "$tmp_thumb"
                else
                    echo "Video: $(basename "$file")"
                fi
            else
                echo "Video: $(basename "$file")"
            fi
            rm -f "$tmp_thumb" 2>/dev/null
        else
            echo "Video: $(basename "$file")"
        fi
        ;;
    text/*|application/json|application/javascript|application/xml|application/x-shellscript)
        clear_image
        if command -v bat >/dev/null 2>&1; then
            bat --style=numbers --color=always --line-range :100 "$file" 2>/dev/null || head -100 "$file" 2>/dev/null
        else
            head -100 "$file" 2>/dev/null
        fi
        ;;
    inode/directory)
        clear_image
        ls --color=always "$file" 2>/dev/null || echo "Directory: $file"
        ;;
    *)
        clear_image
        echo "File: $file"
        echo "Type: $mime_type"
        ;;
esac
