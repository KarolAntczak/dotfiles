#!/bin/bash
if hyprctl monitors -j | jq -e '[.[] | select(.name != "eDP-1")] | length > 0' > /dev/null; then
    hyprctl keyword monitor "eDP-1, disable"
    sleep 0.5; killall waybar; waybar &
else
    systemctl suspend
fi
