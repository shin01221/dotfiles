#!/bin/bash

# Check if mpd is running
if pgrep -x mpd >/dev/null; then
	systemctl --user stop mpd.service
	notify-send mpd stopped
else
	systemctl --user start mpd.service
	systemctl --user start mpd-mpris.service
	notify-send mpd running
fi
