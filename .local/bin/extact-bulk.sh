#!/usr/bin/env bash

SRC="/etc/xdg/quickshell/NibrasShell/config/gtk-themes"
DEST="$HOME/.themes"

mkdir -p "$DEST"

for f in "$SRC"/*.zip "$SRC"/*.tar.gz "$SRC"/*.tar.xz; do
    [ -e "$f" ] || continue
    case "$f" in
    *.zip) unzip -q "$f" -d "$DEST" ;;
    *.tar.gz) tar -xzf "$f" -C "$DEST" ;;
    *.tar.xz) tar -xJf "$f" -C "$DEST" ;;
    esac
done
