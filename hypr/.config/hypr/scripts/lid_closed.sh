EXTERNAL=$(hyprctl monitors -j | jq -r '.[] | select(.name != "eDP-1") | .name' | head -n1)

if [ -n "$EXTERNAL" ]; then
   hyprctl keyword monitor "eDP-1, disable"
   hyprctl keyword monitor "$EXTERNAL,preferred,auto,1"
   systemctl --user restart dunst
   sleep 0.3
   dunstify "Lid closed" 
else 
   systemctl suspend
fi
