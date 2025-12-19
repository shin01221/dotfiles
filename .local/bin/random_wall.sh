#!/usr/bin/env bash

check=$(ps -aux | rg 'noctalia' | wc -l)
if [[ check -gt 2 ]]; then
    exit
else
    # Get current wallpaper path from JSON
    config_file="$HOME/.config/illogical-impulse/config.json"
    wallpaper_path="$(jq -r '.background.wallpaperPath' "$config_file")"
    STATE_FILE="$HOME/.cache/current_wallpaper_path"

    # Get the directory containing the wallpapers
    wallpaper_dir="$(dirname "$wallpaper_path")"

    # Ensure the directory exists
    if [[ ! -d "$wallpaper_dir" ]]; then
        echo "Error: Wallpaper directory not found: $wallpaper_dir"
        exit 1
    fi

    # Find all images directly in this directory (skip subdirectories like "fav")
    mapfile -t images < <(find "$wallpaper_dir" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) | grep -vF -- "$wallpaper_path")

    # If no other images are found, exit
    if [[ ${#images[@]} -eq 0 ]]; then
        echo "Error: No alternative wallpapers found in $wallpaper_dir"
        exit 1
    fi

    # Pick a random image from the remaining ones
    random_image="$(printf "%s\n" "${images[@]}" | shuf -n 1)"

    # Run your wallpaper switch script with the random image
    bash "$HOME/.config/quickshell/ii/scripts/colors/switchwall.sh" "$random_image" 2>/dev/null

    echo "$random_image" >"$STATE_FILE"
fi
