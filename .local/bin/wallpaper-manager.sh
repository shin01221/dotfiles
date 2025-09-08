#!/bin/bash
source "$HOME/.local/bin/functions.sh"

mode=$1

case $mode in
--fav-manage)
	fav_manage
	;;
--delete)
	wall_delete
	;;
--sort)
	sort_images "$2"
	;;
esac
