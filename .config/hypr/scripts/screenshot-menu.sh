#!/bin/bash

# First menu: choose mode
mode=$(printf "Fullscreen\nRegion\nWindow" | rofi -dmenu -p "Mode")

# Second menu: choose action
action=$(printf "Save to File\nCopy to Clipboard" | rofi -dmenu -p "Action")

case "$mode:$action" in
  "Fullscreen:Save to File")
    hyprshot -m output
    notify-send "Screenshot" "Fullscreen saved"
    ;;
  "Fullscreen:Copy to Clipboard")
    grim -g "$(hyprshot -m output -p)" - | wl-copy
    notify-send "Screenshot" "Fullscreen copied to clipboard"
    ;;
  "Region:Save to File")
    hyprshot -m region
    notify-send "Screenshot" "Region saved"
    ;;
  "Region:Copy to Clipboard")
    grim -g "$(slurp)" - | wl-copy
    notify-send "Screenshot" "Region copied to clipboard"
    ;;
  "Window:Save to File")
    hyprshot -m window
    notify-send "Screenshot" "Window saved"
    ;;
  "Window:Copy to Clipboard")
    grim -g "$(slurp -f)" - | wl-copy
    notify-send "Screenshot" "Window copied to clipboard"
    ;;
esac

