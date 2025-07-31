#!/bin/bash

# Paths to icons
ICON_PLAY="$HOME/.config/mako/icons/play.png"
ICON_PAUSE="$HOME/.config/mako/icons/pause.png"
ICON_NEXT="$HOME/.config/mako/icons/next.png"
ICON_PREV="$HOME/.config/mako/icons/previous.png"

# Function to send a notification
notify() {
    local icon="$1"
    local message="$2"
    notify-send -h string:x-canonical-private-synchronous:media \
                -i "$icon" -t 1500 "$message"
}

case "$1" in
    play-pause)
        status=$(playerctl status 2>/dev/null)
        if [[ "$status" == "Playing" ]]; then
            playerctl pause
            notify "$ICON_PAUSE" "Paused"
        else
            playerctl play
            notify "$ICON_PLAY" "Playing"
        fi
        ;;
    next)
        playerctl next
        notify "$ICON_NEXT" "Next Track"
        ;;
    previous)
        playerctl previous
        notify "$ICON_PREV" "Previous Track"
        ;;
    *)
        echo "Usage: $0 {play-pause|next|previous}"
        exit 1
        ;;
esac
