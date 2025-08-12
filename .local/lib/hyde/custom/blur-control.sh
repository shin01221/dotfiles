#!/bin/bash
flag=/home/shin/.config/hypr/blur/flag.txt
src=/home/shin/.config/hypr/blur
dest=/home/shin/.config/hypr
if [ $(cat $flag) -eq 0 ]; then
    cp $src/blur-off.conf $dest/blur-control.conf
    echo 1 >$flag
else
    cp $src/blur-on.conf $dest/blur-control.conf
    echo 0 >$flag
fi
