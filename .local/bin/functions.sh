#!/bin/bash

# Vars
path="$(jq -r '.background.wallpaperPath' ~/.config/illogical-impulse/config.json)"
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

sort_images() {
	local SRC="${1:-$path}"
	local REGULLAR="/Media/Pictures/Wallpapers"
	# Target directories
	local BASE_DIR_HOMEWORK="/Media/Pictures/homework/🌶️"
	local BASE_DIR_GENERAL="/Media/Pictures/homework"

	local VERTICAL_HOME="$BASE_DIR_HOMEWORK/vertical"
	local HORIZONTAL_HOME="$BASE_DIR_HOMEWORK/horizontal"

	local VERTICAL_GEN="$BASE_DIR_GENERAL/vertical"
	local HORIZONTAL_GEN="$BASE_DIR_GENERAL/horizontal"

	# KEYWORDS="cum|pussy|penis|sex|fingering|masturbation|handjob|anal|anus|nipples|bottomless|uncensored|erect_nipples|pubic_hair|nude"
	local KEYWORDS="penis|sex|handjob|anal|paizuri|fellatio"
	local KEYWORDS2="nipples|nipple_slip|pussy|tribadism|masturbation|anus|cunnilingus|naked|nude"
	local KEYWORDS3="swisuits|swimsuit|thong|underboob|underwear|panties|bikini|topless|sling_bikini|pubic_hair|cameltoe|undressing|maebari"
	# Function: move image by dimensions

	if [ -d "$SRC" ]; then
		files=("$SRC"/*.{jpg,jpeg,png,gif})
	else
		files=("$SRC")
	fi
	# Loop over images

	for img in "${files[@]}"; do
		[ -e "$img" ] || continue

		filename=$(basename "$img")
		lowername=$(echo "$filename" | tr '[:upper:]' '[:lower:]')

		if [[ "$lowername" =~ $KEYWORDS ]]; then
			mv "$img" "$BASE_DIR_HOMEWORK/sex"
		elif [[ "$lowername" =~ $KEYWORDS2 ]]; then
			move_by_dimensions "$img" "$VERTICAL_HOME" "$HORIZONTAL_HOME"
		elif [[ "$lowername" =~ $KEYWORDS3 ]]; then
			move_by_dimensions "$img" "$VERTICAL_GEN" "$HORIZONTAL_GEN"
		else
			mv "$img" "$REGULLAR"
		fi
	done
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
