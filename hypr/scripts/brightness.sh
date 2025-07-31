#!/bin/bash

ICON_PATH="$HOME/.config/mako/icons/brightness.png"

if [ "$1" = "increase" ]; then
  brightnessctl set +5%
elif [ "$1" = "decrease" ]; then
  brightnessctl set 5%-
else
  echo "Usage: $0 {increase|decrease}"
  exit 1
fi

CURRENT_BRIGHTNESS=$(brightnessctl | grep -oP '\(\K[0-9]+(?=%\))')

# Replace previous brightness notification (same behavior as -r in dunstify)
notify-send -h string:x-canonical-private-synchronous:brightness \
  -t 1500 -i "$ICON_PATH" "Brightness $CURRENT_BRIGHTNESS%" &
