#!/bin/bash
## Created   by https://github.com/rxyhn

LOCK_FILE="/tmp/eww-calendar.lock"

ACTIVE_SCREEN=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true) | .output')

run() {
    eww open calendar --screen "$ACTIVE_SCREEN"
}

# Run eww daemon if not running
if [[ ! `pidof eww` ]]; then
  eww daemon
	sleep 1
fi


# Open widgets
if [[ ! -f "$LOCK_FILE" ]]; then
  touch "$LOCK_FILE"
  run
else
  eww close calendar
  rm "$LOCK_FILE"
fi
