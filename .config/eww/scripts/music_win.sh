#!/bin/bash

LOCK_FILE="/tmp/eww-music.lock"
EWW_BIN="${HOME}/eww/target/release/eww"

run() {
    ${EWW_BIN} open music_win
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
  ${EWW_BIN} close music_win
  rm "$LOCK_FILE"
fi