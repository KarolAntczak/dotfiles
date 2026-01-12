#!/bin/bash
# Generates list of installed Pacman + AUR packages

OUTPUT_FILE="pkglist.txt"

echo "Generating Pacman + AUR packages..."

pacman -Qqe > "$OUTPUT_FILE"

echo "Done. Now you can use yay -S --needed - < $OUTPUT_FILE"

