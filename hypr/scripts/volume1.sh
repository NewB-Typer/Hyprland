#!/bin/bash
LOGFILE="$HOME/.config/hypr/scripts/volume.log"

{
  echo "=== Volume script called with argument: $1 ==="
  export XDG_RUNTIME_DIR=/run/user/1000
  export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
  echo "XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR"
  echo "DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS"

  ICON_MUTE="$HOME/.config/mako/icons/mute.png"
  ICON_VOL="$HOME/.config/mako/icons/medium_volume.png"

  PCTL="/usr/bin/pactl"
  NOTIFY="/usr/bin/notify-send"

  case "$1" in
      mute)
          echo "Running: pactl set-sink-mute toggle"
          $PCTL set-sink-mute @DEFAULT_SINK@ toggle
          ;;
      up)
          echo "Running: pactl set-sink-volume +5%"
          $PCTL set-sink-volume @DEFAULT_SINK@ +5%
          ;;
      down)
          echo "Running: pactl set-sink-volume -5%"
          $PCTL set-sink-volume @DEFAULT_SINK@ -5%
          ;;
      *)
          echo "Usage error: $0 {mute|up|down}"
          exit 1
          ;;
  esac

  volume=$($PCTL get-sink-volume @DEFAULT_SINK@ | head -n 1 | grep -oP '\d+%' | head -1 | tr -d '%')
  mute=$($PCTL get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

  echo "Volume: $volume, Mute: $mute"

  if [ "$mute" = "yes" ]; then
      echo "Sending mute notification"
      $NOTIFY -h string:x-canonical-private-synchronous:volume -t 2000 -i "$ICON_MUTE" "Volume muted"
  else
      echo "Sending volume notification: $volume%"
      $NOTIFY -h string:x-canonical-private-synchronous:volume -t 2000 -i "$ICON_VOL" "Volume: $volume%"
  fi
} >> "$LOGFILE" 2>&1
