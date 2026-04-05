#!/usr/bin/env bash
set -euo pipefail

get_cpu_usage() {
    grep '^cpu ' /proc/stat | awk '{
        user=$2; nice=$3; system=$4; idle=$5;
        iowait=$6; irq=$7; softirq=$8; steal=$9;
        total = user + nice + system + idle + iowait + irq + softirq + steal;
        work = user + nice + system + irq + softirq + steal;
        print work, total
    }'
}

main() {
    read -r work1 total1 <<< "$(get_cpu_usage)"
    sleep 0.1
    read -r work2 total2 <<< "$(get_cpu_usage)"

    local work_delta=$((work2 - work1))
    local total_delta=$((total2 - total1))

    if (( total_delta > 0 )); then
        local usage=$(( (work_delta * 100) / total_delta ))
        echo "󰘚 ${usage}%"
    else
        echo "󰘚 0%"
    fi
}

main
