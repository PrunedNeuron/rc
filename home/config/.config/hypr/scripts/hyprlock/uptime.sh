#!/usr/bin/env bash
set -euo pipefail

main() {
    local uptime_formatted
    uptime_formatted=$(uptime -p | sed 's/up //' | sed 's/ hours\?/h/' | sed 's/ minutes\?/m/' | sed 's/ days\?/d/')
    echo "󰔛 $uptime_formatted"
}

main
