#!/bin/bash
CHARS=(" " "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█")

pkill -f "cava -p.*cava-waybar.conf" 2>/dev/null
trap 'kill 0' TERM INT HUP EXIT

cava -p "$HOME/.config/waybar/scripts/cava-waybar.conf" | while read -r line; do
    out=""
    IFS=';' read -ra vals <<< "$line"
    for v in "${vals[@]}"; do
        [[ -z "$v" || ! "$v" =~ ^[0-9]+$ ]] && continue
        out+="${CHARS[$v]}"
    done
    echo "$out"
done
