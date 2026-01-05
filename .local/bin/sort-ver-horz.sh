#!/bin/bash

# Directories
SRC_DIR="$1"
VERTICAL_DIR="/Media/Pictures/homework/ecchi/nobreast/vertical"
HORIZONTAL_DIR="/Media/Pictures/homework/ecchi/nobreast/horizontal"

# Loop over images
for img in "$SRC_DIR"/*.{jpg,jpeg,png,gif}; do
	# Skip if no matches
	[ -e "$img" ] || continue

	# Get width and height using ImageMagick
	dimensions=$(identify -format "%w %h" "$img" 2>/dev/null)
	[ -z "$dimensions" ] && continue # skip if identify fails

	width=$(echo "$dimensions" | awk '{print $1}')
	height=$(echo "$dimensions" | awk '{print $2}')

	if [ "$height" -gt "$width" ]; then
		mv "$img" "$VERTICAL_DIR/"
	elif [ "$width" -gt "$height" ]; then
		mv "$img" "$HORIZONTAL_DIR/"
	fi
done
