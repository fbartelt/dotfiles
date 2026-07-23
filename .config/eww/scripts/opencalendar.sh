#!/bin/bash
## Created   by https://github.com/rxyhn

LOCK_FILE="/tmp/eww-calendar.lock"

run() {
    eww open calendar
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
