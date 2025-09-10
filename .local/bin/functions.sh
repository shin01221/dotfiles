#!/bin/bash

# Vars
path="$(jq -r '.background.wallpaperPath' ~/.config/illogical-impulse/config.json)"
STATE_FILE="$HOME/.cache/current_wallpaper_path"
if [[ ! -e "$path" ]]; then
	if [[ -f "$STATE_FILE" ]]; then
		path="$(<"$STATE_FILE")"
	else
		echo "Error: $path not found and no state file available" >&2
		exit 1
	fi
fi

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

fav_manage() {

	local STATE_FILE="$HOME/.cache/current_wallpaper_path"
	if [[ "$path" == *fav* ]]; then
		sort_images
		return
	fi

	local target_base=/Media/Pictures/fav
	local KEYWORDS="cum|penis|sex|handjob|anal|nipples|pussy|tribadism|masturbation|anus|topless|cunnilingus|naked|nude|swimsuits|swimsuit|cameltoe|thong|sling_bikini|underboob|underwear|panties|bikini|breast_grab|bra|see_through|breasts"
	filename=$(basename "$path")
	lowername=$(echo "$filename" | tr '[:upper:]' '[:lower:]')

	if [[ "$lowername" =~ $KEYWORDS ]]; then
		# If filename has keyword → move inside homework
		mv "$path" "$target_base/hot"
		path="$target_base/hot/$filename"
	else
		# Otherwise → move inside general
		mv "$path" "$target_base/goood"
		path="$target_base/goood/$filename"
	fi

	echo "$path" >"$STATE_FILE"
}

wall_delete() {
	rm "$path"
}
