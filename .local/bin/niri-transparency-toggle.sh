#!/usr/bin/env bash

noctaliaConf="$HOME/.config/noctalia/settings.json"
niriConf="$HOME/.config/niri/config.kdl"
wlrConf="$HOME/.config/wlr-which-key/niri.yaml"
if rg -q '\/\/\s*.*"transparency.*' "$niriConf"; then
    sd '//\s+.*transparency.*' 'include "transparency.kdl"' "$niriConf"
    jq -r '.ui.panelBackgroundOpacity = 1.00' "$noctaliaConf" >"$noctaliaConf.tmp" && mv "$noctaliaConf.tmp" "$noctaliaConf"
    sd 'background:\s*(.*)CC"' 'background: ${1}"' "$wlrConf"
else
    sd '.*transparency.*' '// include "transparency.kdl"' "$niriConf"
    jq -r '.ui.panelBackgroundOpacity = 0.83' "$noctaliaConf" >"$noctaliaConf.tmp" && mv "$noctaliaConf.tmp" "$noctaliaConf"
    sd 'background:\s*(.*)"' 'background: ${1}CC"' "$wlrConf"
fi
