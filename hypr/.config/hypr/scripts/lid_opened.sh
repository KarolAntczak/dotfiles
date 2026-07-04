hyprctl keyword monitor "eDP-1,1920x1200@59.95Hz,auto,1"
brightnessctl set 90%
sleep 0.3
systemctl --user restart dunst
dunstify "Lid opened" 
