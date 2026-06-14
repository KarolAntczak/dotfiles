dunstify "Lid closed" 

if [ "$(hyprctl monitors | grep -c '^Monitor')" -gt 1 ]; then
    hyprctl dispatch dpms off eDP-1
fi
