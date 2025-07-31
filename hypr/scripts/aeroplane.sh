#!/bin/bash

ICON="$HOME/.config/mako/icons/aeroplane.png"

# Check current airplane mode status
airplane_mode="no"

while read -r line; do
    if echo "$line" | grep -q "Wireless LAN"; then
        read -r next_line
        if echo "$next_line" | grep -q "Soft blocked: yes"; then
            airplane_mode="yes"
            break
        fi
    fi
done < <(rfkill list all)

# Toggle airplane mode
if [[ "$airplane_mode" == "yes" ]]; then
    rfkill unblock all
    MESSAGE="Airplane Mode Disabled"
else
    rfkill block all
    MESSAGE="Airplane Mode Enabled"
fi

# Send notification with Mako
notify-send -i "$ICON" -r 2593 -t 2000 "$MESSAGE"
