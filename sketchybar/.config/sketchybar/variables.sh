#!/usr/bin/env sh

# Color Palette — Kanagawa Wave (matches borders, ghostty, tmux-ukiyo)
BLACK=0xff16161D
WHITE=0xffDCD7BA
MAGENTA=0xff957FB8
BLUE=0xff7E9CD8
CYAN=0xff7AA89F
GREEN=0xff98BB6C
YELLOW=0xffE6C384
ORANGE=0xFFE46876
RED=0xffE82424
BAR_COLOR=0xff1F1F28
COMMENT=0xff54546D

TRANSPARENT=0x00000000

ICON_COLOR=$WHITE  # Color of all icons
LABEL_COLOR=$WHITE # Color of all labels

ITEM_DIR="$HOME/.config/sketchybar/items"
PLUGIN_DIR="$HOME/.config/sketchybar/plugins"

FONT="Mononoki Nerd Font"

PADDINGS=3

POPUP_BORDER_WIDTH=2
POPUP_CORNER_RADIUS=11
POPUP_BACKGROUND_COLOR=$BLACK
POPUP_BORDER_COLOR=$COMMENT

CORNER_RADIUS=15
BORDER_WIDTH=2

SHADOW=on

# --- Bar geometry (defaults; override per-machine in local.sh at the bottom) ---
BAR_HEIGHT=30
BAR_Y_OFFSET=5
BAR_MARGIN=5
NOTCH_WIDTH=200

SPACE_ICONS=("1" "2" "3" "4" "5" "6")

# Per-machine overrides (untracked / gitignored). Each Mac can set its own bar
# geometry here — e.g. a different notch width or vertical offset per display.
[ -f "$HOME/.config/sketchybar/local.sh" ] && . "$HOME/.config/sketchybar/local.sh"
