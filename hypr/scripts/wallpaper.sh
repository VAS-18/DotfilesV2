#!/bin/bash
wallpaper="$1"
awww img "$wallpaper" \
    --transition-type random \
    --transition-pos 0.854,0.977 \
    --transition-duration 1.5
matugen image "$wallpaper" -m dark

sleep 0.5

# killall -9 waybar
killall -9 swayosd-server
swayosd-server --top-margin 0 &
hyprctl reload
# waybar &
