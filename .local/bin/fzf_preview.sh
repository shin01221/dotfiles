#!/bin/bash

file="$1"
[ -z "$file" ] && { echo "Usage: fzf_preview.sh <file>" >&2; exit 1; }

mime_type=$(file -b --mime-type "$file" 2>/dev/null)
width="${FZF_PREVIEW_COLUMNS:-80}"
height="${FZF_PREVIEW_LINES:-40}"

has_cmd() { command -v "$1" >/dev/null 2>&1; }

# Kitty image protocol works in kitty and ghostty, but NOT through tmux
in_tmux() { [ -n "$TMUX" ]; }

is_kitty_protocol() {
    in_tmux && return 1
    [ -n "$KITTY_WINDOW_ID" ] && return 0
    [ "$TERM_PROGRAM" = "ghostty" ] && return 0
    [ "$TERM_PROGRAM" = "kitty" ] && return 0
    [ -n "$GHOSTTY_RESOURCES_DIR" ] && return 0
    return 1
}

clear_image() {
    printf '\e_Ga=d\e\\'
}

display_image_kitty() {
    local img="$1"
    [ ! -f "$img" ] && return 1
    chafa -f kitty --scale=max \
        --size="${width}x${height}" "$img" 2>/dev/null
}

display_image_chafa() {
    local img="$1"
    [ ! -f "$img" ] && return 1
    chafa -f symbols --symbols=all --scale=max --work=9 \
        --size="${width}x${height}" "$img" 2>/dev/null
}

display_image() {
    local img="$1"
    if [ -n "$CHAFA_DEBUG" ]; then
        echo "CHAFA_DEBUG: tmux=$(in_tmux && echo yes || echo no)" >&2
        echo "CHAFA_DEBUG: KITTY_WINDOW_ID=${KITTY_WINDOW_ID:-unset}" >&2
        echo "CHAFA_DEBUG: TERM_PROGRAM=${TERM_PROGRAM:-unset}" >&2
        echo "CHAFA_DEBUG: GHOSTTY_RESOURCES_DIR=${GHOSTTY_RESOURCES_DIR:-unset}" >&2
    fi
    if is_kitty_protocol && has_cmd chafa; then
        [ -n "$CHAFA_DEBUG" ] && echo "CHAFA_DEBUG: using kitty protocol" >&2
        display_image_kitty "$img" || display_image_chafa "$img"
    elif has_cmd chafa; then
        [ -n "$CHAFA_DEBUG" ] && echo "CHAFA_DEBUG: using symbols" >&2
        clear_image
        display_image_chafa "$img"
    else
        echo "Image: $(basename "$img")"
    fi
}

case "$mime_type" in
    image/*)
        display_image "$file"
        ;;
    video/*)
        if has_cmd ffmpegthumbnailer; then
            tmp_thumb=$(mktemp /tmp/fzf_preview_thumb.XXXXXX.jpg)
            if ffmpegthumbnailer -i "$file" -o "$tmp_thumb" -s 480 -q 10 2>/dev/null; then
                display_image "$tmp_thumb"
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
        if has_cmd bat; then
            bat --style=numbers --color=always --line-range :100 "$file" 2>/dev/null || head -100 "$file"
        else
            head -100 "$file"
        fi
        ;;
    inode/directory)
        clear_image
        ls --color=always "$file" 2>/dev/null || echo "Directory: $file"
        ;;
    application/pdf)
        if has_cmd pdftotext; then
            clear_image
            pdftotext "$file" - 2>/dev/null | head -100
        else
            echo "PDF: $(basename "$file")"
        fi
        ;;
    *)
        clear_image
        echo "File: $(basename "$file")"
        echo "Type: $mime_type"
        ;;
esac
