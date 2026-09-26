#!/bin/bash

STATUS_FILE="/tmp/hypridle_status"

get_status() {
    if pgrep -x hypridle >/dev/null; then
        echo "on"
    else
        echo "off"
    fi
}

if [[ $1 == "toggle" ]]; then
    if pgrep -x hypridle >/dev/null; then
        pkill hypridle
        echo "off" > "$STATUS_FILE"
    else
        hypridle &
        echo "on" > "$STATUS_FILE"
    fi
    exit 0
fi

STATUS=$(get_status)

if [[ $STATUS == "on" ]]; then
    ICON="󰈈"   # same as idle inhibitor active
else
    ICON="󰈉"   # same as idle inhibitor inactive
fi

echo "{\"text\":\"$ICON\",\"tooltip\":\"Hypridle: $STATUS\"}"

