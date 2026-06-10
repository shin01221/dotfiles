#!/usr/bin/env bash

noctaliaConf="$HOME/.config/noctalia"
niriConf="$HOME/.config/niri/config.kdl"

if rg -q '\/\/\s*.*"transparency.*' "$niriConf"; then
    sd '//\s+.*transparency.*' 'include "transparency.kdl"' "$niriConf"
    sd 'background_opacity.*' 'background_opacity = 1.00' "$noctaliaConf/bar.toml"
    sd 'background_opacity.*' 'background_opacity = 1.00' "$noctaliaConf/config.toml"
    sd 'capsule_opacity.*' 'capsule_opacity = 1.00' "$noctaliaConf/bar.toml"
else
    sd '.*transparency.*' '// include "transparency.kdl"' "$niriConf"
    sd 'background_opacity.*' 'background_opacity = 0.90' "$noctaliaConf/bar.toml"
    sd 'background_opacity.*' 'background_opacity = 0.90' "$noctaliaConf/config.toml"
    sd 'capsule_opacity.*' 'capsule_opacity = 0.50' "$noctaliaConf/bar.toml"
fi
