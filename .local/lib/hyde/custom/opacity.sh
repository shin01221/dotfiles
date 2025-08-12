#!/bin/bash
flag=/home/shin/.config/hypr/opacity/flag.txt
src=/home/shin/.config/hypr/opacity
dest=/home/shin/.config/hypr
if [ $(cat $flag) -eq 0 ]; then
	cp $src/opacity-off.conf $dest/windowrules.conf
	echo 1 >$flag
else

	cp $src/opacity-on.conf $dest/windowrules.conf
	echo 0 >$flag
fi
