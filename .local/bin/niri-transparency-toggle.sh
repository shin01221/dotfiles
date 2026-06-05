#!/usr/bin/env bash

noctaliaConf="$HOME/.config/noctalia/bar.toml"
niriConf="$HOME/.config/niri/config.kdl"

if rg -q '\/\/\s*.*"transparency.*' "$niriConf"; then
    sd '//\s+.*transparency.*' 'include "transparency.kdl"' "$niriConf"
    sd 'background_opacity.*' 'background_opacity = 1.00' "$noctaliaConf"
    sd 'capsule_opacity.*' 'capsule_opacity = 1.00' "$noctaliaConf"
else
    sd '.*transparency.*' '// include "transparency.kdl"' "$niriConf"
    sd 'background_opacity.*' 'background_opacity = 0.90' "$noctaliaConf"
    sd 'capsule_opacity.*' 'capsule_opacity = 0.80' "$noctaliaConf"
    # sd 'background:\s*(.*)"' 'background: ${1}CC"' "$wlrConf"
    # sd '"background":\s(.*)",' '"background": ${1}CC",' "$matConf"
fi
