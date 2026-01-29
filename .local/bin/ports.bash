#!/usr/bin/env bash

mapfile -t ports < <(ss -tulpnH | awk '{split($5,a,":"); print $1, a[length(a)]}' | sort | uniq)
# sudo fuser -n "${ports[$1]}"
act=$(echo "${ports[@]}" | grep "$1")
echo "$act"
# echo "${ports[$1]}"
