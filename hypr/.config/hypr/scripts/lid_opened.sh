#!/bin/bash
hyprctl eval "hl.monitor({output = 'eDP-1', disabled = false, mode = '1920x1200@59.95', position = '0x0', scale = 1.0})"
brightnessctl set 90%
sleep 0.5; killall waybar; waybar &
