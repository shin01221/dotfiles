#!/bin/bash

# Vars
if pgrep -f 'qs -c noctalia' >/dev/null; then
	path=$(jq -r '.wallpapers["eDP-2"]' ~/.cache/noctalia/wallpapers.json)
else
	path=$(jq -r '.background.wallpaperPath' ~/.config/illogical-impulse/config.json)
fi
base_homework="/Media/Pictures/homework"
base_fav="/Media/Pictures/fav"
base_wallpapers="/Media/Pictures/Wallpapers"
STATE_FILE="$HOME/.cache/current_wallpaper_path"
if [[ ! -e "$path" ]]; then
	if [[ -f "$STATE_FILE" ]]; then
		path="$(<"$STATE_FILE")"
	else
		notify-send "⚠️ Wallpaper Toggle" "Error: Wallpaper not found and no state file exists."
		exit 1
	fi
fi

# Normalize with realpath
# path="$(realpath -m "$path")"
# base_homework="$(realpath -m "$base_homework")"
# base_fav="$(realpath -m "$base_fav")"
# base_wallpapers="$(realpath -m "$base_wallpapers")"

#Functions
move_by_dimensions() {
	local img="$1"
	local vdir="$2"
	local hdir="$3"

	dimensions=$(identify -format "%w %h" "$img" 2>/dev/null) || return
	[ -z "$dimensions" ] && return

	width=$(echo "$dimensions" | awk '{print $1}')
	height=$(echo "$dimensions" | awk '{print $2}')

	if [ "$height" -gt "$width" ]; then
		mv "$img" "$vdir/"
	elif [ "$width" -gt "$height" ]; then
		mv "$img" "$hdir/"
	else
		mv "$img" "$vdir/" # fallback: treat square as vertical
	fi
}

fav_toggle() {
	dir="$(dirname -- "$path")"
	filename="$(basename -- "$path")"

	# If the file is already inside a 'fav' directory → move it one level up
	if [[ "$dir" == */fav ]]; then
		parent_dir="$(dirname -- "$dir")"
		target="$parent_dir/$filename"
		mv -- "$path" "$target" && notify-send "Fav toggle" "Removed from fav 💢"

	# Otherwise → move it into a 'fav' subdirectory in the same location
	else
		fav_dir="$dir/fav"
		mkdir -p -- "$fav_dir"
		target="$fav_dir/$filename"
		mv -- "$path" "$target" && notify-send "Fav toggle" "Added to fav 🌡️"
	fi

	echo "$target" >"$STATE_FILE"
}
wall_delete() {
	rm "$path"
}
