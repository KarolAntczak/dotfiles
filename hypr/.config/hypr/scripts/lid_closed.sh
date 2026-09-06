#!/bin/bash
if hyprctl monitors -j | jq -e '[.[] | select(.name != "eDP-1")] | length > 0' > /dev/null; then
    hyprctl eval "hl.monitor({output = 'eDP-1', disabled = true})"
else
    systemctl suspend
fi
