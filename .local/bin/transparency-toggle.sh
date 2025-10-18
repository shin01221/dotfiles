#!/bin/bash

# 🪟 Toggle transparency across Illogical, Kitty, and Hyprland
illogical_conf="$HOME/.config/illogical-impulse/config.json"

# ✅ Read the current state safely
current_state=$(jq -r '.appearance.transparency.enable' "$illogical_conf" 2>/dev/null)
if [ "$current_state" = "true" ]; then
    jq '.appearance.transparency.enable = false' "$illogical_conf" >"$illogical_conf.tmp" && mv "$illogical_conf.tmp" "$illogical_conf"
else
    jq '.appearance.transparency.enable = true' "$illogical_conf" >"$illogical_conf.tmp" && mv "$illogical_conf.tmp" "$illogical_conf"
fi

# 🪟 Toggle Hyprland transparency
hypr_conf="$HOME/.config/hypr/custom/general.conf"
if grep -q '^#\s*source = transparency\.conf' "$hypr_conf"; then
    sed -i 's/^#\s*source = transparency\.conf/source = transparency.conf/' "$hypr_conf"
else
    sed -i 's/^source = transparency\.conf/#source = transparency.conf/' "$hypr_conf"
fi

# 🐱 Toggle Kitty transparency
kitty_conf="$HOME/.config/kitty/kitty.conf"
if grep -q '^[[:space:]]*#[[:space:]]*background_opacity' "$kitty_conf"; then
    # It’s commented → uncomment it and set opacity to 0.90
    sed -i 's/^[[:space:]]*#[[:space:]]*\(background_opacity.*\)/\1/' "$kitty_conf"
    # kitty @ set-background-opacity 0.90
    echo "✨ Kitty transparency enabled"
elif grep -q '^[[:space:]]*background_opacity' "$kitty_conf"; then
    # It’s uncommented → comment it and set opacity to 1.0 (opaque)
    sed -i 's/^[[:space:]]*\(background_opacity.*\)/#\1/' "$kitty_conf"
    # kitty @ set-background-opacity 1.0
    echo "🔒 Kitty transparency disabled"
else
    echo "⚠️ background_opacity line not found in $kitty_conf"
fi
# Apply the change live to all kitty windows (newer kitty)
