#!/bin/bash
export XDG_RUNTIME_DIR=/run/user/1000
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus


# Try to auto-inherit the correct DBUS_SESSION_BUS_ADDRESS from mako if it's missing
#if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
##    pid=$(pgrep -u "$USER" mako | head -n 1)
##    if [ -n "$pid" ]; then
##        export DBUS_SESSION_BUS_ADDRESS=$(tr '\0' '\n' < /proc/$pid/environ | grep ^DBUS_SESSION_BUS_ADDRESS= | cut -d= -f2-)
##    fi
## fi


ICON_MUTE="$HOME/.config/mako/icons/mute.png"
ICON_VOL="$HOME/.config/mako/icons/medium_volume.png"

PCTL="/usr/bin/pactl"
NOTIFY="/usr/bin/notify-send"

case "$1" in
    mute)
        $PCTL set-sink-mute @DEFAULT_SINK@ toggle
        ;;
    up)
        $PCTL set-sink-volume @DEFAULT_SINK@ +5%
        ;;
    down)
        $PCTL set-sink-volume @DEFAULT_SINK@ -5%
        ;;
    *)
        echo "Usage: $0 {mute|up|down}"
        exit 1
        ;;
esac

volume=$($PCTL get-sink-volume @DEFAULT_SINK@ | head -n 1 | grep -oP '\d+%' | head -1 | tr -d '%')
mute=$($PCTL get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

if [ "$mute" = "yes" ]; then
    $NOTIFY -h string:x-canonical-private-synchronous:volume -t 2000 -i "$ICON_MUTE" "Volume muted"
else
    $NOTIFY -h string:x-canonical-private-synchronous:volume -t 2000 -i "$ICON_VOL" "Volume: $volume%"
fi
