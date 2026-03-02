#!/usr/bin/env bash

noctaliaConf="$HOME/.config/noctalia/settings.json"
niriConf="$HOME/.config/niri/config.kdl"
if rg -q '\/\/\s*.*"transparency.*' "$niriConf"; then
    sd '//\s+.*transparency.*' 'include "transparency.kdl"' "$niriConf"
    jq -r '.ui.panelBackgroundOpacity = 1.00' "$noctaliaConf" >"$noctaliaConf.tmp" && mv "$noctaliaConf.tmp" "$noctaliaConf"
else
    sd '.*transparency.*' '// include "transparency.kdl"' "$niriConf"
    jq -r '.ui.panelBackgroundOpacity = 0.90' "$noctaliaConf" >"$noctaliaConf.tmp" && mv "$noctaliaConf.tmp" "$noctaliaConf"
fi
