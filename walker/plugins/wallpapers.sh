#!/bin/bash

# Configuration
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# If no arguments, Walker is asking for the list of items
if [ "$#" -eq 0 ]; then
    ls "$WALLPAPER_DIR" | while read -r file; do
        # Output format: ID|Label|Subtext|Icon
        echo "$file|$file|Set as wallpaper|$WALLPAPER_DIR/$file"
    done
else
    # If there is an argument, the user selected an item
    # Use swww, hyprpaper, or feh here
    swww img "$WALLPAPER_DIR/$1" --transition-type grow
fi
