players=$(playerctl --list-all | grep -o spotify)
statusSpotify=$(playerctl status --player spotify)
statusMpd=$(playerctl status --player mpd)
if [[ $players =~ spotify && $statusSpotify =~ Playing ]]; then
    lrc_tty --raw --player spotify
fi
if [[ $players =~ mpd && $statusMpd =~ Playing ]]; then
    lrc_tty --raw --player mpd
fi
