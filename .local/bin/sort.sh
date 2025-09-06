#!/bin/bash

SRC_DIR="$1"

REGULLAR="/Media/Pictures/Wallpapers"
# Target directories
BASE_DIR_HOMEWORK="/Media/Pictures/homework/🌶️"
BASE_DIR_GENERAL="/Media/Pictures/homework"

VERTICAL_HOME="$BASE_DIR_HOMEWORK/vertical"
HORIZONTAL_HOME="$BASE_DIR_HOMEWORK/horizontal"

VERTICAL_GEN="$BASE_DIR_GENERAL/vertical"
HORIZONTAL_GEN="$BASE_DIR_GENERAL/horizontal"

# KEYWORDS="cum|pussy|penis|sex|fingering|masturbation|handjob|anal|anus|nipples|bottomless|uncensored|erect_nipples|pubic_hair|nude"
KEYWORDS="cum|penis|sex|handjob|anal|paizuri|fellatio"
KEYWORDS2="nipples|pussy|tribadism|masturbation|anus|cunnilingus|naked|nude"
KEYWORDS3="swisuit|thong|underboob|underwear|panties|breasts|bikini|breast_grab|bra|sling_bikini|undressing|maebari|"
# Function: move image by dimensions
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
		mv "$img" $REGULLAR
	fi
done
