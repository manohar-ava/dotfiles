#!/usr/bin/env bash

NPROC=$(sysctl -n hw.logicalcpu 2>/dev/null || nproc 2>/dev/null || echo 4)
sketchybar --set "$NAME" icon="" label="$(ps -A -o %cpu | awk -v n="$NPROC" '{s+=$1} END {printf "%.1f%%\n", s/n}')"
