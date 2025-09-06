#!/bin/bash

# Vars
path="$(jq -r '.background.wallpaperPath' ~/.config/illogical-impulse/config.json)"

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
		mv "$img" "$hdir/" # fallback: treat square as vertical
	fi
}

sort_images() {
	local SRC_DIR="$1"
	local REGULLAR="/Media/Pictures/Wallpapers"
	# Target directories
	local BASE_DIR_HOMEWORK="/Media/Pictures/homework/🌶️"
	local BASE_DIR_GENERAL="/Media/Pictures/homework"

	local VERTICAL_HOME="$BASE_DIR_HOMEWORK/vertical"
	local HORIZONTAL_HOME="$BASE_DIR_HOMEWORK/horizontal"

	local VERTICAL_GEN="$BASE_DIR_GENERAL/vertical"
	local HORIZONTAL_GEN="$BASE_DIR_GENERAL/horizontal"

	# KEYWORDS="cum|pussy|penis|sex|fingering|masturbation|handjob|anal|anus|nipples|bottomless|uncensored|erect_nipples|pubic_hair|nude"
	local KEYWORDS="cum|penis|sex|handjob|anal|paizuri|fellatio"
	local KEYWORDS2="nipples|pussy|tribadism|masturbation|anus|cunnilingus|naked|nude"
	local KEYWORDS3="swisuit|thong|underboob|underwear|panties|breasts|bikini|breast_grab|bra|sling_bikini|undressing|maebari|"
	# Function: move image by dimensions

	# Loop over images
	for img in "$SRC_DIR"/*.{jpg,jpeg,png,gif}; do
		[ -e "$img" ] || continue

		filename=$(basename "$img")
		lowername=$(echo "$filename" | tr '[:upper:]' '[:lower:]')

		if [[ "$lowername" =~ $KEYWORDS ]]; then
			# If filename has keyword → move inside homework
			mv "$img" "$BASE_DIR_HOMEWORK/sex"
		elif [[ "$lowername" =~ $KEYWORDS2 ]]; then
			# If filename has keyword group 2 → move inside special
			move_by_dimensions "$img" "$VERTICAL_HOME" "$HORIZONTAL_HOME"
		elif [[ "$lowername" =~ $KEYWORDS3 ]]; then
			# If filename has keyword group 2 → move inside special
			move_by_dimensions "$img" "$VERTICAL_GEN" "$HORIZONTAL_GEN"
		else
			# Otherwise → move inside general
			mv "$img" "$REGULLAR"
		fi
	done
}

fav_add() {
	local target_base=/Media/Pictures/fav
	local KEYWORDS="cum|penis|sex|handjob|anal|nipples|pussy|tribadism|masturbation|anus|topless|cunnilingus|naked|nude|swimsuits|cameltoe|thong|sling_bikini|underboob|underwear|panties|bikini|breast_grab|bra|see_through|breasts"
	filename=$(basename "$path")
	lowername=$(echo "$filename" | tr '[:upper:]' '[:lower:]')

	if [[ "$lowername" =~ $KEYWORDS ]]; then
		# If filename has keyword → move inside homework
		mv "$path" "$target_base/hot"
	else
		# Otherwise → move inside general
		mv "$path" "$target_base/goood"
	fi
}
wall_remove() {
	rm "$path"
}
