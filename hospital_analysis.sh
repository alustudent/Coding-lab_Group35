#!/usr/bin/env bash
# KNH live data analysis on active_logs before archiving.
# Owners: Bethelhem, Bellamy

# Bethelhem: extract CRITICAL heart rate and temperature rows into reports/critical_alerts.txt
process_vitals() {
    :
}

# Bellamy: average water usage for ICU_WATER_RESERVE
water_audit() {
    local water_log="active_logs/water_usage_log.log"
    local device="ICU_WATER_RESERVE"
    local readings average high_usage

    if [ ! -f "$water_log" ]; then
        echo "Error: $water_log not found." >&2
        return 1
    fi

    # Single pass: reading count, average usage and HIGH_USAGE count for the device
    read -r readings average high_usage < <(
        awk -F ' \\| ' -v device="$device" '
            $2 == device {
                total += $3
                count++
                if ($4 == "HIGH_USAGE") high++
            }
            END { printf "%d %.2f %d\n", count, (count ? total / count : 0), high }
        ' "$water_log"
    )

    if [ "$readings" -eq 0 ]; then
        echo "No $device readings found in $water_log." >&2
        return 1
    fi

    printf '\nWater Audit: %s\n' "$device"
    printf '%-22s %d\n' "Readings:" "$readings"
    printf '%-22s %.2f L/min\n' "Average usage:" "$average"
    printf '%-22s %d\n' "High usage readings:" "$high_usage"
}

# Bellamy: execution logic
# Run from the script's directory so relative log paths resolve from anywhere
cd "$(dirname "$0")" || exit 1

process_vitals
water_audit
