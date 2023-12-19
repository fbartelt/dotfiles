LOCK_FILE="${HOME}/.cache/stalone_launch.lock"

run() {
    stalonetray --icon-gravity W --grow-gravity NE --icon-size 10 --slot-size 22 --geometry 1x1+955+2 --no-shrink false --window-type toolbar &
}

if [[ ! `pidof eww` ]]; then
  ${EWW_BIN} daemon
	sleep 1
fi

# Launch bar
if [[ ! -f "$LOCK_FILE" ]]; then
  touch "$LOCK_FILE"
  run
else
  rm "$LOCK_FILE"
  killall stalonetray
  run
fi