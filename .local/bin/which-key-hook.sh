#!/usr/bin/env bash

niriConf="$HOME/.config/niri/config.kdl"
wlrConf="$HOME/.config/wlr-which-key/niri.yaml"
noctaliaConf="$HOME/.config/noctalia/settings.json"
if rg -q '\/\/\s*.*"transparency.*' "$niriConf"; then
    # if rg -q 'background:\s*.*CC'; then
    # exit
    # fi
    sd 'background:\s*(.*)"' 'background: ${1}CC"' "$wlrConf"
else
    sd 'background:\s*(.*)CC"' 'background: ${1}"' "$wlrConf"
fi
