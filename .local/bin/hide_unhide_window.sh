#!/usr/bin/env bash
stack_file="/tmp/hide_window_pid_stack.txt"

hide_window() {
	pid=$(hyprctl activewindow -j | jq '.pid')
	hyprctl dispatch movetoworkspacesilent 12,pid:$pid
	echo $pid >>"$stack_file"
}

show_window() {
	pid=$(tail -1 "$stack_file")
	sed -i '$ d' "$stack_file"
	[ -z "$pid" ] && exit
	current=$(hyprctl activeworkspace -j | jq '.id')
	hyprctl dispatch movetoworkspacesilent "$current",pid:"$pid"
}

if [[ "$1" == "h" ]]; then
	hide_window
else
	show_window
fi
