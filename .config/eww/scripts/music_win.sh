#!/bin/bash
LOCK_FILE="/tmp/eww-music.lock"
EWW_BIN="${HOME}/eww/target/release/eww"
LOG_FILE="/tmp/eww-music-debug.log"

run() {
    echo "$(date): Opening music_win" >> "$LOG_FILE"
    # Force an update before opening to ensure fresh data
    # ~/.config/eww/scripts/music_get.sh 2>> "$LOG_FILE"
    sleep 0.1
    ${EWW_BIN} open music_win 2>> "$LOG_FILE"
    echo "$(date): music_win opened" >> "$LOG_FILE"
}

# Open/close widgets
if [[ ! -f "$LOCK_FILE" ]]; then
    echo "$(date): Creating lock file" >> "$LOG_FILE"
    touch "$LOCK_FILE"
    run
else
    echo "$(date): Removing lock file" >> "$LOG_FILE"
    ${EWW_BIN} close music_win 2>> "$LOG_FILE"
    rm "$LOCK_FILE"
fi
