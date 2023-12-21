#!/bin/bash

## Created By Aditya Shakya

MENU="$(rofi -sep "|" -dmenu -i -p 'System' -hide-scrollbar -lines 4 -font "M PLUS 2 Regular 12" <<< "Lock|Logout|Reboot|Shutdown")"
            case "$MENU" in
                *Lock) i3lock -B 1 ;;
                *Logout) i3-msg exit;;
                *Reboot) systemctl reboot ;;
                *Shutdown) systemctl -i poweroff
            esac