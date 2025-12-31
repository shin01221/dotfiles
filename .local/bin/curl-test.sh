#!/usr/bin/env bash

set -euo pipefail

URLS=(
    https://sarhne.sarahah.pro/5825152496564
    # https://sarhne.sarahah.pro/mohamed001981
)

for url in "${URLS[@]}"; do
    curl \
        --fail \
        --silent \
        --show-error \
        --max-time 10 \
        "$url"
done
