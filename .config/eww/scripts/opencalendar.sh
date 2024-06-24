#!/bin/bash

## Created   by https://github.com/rxyhn

LOCK_FILE="/tmp/eww-calendar.lock"
EWW_BIN="${HOME}/eww/target/release/eww"

run() {
    ${EWW_BIN} open calendar
}

# Run eww daemon if not running
if [[ ! `pidof eww` ]]; then
  ${EWW} daemon
	sleep 1
fi


# Open widgets
if [[ ! -f "$LOCK_FILE" ]]; then
  touch "$LOCK_FILE"
  run
else
  ${EWW_BIN} close calendar
  rm "$LOCK_FILE"
fi