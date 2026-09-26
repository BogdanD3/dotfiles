#!/bin/bash
#  _   _                      _               _
# | | | |_   _ _ __  _ __ ___| |__   __ _  __| | ___
# | |_| | | | | '_ \| '__/ __| '_ \ / _` |/ _` |/ _ \
# |  _  | |_| | |_) | |  \__ \ | | | (_| | (_| |  __/
# |_| |_|\__, | .__/|_|  |___/_| |_|\__,_|\__,_|\___|
#        |___/|_|
#
#!/bin/bash

# Path to store last chosen filter
SETTINGS="$HOME/.config/ml4w/settings/hyprshade.sh"

# List filters + off
options="$(hyprshade ls | sed 's/^[ *]*//')"
options="$options"$'\n'"off"

# Open basic Rofi menu (default theme)
choice=$(echo -e "$options" | rofi -dmenu -i -p "Hyprshade")

if [ -n "$choice" ]; then
    echo "hyprshade_filter=\"$choice\"" > "$SETTINGS"
    current=$(hyprshade current)

    if [ "$choice" == "off" ] || [ "$choice" == "$current" ]; then
        hyprshade off
        notify-send "Hyprshade turned off"
    else
        hyprshade on "$choice"
        notify-send "Hyprshade activated" "Filter: $choice"
    fi
fi

