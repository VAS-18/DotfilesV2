#!/bin/bash
last_title=""
playerctl --follow metadata --format '{{playerName}}|{{title}}|{{mpris:artUrl}}' | while IFS='|' read player title url; do
  if [ "$title" != "$last_title" ] && [[ "$player" != "firefox" && "$player" != "chromium" && "$player" != "brave" && "$player" != "zen-browser" ]]; then
    curl -s -o /tmp/album-art.jpg "$url"
    notify-send \
      "$(playerctl metadata artist)" \
      "$title" \
      -i /tmp/album-art.jpg \
      -t 3000
    last_title="$title"
  fi
done