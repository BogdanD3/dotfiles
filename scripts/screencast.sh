#!/usr/bin/env bash

OUTPUT="$HOME/Videos/Screen-recordings/recording-$(date +'%Y-%m-%d_%H-%M-%S').mp4"
PIDFILE="/tmp/wf-recorder.pid"
INDICATOR="/tmp/recording-indicator"

if [ -f "$PIDFILE" ]; then
    # Already recording → stop
    kill "$(cat "$PIDFILE")"
    rm -f "$PIDFILE"
    pkill -f "yad --notification --image=media-record"
    notify-send "🎥 Screen Recording" "Stopped"
else
    # Start recording
    wf-recorder -f "$OUTPUT" & echo $! > "$PIDFILE"

    # Show indicator in system tray (won’t appear in video)
    yad --notification \
        --image=media-record \
        --text "Recording..." \
        --no-middle \
        --command="bash $0" &

    notify-send "🎥 Screen Recording" "Started → $OUTPUT"
fi

