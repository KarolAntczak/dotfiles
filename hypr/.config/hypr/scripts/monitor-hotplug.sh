#!/bin/bash
lid_closed() {
    grep -q "closed" /proc/acpi/button/lid/LID*/state 2>/dev/null
}

handle() {
    local event="${1%%>>*}"
    local mon="${1#*>>}"
    case "$event" in
        monitoradded)
            [[ "$mon" == "eDP-1" ]] && return
            lid_closed && hyprctl keyword monitor "eDP-1, disable"
            sleep 0.5; killall waybar; waybar &
            ;;
        monitorremoved)
            [[ "$mon" == "eDP-1" ]] && return
            if lid_closed; then
                systemctl suspend
            else
                sleep 0.5; killall waybar; waybar &
            fi
            ;;
    esac
}

socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" \
    | while read -r line; do handle "$line"; done
