#!/bin/bash
EXTERNAL=$(hyprctl monitors -j | jq -r '.[] | select(.name != "eDP-1") | .name' | head -n1)

if [ -n "$EXTERNAL" ]; then
   echo "$(date) lid.sh - external monitor: $EXTERNAL" >> /tmp/lid.log
   hyprctl keyword monitor "eDP-1, disable"
   hyprctl keyword monitor "$EXTERNAL,preferred,auto,1"
   systemctl --user restart dunst
   sleep 0.3
   dunstify "Lid closed"
else
   echo "$(date) lid.sh - no external, suspending" >> /tmp/lid.log
   systemctl suspend
fi
