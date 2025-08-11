#!/bin/bash

set -euo pipefail

echo "[HeroicWallBash] Checking if Heroic is running..."

if pgrep -x heroic > /dev/null; then
  echo "[HeroicWallBash] Restarting Heroic..."

  heroic_id=$(hyprctl clients -j | jq -r '.[] | select(.class == "heroic") | .address' | head -n1)
  workspace=$(hyprctl clients -j | jq -r --arg addr "$heroic_id" '.[] | select(.address == $addr) | .workspace.id')

  pkill -x heroic
  sleep 1
  heroic & disown

  for _ in {1..10}; do
    sleep 0.5
    new_heroic=$(hyprctl clients -j | jq -r '.[] | select(.class == "heroic") | .address' | head -n1)
    [[ -n "$new_heroic" ]] && break
  done

  if [[ -n "${new_heroic:-}" && -n "${workspace:-}" ]]; then
    hyprctl dispatch movetoworkspacesilent "$workspace,address:$new_heroic"
  fi
else
  echo "[HeroicWallBash] Heroic is not running, checking for background processes..."

  heroic_pids=$(pgrep -f heroic || true)

  if [[ -n "$heroic_pids" ]]; then
    echo "[HeroicWallBash] Killing lingering Heroic processes: $heroic_pids"
    kill $heroic_pids
    sleep 1
  fi

  echo "[HeroicWallBash] Starting Heroic..."
  heroic & disown
fi
