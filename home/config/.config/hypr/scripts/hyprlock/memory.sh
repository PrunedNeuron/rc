#!/usr/bin/env bash
set -euo pipefail

main() {
    local mem_total mem_available mem_used

    mem_total=$(awk '/MemTotal:/ {print $2}' /proc/meminfo)
    mem_available=$(awk '/MemAvailable:/ {print $2}' /proc/meminfo)
    mem_used=$(( (mem_total - mem_available) / 1024 ))

    if (( mem_used >= 1024 )); then
        printf "󰍛 %.1fG\n" "$(awk "BEGIN {print $mem_used/1024}")"
    else
        echo "󰍛 ${mem_used}M"
    fi
}

main
