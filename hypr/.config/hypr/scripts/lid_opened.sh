#!/bin/bash
EXTERNAL=$(hyprctl monitors -j | jq -r '.[] | select(.name != "eDP-1") | .name' | head -n1)

# Always re-enable the internal display when lid opens
hyprctl keyword monitor "eDP-1,1920x1200@59.95Hz,0x0,1"

if [ -n "$EXTERNAL" ]; then
   echo "$(date) lid.sh - lid opened, eDP-1 re-enabled alongside $EXTERNAL" >> /tmp/lid.log
else
   echo "$(date) lid.sh - lid opened, no external monitor" >> /tmp/lid.log
fi

brightnessctl set 90%
sleep 0.3
systemctl --user restart dunst
dunstify "Lid opened"
