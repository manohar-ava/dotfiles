#!/usr/bin/env bash

source "$HOME/.config/sketchybar/variables.sh"

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
	sketchybar --set "$NAME" icon.color="$BLUE" background.drawing=on
else
	sketchybar --set "$NAME" icon.color="$COMMENT" background.drawing=off
fi
