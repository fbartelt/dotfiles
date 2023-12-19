EWW_BIN="${HOME}/eww/target/release/eww"
LOCK_FILE="${HOME}/.cache/eww_launch.lock"
TRAY_LAUNCH="${HOME}/.config/eww/scripts/launchtray.sh"

run() {
    ${EWW_BIN} open bar
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