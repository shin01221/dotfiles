#!/usr/bin/env bash

noctaliaConf="$HOME/.config/noctalia/settings.json"
niriConf="$HOME/.config/niri/config.kdl"
wlrConf="$HOME/.config/wlr-which-key/niri.yaml"
matConf="$HOME/.config/matugen/templates/which-key/colors.json"

if rg -q '\/\/\s*.*"transparency.*' "$niriConf"; then
    sd '//\s+.*transparency.*' 'include "transparency.kdl"' "$niriConf"
    jq -r '.ui.panelBackgroundOpacity = 1.00' "$noctaliaConf" >"$noctaliaConf.tmp" && mv "$noctaliaConf.tmp" "$noctaliaConf"
    sd 'background:\s*(.*)CC"' 'background: ${1}"' "$wlrConf"
    sd '"background":\s(.*)CC",' '"background": ${1}",' "$matConf"
else
    sd '.*transparency.*' '// include "transparency.kdl"' "$niriConf"
    jq -r '.ui.panelBackgroundOpacity = 0.80' "$noctaliaConf" >"$noctaliaConf.tmp" && mv "$noctaliaConf.tmp" "$noctaliaConf"
    sd 'background:\s*(.*)"' 'background: ${1}CC"' "$wlrConf"
    sd '"background":\s(.*)",' '"background": ${1}CC",' "$matConf"
fi
