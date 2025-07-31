#!/bin/bash

# Toggle microphone mute state
pactl set-source-mute @DEFAULT_SOURCE@ toggle > /dev/null

# Check if mic is muted
mute_status=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')

if [ "$mute_status" = "yes" ]; then
    ICON="$HOME/.config/mako/icons/mic_mute.png"
    MESSAGE="Microphone muted"
else
    ICON="$HOME/.config/mako/icons/mic_unmute.png"
    MESSAGE="Microphone unmuted"
fi

# Show notification, replace previous ones with same tag
notify-send -h string:x-canonical-private-synchronous:mic -i "$ICON" -r 2593 -t 1500 "$MESSAGE"
