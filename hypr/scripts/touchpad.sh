#!/bin/bash

ICON="$HOME/.config/mako/icons/touchpad.png"

# Hardcoded device name based on your earlier output
DEVICE="Synaptics TM3336-002"

if libinput list-devices | grep -A20 "$DEVICE" | grep -q "Tap-to-click:\s\+disabled"; then
    notify-send -h string:x-canonical-private-synchronous:touchpad \
        -t 2000 -i "$ICON" "Touchpad disabled"
else
    notify-send -h string:x-canonical-private-synchronous:touchpad \
        -t 2000 -i "$ICON" "Touchpad enabled"
fi
