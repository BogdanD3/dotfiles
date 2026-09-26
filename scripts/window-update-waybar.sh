#!/usr/bin/env bash

# Count workspaces with at least 1 window
count=$(hyprctl -j workspaces | jq '[.[] | select(.windows | length > 0)] | length')

# Output JSON for Waybar
echo "{\"text\": \"[$count]\"}"
