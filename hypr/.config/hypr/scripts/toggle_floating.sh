#!/bin/bash
WINDOW=$(hyprctl activewindow -j)
FLOATING=$(echo "$WINDOW" | jq -r '.floating')
MONITOR_ID=$(echo "$WINDOW" | jq -r '.monitor')

hyprctl dispatch 'hl.dsp.window.float({ action = "toggle" })'

if [ "$FLOATING" = "false" ]; then
    read -r WIDTH HEIGHT <<< "$(hyprctl monitors -j | jq -r --argjson id "$MONITOR_ID" '.[] | select(.id == $id) | "\((.width/.scale/2)|floor) \((.height/.scale/2)|floor)"')"
    hyprctl dispatch "hl.dsp.window.resize({ x = $WIDTH, y = $HEIGHT })"
    hyprctl dispatch 'hl.dsp.window.center()'
fi
