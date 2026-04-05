#!/usr/bin/env bash
# ~/.config/hypr/scripts/record-region.sh
# Record screen region using wf-recorder

set -euo pipefail

OUTPUT_DIR="$HOME/Videos/recordings"
mkdir -p "$OUTPUT_DIR"

FILENAME="$OUTPUT_DIR/recording-$(date +%Y%m%d-%H%M%S).mp4"

if pgrep -x wf-recorder >/dev/null; then
    pkill -INT wf-recorder
    notify-send "Recording stopped" "Saved to: $FILENAME"
else
    GEOMETRY=$(slurp)
    if [ -n "$GEOMETRY" ]; then
        wf-recorder -g "$GEOMETRY" -f "$FILENAME" &
        notify-send "Recording started" "Region: $GEOMETRY"
    fi
fi
