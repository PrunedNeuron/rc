#!/usr/bin/env bash
set -euo pipefail

readonly CACHE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/hyprlock_weather"
readonly CACHE_DURATION=1800
readonly CURL_TIMEOUT=3

get_weather_icon() {
    local condition="$1"
    case "$condition" in
        *clear*|*sunny*) echo "󰖙" ;;
        *partly*|*cloud*) echo "󰖐" ;;
        *overcast*) echo "󰖐" ;;
        *rain*|*drizzle*|*shower*) echo "󰖗" ;;
        *thunder*|*storm*) echo "󰙾" ;;
        *snow*|*sleet*) echo "󰼶" ;;
        *fog*|*mist*|*haze*) echo "󰖑" ;;
        *) echo "󰖐" ;;
    esac
}

fetch_weather() {
    local response condition temp icon

    response=$(curl -sf --max-time "$CURL_TIMEOUT" \
        --connect-timeout 2 \
        "https://wttr.in/?format=%C+%t" 2>/dev/null || echo "")

    [[ -z "$response" || "$response" == "Unknown"* ]] && return 1
    [[ ${#response} -gt 100 ]] && return 1

    condition=$(echo "$response" | sed 's/[+0-9°CF-]//g' | xargs | tr '[:upper:]' '[:lower:]')
    temp=$(echo "$response" | grep -oE '[+-]?[0-9]+°[CF]' | head -n1)

    [[ -z "$temp" ]] && return 1

    icon=$(get_weather_icon "$condition")
    echo "$icon  $temp"
    return 0
}

main() {
    # Check cache validity
    if [[ -f "$CACHE_FILE" ]]; then
        local cache_age=$(( $(date +%s) - $(stat -c %Y "$CACHE_FILE" 2>/dev/null || echo 0) ))
        if (( cache_age < CACHE_DURATION )); then
            cat "$CACHE_FILE"
            exit 0
        fi
    fi

    # Fetch new data
    local weather
    if weather=$(fetch_weather); then
        echo "$weather" | tee "$CACHE_FILE"
    else
        # Return cached data or empty string
        [[ -f "$CACHE_FILE" ]] && cat "$CACHE_FILE" || echo ""
    fi
}

main
