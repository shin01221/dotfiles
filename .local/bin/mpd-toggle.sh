#!/bin/bash

# Check if mpd is running
if pgrep -x mpd >/dev/null; then
	systemctl --user stop mpd.service
	notify-send "mpd is stopped"
else
	systemctl --user start mpd.service
	notify-send "mpd is running"
fi
