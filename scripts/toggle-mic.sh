#!/bin/bash

# Toggle mic mute
wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

# Get current state
STATE=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -o "\[MUTED\]")

# Notify user
if [ "$STATE" = "[MUTED]" ]; then
    dunstify " Mic muted"
else
    dunstify " Mic unmuted"
fi

