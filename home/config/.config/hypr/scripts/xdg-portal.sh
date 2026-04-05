#!/usr/bin/env bash
# ~/.config/hypr/scripts/xdg-portal.sh
# Configure XDG Desktop Portal for Hyprland

set -euo pipefail

sleep 1
killall -e xdg-desktop-portal-hyprland || true
killall -e xdg-desktop-portal-gtk || true
killall xdg-desktop-portal || true

sleep 1
/usr/lib/xdg-desktop-portal-hyprland &
sleep 2
/usr/lib/xdg-desktop-portal &
