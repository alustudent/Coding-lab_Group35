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
    awk -F ' *[|] *' '
        FNR == 1 { section_printed = 0 }
        $4 == "CRITICAL" {
            if (!section_printed) {
                if (FILENAME == ARGV[1]) print "Heart rate critical alerts:"
                else print "Temperature critical alerts:"
                section_printed = 1
            }
            print
            total++
        }
        END {
            if (total == 0) print "No critical heart rate or temperature readings found."
        }
    ' "$heart_log" "$temp_log" > "$report_file" || return 1

    printf 'Critical vital alerts written to %s\n' "$report_file"
}

# Alemayehu: average water usage for ICU_WATER_RESERVE
water_audit() {
    :
}
