#!/bin/bash
source "$HOME/.local/bin/functions.sh"

mode=$1

case $mode in
--fav-manage)
	fav_toggle
	;;
--delete)
	wall_delete
	;;
--sort)
	sort_images "$2"
	;;

--help)
	echo "--fav-manage to remove or add a current wallpaper to favourites"
	echo "--sort to sort wallpapers in the specified directory"
	echo "--delete to delete the current wallpaper"
	;;
esac
