#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch polybar
tray_output="eDP-1|eDP1"

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    tray_pos=""
    if [[ ${m} == ${tray_ouput} ]]; then
      tray_pos="center"
    fi
    MONITOR=$m TRAY_POSITION=${tray_pos} polybar --reload main &
  done
else
  polybar --reload main &
fi

#for monitor in $(xrandr | grep connected | awk '{print $1}'); do
#	POLYMONITOR=$monitor polybar main -c /home/$USER/.config/polybar/config &
#done
