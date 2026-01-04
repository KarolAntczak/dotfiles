#!/usr/bin/env bash

#!/usr/bin/env bash
set -euo pipefail

MENU=$(
  printf "%s\n" \
    "⏻ Logout" \
    "⏻ Reboot" \
    "⏻ Shutdown" \
  | rofi -dmenu -p "Menu"
)

case "${MENU}" in
  "⏻ Logout")  hyprctl dispatch exit ;;
  "⏻ Reboot")  systemctl reboot ;;
  "⏻ Shutdown") systemctl poweroff ;;
  *) exit 0 ;;
esac

