#!/bin/bash
flag=/home/shin/.config/hypr/layout-mode/flag.txt
src=/home/shin/.config/hypr/layout-mode
dest=/home/shin/.config/hypr
if [ $(cat $flag) -eq 0 ]; then
	cp $src/layout-master.conf $dest/layout.conf
	echo 1 >$flag
else

	cp $src/layout-dwindle.conf $dest/layout.conf
	echo 0 >$flag
fi
