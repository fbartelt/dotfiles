EWW_BIN="${HOME}/eww/target/release/eww"
LOCK_FILE="/tmp/eww_launch.lock"
TRAY_LAUNCH="${HOME}/.config/eww/scripts/launchtray.sh"

run() {
    env XDG_CACHE_HOME=/tmp ${EWW_BIN} open bar
}

if [[ ! `pidof eww` ]]; then
  ${EWW_BIN} daemon
	sleep 1
fi

# Launch bar
if [[ ! -f "$LOCK_FILE" ]]; then
  touch "$LOCK_FILE"
  run
  ${TRAY_LAUNCH}
else
  ${EWW_BIN} close bar
  rm "$LOCK_FILE"
  killall stalonetray
fi