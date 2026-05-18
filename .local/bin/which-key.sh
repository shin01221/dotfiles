#!/usr/bin/env bash

CONFIG_FILE="$HOME/.config/wlr-which-key/niri.yaml"
GENERATED_JSON="$HOME/.config/wlr-which-key/colors.json"

BG=$(jq -r '.background' "$GENERATED_JSON")
FG=$(jq -r '.color' "$GENERATED_JSON")
BORDER=$(jq -r '.border' "$GENERATED_JSON")

sd '^(color: ).*' "\$1\"${FG}\"" "$CONFIG_FILE"
sd '^(border: ).*' "\$1\"${BORDER}\"" "$CONFIG_FILE"
sd '^(background: ).*' "\$1\"${BG}\"" "$CONFIG_FILE"
