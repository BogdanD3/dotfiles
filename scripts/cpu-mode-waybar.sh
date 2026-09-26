#!/bin/bash

# Get the real active governor from the kernel
current=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)

# Menu options
options=("powersave" "performance")

# Build menu with [current] highlighted
menu=""
for opt in "${options[@]}"; do
    if [[ "$opt" == "$current" ]]; then
        menu+="[current] $opt\n"
    else
        menu+="$opt\n"
    fi
done

# Show the menu in rofi
chosen=$(echo -e "$menu" | rofi -dmenu -p "CPU Governor:")
chosen=$(echo "$chosen" | sed 's/\[current\] //')

# Apply selected governor using auto-cpufreq
if [ -n "$chosen" ] && [ "$chosen" != "$current" ]; then
    sudo auto-cpufreq --force "$chosen"
    notify-send "CPU Governor" "Set to $chosen"
fi
