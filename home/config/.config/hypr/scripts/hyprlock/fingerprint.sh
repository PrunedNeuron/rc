#!/usr/bin/env bash
set -euo pipefail

main() {
    if systemctl --user is-active --quiet fprintd.service 2>/dev/null; then
        if pgrep -x hyprlock &>/dev/null; then
            echo "󰟃  Touch to unlock"
            exit 0
        fi
    fi
    echo ""
}

main
