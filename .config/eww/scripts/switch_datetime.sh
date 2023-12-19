#!/bin/bash
PATH="$PATH:/home/fbartelt/eww/target/release"

shotime=$(eww state | grep showtime | sed -E "s/.*(true|false)/\1/g")
echo "1 ${showtime}"
[[ ${shotime} = "true" ]] && showtime="false" || showtime="true"
echo "2 ${showtime}"

eww -c ~/.config/eww update showtime="${showtime}"