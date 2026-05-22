players=$(playerctl --list-all | grep -o spotify)
if [[ $players =~ spotify ]]; then
    lrc_tty --raw --player spotify
else
    lrc_tty --raw
fi
