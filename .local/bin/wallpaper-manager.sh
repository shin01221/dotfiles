#!/bin/bash
source "$HOME/.local/bin/functions.sh"

mode=$1

case $mode in
--add-fav)
	fav_add
	;;
--remove)
	wall_remove
	;;
--sort)
	sort_images "$2"
	;;
esac
