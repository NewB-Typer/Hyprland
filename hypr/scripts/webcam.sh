#!/bin/bash

WEBCAM_MODULE="uvcvideo"
ICON_ENABLE="$HOME/.config/dunst/icons/cam_on.png"
ICON_DISABLE="$HOME/.config/dunst/icons/cam_off.png"
NOTIFY_ID=2593

if lsmod | grep -q "^${WEBCAM_MODULE}"; then
    # Webcam is enabled
    notify-send -i "$ICON_ENABLE" -h string:x-canonical-private-synchronous:webcam -t 1500 "Webcam enabled"
else
    # Webcam is disabled
    notify-send -i "$ICON_DISABLE" -h string:x-canonical-private-synchronous:webcam -t 1500 "Webcam disabled"
fi
