#!/bin/bash

file="$1"
mime_type=$(file -b --mime-type "$file" 2>/dev/null)

display_image() {
    local img_path="$1"
    
    if [ ! -f "$img_path" ]; then
        echo "File not found: $img_path"
        return 1
    fi
    
    if command -v chafa >/dev/null 2>&1; then
        chafa -f symbols --scale=max "$img_path" 2>/dev/null
        return 0
    fi
    
    echo "Image: $(basename "$img_path")"
}

case "$mime_type" in
    image/*)
        display_image "$file"
        ;;
    video/*)
        if command -v ffmpegthumbnailer >/dev/null 2>&1; then
            tmp_thumb=$(mktemp /tmp/fzf_preview_thumb.XXXXXX.jpg)
            if ffmpegthumbnailer -i "$file" -o "$tmp_thumb" -s 480 2>/dev/null; then
                display_image "$tmp_thumb"
            else
                echo "Video: $file"
            fi
            rm -f "$tmp_thumb" 2>/dev/null
        else
            echo "Video: $file"
        fi
        ;;
    text/*|application/json|application/javascript|application/xml|application/x-shellscript)
        if command -v bat >/dev/null 2>&1; then
            bat --style=numbers --color=always --line-range :100 "$file" 2>/dev/null || head -100 "$file" 2>/dev/null
        else
            head -100 "$file" 2>/dev/null
        fi
        ;;
    *)
        echo "File: $file"
        echo "Type: $mime_type"
        ;;
esac
