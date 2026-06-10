#!/bin/bash
# Force kitty protocol test - sends raw PNG via kitty protocol, no chafa
file="$1"
[ -z "$file" ] && exit 1

mime_type=$(file -b --mime-type "$file" 2>/dev/null)
width="${FZF_PREVIEW_COLUMNS:-80}"
height="${FZF_PREVIEW_LINES:-40}"

has_cmd() { command -v "$1" >/dev/null 2>&1; }

send_kitty_raw() {
    local img="$1"
    [ ! -f "$img" ] && return 1

    local w h
    read w h <<< $(magick "$img" -format "%w %h" info: 2>/dev/null)
    [ -z "$w" ] && { w=$width; h=$height; }

    local data
    data=$(magick "$img" -strip png:- 2>/dev/null | base64 -w0)
    [ -z "$data" ] && return 1

    printf '\e_Ga=T,f=32,s=%d,v=%d,c=%d,r=%d,m=1\e\\' "$w" "$h" "$width" "$height"

    local chunk_size=4096
    local pos=0
    local len=${#data}

    while [ $pos -lt $len ]; do
        local chunk="${data:$pos:$chunk_size}"
        pos=$((pos + chunk_size))
        if [ $pos -ge $len ]; then
            printf '\e_Gm=0;%s\e\\' "$chunk"
        else
            printf '\e_Gm=1;%s\e\\' "$chunk"
        fi
    done
}

case "$mime_type" in
    image/*)
        send_kitty_raw "$file"
        ;;
    video/*)
        if has_cmd ffmpegthumbnailer; then
            tmp=$(mktemp /tmp/kt_XXXXXX.png)
            ffmpegthumbnailer -i "$file" -o "$tmp" -s 0 -q 10 2>/dev/null
            [ -f "$tmp" ] && send_kitty_raw "$tmp"
            rm -f "$tmp" 2>/dev/null
        fi
        ;;
    *)
        echo "File: $(basename "$file")"
        echo "Type: $mime_type"
        ;;
esac
