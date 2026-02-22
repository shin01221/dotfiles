#!/usr/bin/env bash

STATE_FILE="/tmp/niri-last-tiled-size"

# read state
is_floating=$(niri msg -j focused-window | jq -r '.is_floating')

if [[ "$is_floating" == "false" ]]; then
    # ----- going tiled -> floating -----

    # save current tiled size
    niri msg -j focused-window |
        jq -r '.window_size | "\(.width) \(.height)"' \
            >"$STATE_FILE"

    # toggle floating
    niri msg action toggle-window-floating
    # sleep 0.05

    # apply floating size
    niri msg action set-window-width 60%
    niri msg action set-window-height 70%
    niri msg action center-window

else
    # ----- going floating -> tiled -----

    # toggle back first
    niri msg action toggle-window-floating
    sleep 0.05

    # restore size if exists
    if [[ -f "$STATE_FILE" ]]; then
        read -r w h <"$STATE_FILE"

        niri msg action set-window-width fixed "$w"
        niri msg action set-window-height fixed "$h"
    fi
fi
