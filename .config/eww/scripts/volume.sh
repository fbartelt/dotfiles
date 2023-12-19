#!/usr/bin/env bash

if [ "$1" = "up" ]; then
  pamixer -i 5
else
  pamixer -d 5
fi