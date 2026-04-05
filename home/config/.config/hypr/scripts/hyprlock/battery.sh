#!/usr/bin/env bash
set -euo pipefail

readonly BATTERY_PATH="/sys/class/power_supply/BAT0"

main() {
    [[ -d "$BATTERY_PATH" ]] || { echo ""; exit 0; }

    local capacity status icon
    capacity=$(cat "$BATTERY_PATH/capacity" 2>/dev/null || echo "0")
    status=$(cat "$BATTERY_PATH/status" 2>/dev/null || echo "Unknown")

    if [[ "$status" == "Charging" || "$status" == "Full" ]]; then
        icon="󰂄"
    elif (( capacity >= 90 )); then
        icon="󰁹"
    elif (( capacity >= 80 )); then
        icon="󰂂"
    elif (( capacity >= 70 )); then
        icon="󰂁"
    elif (( capacity >= 60 )); then
        icon="󰂀"
    elif (( capacity >= 50 )); then
        icon="󰁿"
    elif (( capacity >= 40 )); then
        icon="󰁾"
    elif (( capacity >= 30 )); then
        icon="󰁽"
    elif (( capacity >= 20 )); then
        icon="󰁼"
    elif (( capacity >= 10 )); then
        icon="󰁻"
    else
        icon="󰁺"
    fi

    echo "$icon ${capacity}%"
}

main
