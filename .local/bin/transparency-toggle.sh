#!/bin/bash

# Toggle transparency across Illogical, Kitty, and Hyprland
illogical_conf="$HOME/.config/illogical-impulse/config.json"
noctalia_conf="$HOME/.config/noctalia/settings.json"
foot_conf="$HOME/.config/foot/transparency.conf"

# Read the current state safely
current_state=$(jq -r '.appearance.transparency.enable' "$illogical_conf" 2>/dev/null)
if [ "$current_state" = "true" ]; then
    jq '.appearance.transparency.enable = false' "$illogical_conf" >"$illogical_conf.tmp" && mv "$illogical_conf.tmp" "$illogical_conf"
else
    jq '.appearance.transparency.enable = true' "$illogical_conf" >"$illogical_conf.tmp" && mv "$illogical_conf.tmp" "$illogical_conf"
fi

# Toggle Hyprland transparency
hypr_conf="$HOME/.config/hypr/custom/general.conf"
if grep -q '^#\s*source = transparency\.conf' "$hypr_conf"; then
    sed -i 's/^#\s*source = transparency\.conf/source = transparency.conf/' "$hypr_conf"
    jq -r '.ui.panelBackgroundOpacity = 1.00' "$noctalia_conf" >"$noctalia_conf.tmp" && mv "$noctalia_conf.tmp" "$noctalia_conf"
else
    sed -i 's/^source = transparency\.conf/#source = transparency.conf/' "$hypr_conf"
    jq -r '.ui.panelBackgroundOpacity = 0.85' "$noctalia_conf" >"$noctalia_conf.tmp" && mv "$noctalia_conf.tmp" "$noctalia_conf"
fi

# Toggle foot transparency
if rg -q '^alpha=1' "$foot_conf"; then
    sed -i 's/^alpha.*/alpha=.85/' "$foot_conf"
    foot --reload
elif rg -q '^alpha=\.\d+' "$foot_conf"; then
    sed -i 's/^alpha.*/alpha=1/' "$foot_conf"
    foot --reload
fi
