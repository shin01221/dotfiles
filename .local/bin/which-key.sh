#!/usr/bin/env bash

CONFIG_FILE="$HOME/.config/wlr-which-key/niri.yaml"
# The path where matugen saved the generated json
GENERATED_JSON="$HOME/.config/wlr-which-key/colors.json"

BG=$(jq -r '.background' "$GENERATED_JSON")
FG=$(jq -r '.color' "$GENERATED_JSON")
BORDER=$(jq -r '.border' "$GENERATED_JSON")

sed -i "s/^\(background: \).*/\1\"${BG}\"/" "$CONFIG_FILE"
sed -i "s/^\(color: \).*/\1\"${FG}\"/" "$CONFIG_FILE"
sed -i "s/^\(border: \).*/\1\"${BORDER}\"/" "$CONFIG_FILE"
