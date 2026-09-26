#!/bin/bash

export DISPLAY=:0
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"


# Notification thresholds
notify_levels=(3 5 10 20)

# Detect battery
BAT=$(ls /sys/class/power_supply | grep BAT | head -n 1)

# File to store last notified level
STATE_FILE="$HOME/.cache/battery_last_notify"

# Create state file if it doesn't exist
[ ! -f "$STATE_FILE" ] && echo 100 > "$STATE_FILE"

last_notify=$(cat "$STATE_FILE")

# Get current battery level
bat_lvl=$(cat /sys/class/power_supply/${BAT}/capacity)

# Reset state if battery is charging or above highest threshold
status=$(cat /sys/class/power_supply/${BAT}/status)

# Send notification if battery reaches a new threshold
for level in "${notify_levels[@]}"; do
    if (( bat_lvl == level && level < last_notify )) && [[ "$status" != "Charging" ]]; then
        notify-send -u critical "Low Battery" "$bat_lvl% battery remaining."
        echo "$level" > "$STATE_FILE"
        break
    fi
done

if [[ "$status" == "Charging" ]] || (( bat_lvl > notify_levels[0] )); then
    echo 100 > "$STATE_FILE"
fi

