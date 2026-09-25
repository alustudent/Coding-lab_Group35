#!/usr/bin/env bash
# KNH live data analysis on active_logs before archiving.
# Owners: Bethelhem, Alemayehu

# Bethelhem: extract CRITICAL heart rate and temperature rows into reports/critical_alerts.txt
process_vitals() {
    :
}

# Alemayehu: average water usage for ICU_WATER_RESERVE
water_audit() {
    local log_file="active_logs/water_usage_log.log"
    local report_dir="reports"
    local report_file="${report_dir}/water_audit.txt"
    local summary

    if [[ ! -f "$log_file" ]]; then
        printf 'Water usage log not found: %s\n' "$log_file" >&2
        return 1
    fi

    summary=$(awk -F ' *\\| *' '
        $2 == "ICU_WATER_RESERVE" && $3 ~ /^[0-9]+([.][0-9]+)?$/ {
            total += $3
            count++
        }
        END {
            if (count == 0) exit 1
            printf "ICU_WATER_RESERVE average usage: %.2f Liters/min (%d readings)", total / count, count
        }
    ' "$log_file") || {
        printf 'No valid ICU_WATER_RESERVE readings found in %s\n' "$log_file" >&2
        return 1
    }

    mkdir -p "$report_dir" || return 1
    printf '%s\n' "$summary" > "$report_file"
    printf 'Water audit written to %s\n' "$report_file"
}
