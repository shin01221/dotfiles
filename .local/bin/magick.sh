#!/usr/bin/env bash
source "$HOME/.local/bin/functions.sh"
# Usage:
#   ./imgtool.sh --resize-height in.png out.png HEIGHT [top|bottom|center]
#   ./imgtool.sh --resize-width  in.png out.png WIDTH  [left|right|center]
#   ./imgtool.sh --downscale     in.png out.png PERCENT
#   ./imgtool.sh --sort DIR

mode="$1"
input="$2"
output="$3"
val="$4"
position="$5"

# Handle modes
case "$mode" in
--resize-height)
	if [[ -z "$input" || -z "$output" || -z "$val" ]]; then
		echo "Error: Missing arguments for --resize-height"
		exit 1
	fi

	# Set default position
	if [[ -z "$position" ]]; then
		position="bottom"
	fi

	case "$position" in
	top) gravity="South" ;;
	center) gravity="Center" ;;
	bottom | *) gravity="North" ;;
	esac

	magick "$input" -gravity "$gravity" -crop "x$val+0+0" +repage "$output"
	;;

--resize-width)
	if [[ -z "$input" || -z "$output" || -z "$val" ]]; then
		echo "Error: Missing arguments for --resize-width"
		exit 1
	fi

	if [[ -z "$position" ]]; then
		position="center"
	fi

	case "$position" in
	left) gravity="East" ;;
	center | *) gravity="Center" ;;
	right) gravity="West" ;;
	esac

	magick "$input" -gravity "$gravity" -crop "$val"x+0+0 +repage "$output"
	;;

--downscale)
	if [[ -z "$input" || -z "$output" || -z "$val" ]]; then
		echo "Error: Missing arguments for --downscale"
		exit 1
	fi

	# remove % if present
	if [[ "$val" == *% ]]; then
		val="${val%\%}"
	fi
	magick "$input" -resize "$val%" "$output"
	;;

--sort)
	if [[ -z "$input" ]]; then
		echo "Error: Please provide directory to sort."
		exit 1
	fi
	sort_images "$input"
	;;

*)
	echo "Usage:"
	echo "  magick.sh --resize-height <in> <out> HEIGHT [top|bottom|center]"
	echo "  magick.sh --resize-width  <in> <out> WIDTH  [left|right|center]"
	echo "  magick.sh --downscale     <in> <out> PERCENT"
	echo "  magick.sh --sort DIR"
	exit 1
	;;
esac
