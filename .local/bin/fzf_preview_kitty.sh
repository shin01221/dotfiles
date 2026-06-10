#!/bin/bash
# Test script: kitty protocol image preview only (no fallback)
# Shows errors for debugging.

file="$1"
[ -z "$file" ] && { echo "Usage: fzf_preview_kitty.sh <file>" >&2; exit 1; }

mime_type=$(file -b --mime-type "$file" 2>/dev/null)
width="${FZF_PREVIEW_COLUMNS:-80}"
height="${FZF_PREVIEW_LINES:-40}"
resize="${width}x${height}>"

echo "Debug: file=$file mime=$mime_type cols=$width rows=$height" >&2

display_image_kitty() {
    local img="$1"
    [ ! -f "$img" ] && { echo "Debug: file not found: $img" >&2; return 1; }

    # Use a temp file to avoid pipe issues
    local tmp_img
    tmp_img=$(mktemp /tmp/kitty_preview_XXXXXX.png)
    magick "$img" -resize "$resize" -strip png:"$tmp_img" 2>&1
    if [ $? -ne 0 ]; then
        echo "Debug: magick failed" >&2
        rm -f "$tmp_img"
        return 1
    fi

    kitty +kitten icat --clear --transfer-mode=file \
        --place="${width}x${height}@0x0" "$tmp_img" 2>&1
    local ret=$?
    rm -f "$tmp_img"
    return $ret
}

case "$mime_type" in
    image/*)
        echo "Debug: using kitty protocol" >&2
        display_image_kitty "$file"
        ;;
    video/*)
        if command -v ffmpegthumbnailer >/dev/null 2>&1; then
            tmp_thumb=$(mktemp /tmp/kitty_preview_thumb.XXXXXX.jpg)
            ffmpegthumbnailer -i "$file" -o "$tmp_thumb" -s 480 -q 10 2>&1
            if [ $? -eq 0 ]; then
                display_image_kitty "$tmp_thumb"
            else
                echo "Debug: ffmpegthumbnailer failed" >&2
            fi
            rm -f "$tmp_thumb" 2>/dev/null
        else
            echo "Debug: ffmpegthumbnailer not found" >&2
        fi
        ;;
    *)
        # Non-image: show basic info for testing
        echo "File: $(basename "$file")"
        echo "Type: $mime_type"
        ;;
esac
