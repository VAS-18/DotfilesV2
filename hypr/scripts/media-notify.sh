#!/bin/bash
last_title=""
playerctl --follow metadata --format '{{playerName}}|{{title}}|{{mpris:artUrl}}' | while IFS='|' read player title url; do
  if [ "$title" != "$last_title" ]; then
    case "$player" in
      firefox*|chromium*|brave*|zen-browser*) continue ;;
    esac
    curl -s -o /tmp/album-art.jpg "$url"
    notify-send \
      "$(playerctl metadata artist)" \
      "$title" \
      -i /tmp/album-art.jpg \
      -t 3000
    last_title="$title"
  fi
done
