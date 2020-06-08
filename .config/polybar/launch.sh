#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch polybar
for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload main &
done

#for monitor in $(xrandr | grep connected | awk '{print $1}'); do
#	POLYMONITOR=$monitor polybar main -c /home/$USER/.config/polybar/config &
#done
