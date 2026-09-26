#!/bin/bash
BAT=$(cat /sys/class/power_supply/BAT1/capacity)
STATUS=$(cat /sys/class/power_supply/BAT1/status)

if [ "$STATUS" = "Charging" ]; then
  echo "󰂄 $BAT%"
else
  echo "󰁹 $BAT%"
fi
