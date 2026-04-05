#!/usr/bin/env bash
# ~/.config/hypr/scripts/start-nm-applet.sh
# Reliable nm-applet startup with tray wait

set -euo pipefail

# Ensure DBus environment
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP >/dev/null 2>&1 || true

# Wait for system tray
sleep 3
for i in {1..10}; do
    if pgrep -x "hyprpanel|waybar|eww" >/dev/null 2>&1; then
        break
    fi
    sleep 1
done

# Start nm-applet
nm-applet --indicator >>~/.cache/nm-applet.log 2>&1 &
