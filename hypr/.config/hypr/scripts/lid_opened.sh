#!/bin/bash
hyprctl keyword monitor "eDP-1,1920x1200@59.95Hz,0x0,1"
brightnessctl set 90%
sleep 0.5; killall waybar; waybar &
