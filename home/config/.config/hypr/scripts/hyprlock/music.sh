#!/usr/bin/env bash
set -euo pipefail

readonly MAX_TITLE_LEN=40
readonly MAX_ARTIST_LEN=30

main() {
    command -v playerctl &>/dev/null || { echo ""; exit 0; }

    local status
    status=$(playerctl status 2>/dev/null || echo "Stopped")

    [[ "$status" == "Playing" ]] || { echo ""; exit 0; }

    local title artist
    title=$(playerctl metadata title 2>/dev/null | cut -c1-"$MAX_TITLE_LEN" || echo "")
    artist=$(playerctl metadata artist 2>/dev/null | cut -c1-"$MAX_ARTIST_LEN" || echo "")

    if [[ -n "$title" ]]; then
        if [[ -n "$artist" ]]; then
            echo "󰝚  $title  •  $artist"
        else
            echo "󰝚  $title"
        fi
    else
        echo ""
    fi
}

main
