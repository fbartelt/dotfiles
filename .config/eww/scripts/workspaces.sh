#!/usr/bin/env bash
PATH="$PATH:/home/fbartelt/eww/target/release"

gib_workspace_names() {
 # wmctrl -d | awk '{ print $1 " " $2 " " $9 }'
 i3-msg -t get_workspaces | tr '}' '\n' | sed -nr 's/.*?"name":"([^"]+)".*"focused":([^",]+).*/\1 \2/p' | tr ':' ' '
}

gib_workspace_yuck() {
  buffered=""
  gib_workspace_names $1 | while read -r id name active; do
    # name="${name#*_}"
    i3name="${id}:${name}"
    if [[ "${active}" = "true" ]]; then
      active_class="active"
    else
      active_class="inactive"
    fi

    button_class="occupied"
    # if wmctrl -l | grep --regexp '.*\s\+'"$id"'\s\+.*' >/dev/null; then
    #   button_class="occupied"
    #   button_name="◆"
    # else
    #   button_class="empty"
    #   button_name="◇"
    # fi
    buffered+="(button :class \"$button_class $active_class\"  :onclick \"i3-msg workspace ${i3name}\" \"${name}\")"
    if [ $button_class = "occupied" -o $active_class = "active" ]; then
      echo -n "$buffered"
      buffered=""
    fi
  done
}

box_attrs=':orientation "h" :class "workspaces" :space-evenly false :halign "start" :valign "center" :vexpand false '
echo "$(gib_workspace_yuck 1)"
# eww -c ~/.config/eww update workspaces_1_yuck="(box $box_attrs $(gib_workspace_yuck))"

#xprop -spy -notype -root _NET_CURRENT_DESKTOP | while read -r; do
# Workspace icons must appear iff there's something open on that workspace, but if I switch to an empty workspace I want
# to see its icon shown
#   _NET_DESKTOP_VIEWPORT enables checking the switching of "non-existing" workspaces
#   _NET_CURRENT_DESKTOP checks switching between existing workspaces
#   -notype was added to support 10 workspaces (numbers are in [0 5] and this enables duplicates)
xprop -spy -notype -root _NET_DESKTOP_VIEWPORT _NET_CURRENT_DESKTOP | while read -r; do
  eww -c ~/.config/eww update workspaces_1_yuck="(box $box_attrs $(gib_workspace_yuck))"
done