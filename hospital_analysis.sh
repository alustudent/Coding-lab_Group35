#!/usr/bin/env bash
# KNH live data analysis on active_logs before archiving.
# Owners: Bethelhem, Alemayehu

# Bethelhem: extract CRITICAL heart rate and temperature rows into reports/critical_alerts.txt
process_vitals() {
    local heart_log="active_logs/heart_rate_log.log"
    local temp_log="active_logs/temperature_log.log"
    local report_dir="reports"
    local report_file="${report_dir}/critical_alerts.txt"

    if [[ ! -f "$heart_log" || ! -f "$temp_log" ]]; then
        printf 'Heart rate and temperature logs must both exist in active_logs/.\n' >&2
        return 1
    fi

    mkdir -p "$report_dir" || return 1

    # grep finds CRITICAL rows (Status is the last column), awk keeps Timestamp, Device_ID and Value
    {
        printf 'Timestamp | Device_ID | Value\n'
        grep -h '| CRITICAL$' "$heart_log" "$temp_log" |
            awk -F ' \\| ' '{ printf "%s | %s | %s\n", $1, $2, $3 }'
    } > "$report_file" || return 1

    printf '%d critical alerts written to %s\n' "$(($(wc -l < "$report_file") - 1))" "$report_file"
}

# Alemayehu: average water usage for ICU_WATER_RESERVE
water_audit() {
    :
}
