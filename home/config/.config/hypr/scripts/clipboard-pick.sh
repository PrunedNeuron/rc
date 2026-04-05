#!/usr/bin/env bash
# ~/.config/hypr/scripts/clipboard-pick.sh
set -euo pipefail

if ! command -v clipvault >/dev/null 2>&1; then
  notify-send "Clipboard" "clipvault is not installed."
  exit 1
fi

# Use clipvault list + wofi in dmenu mode.
# pre-display-cmd shows only the content column, but wofi still
# returns the original line so clipvault get can resolve it.
clipvault list \
  | wofi -S dmenu -d -k /dev/null \
      --prompt "Clipboard" \
      --pre-display-cmd "echo '%s' | cut -f 2" \
  | clipvault get \
  | wl-copy
