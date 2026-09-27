#!/usr/bin/env bash
# KNH live data analysis on active_logs before archiving.
# Owners: Bethelhem, Bellamy

# Bethelhem: extract CRITICAL heart rate and temperature rows into reports/critical_alerts.txt
process_vitals() {
    :
}

# Bellamy: average water usage for ICU_WATER_RESERVE
water_audit() {
    :
}

# Bellamy: execution logic
# Run from the script's directory so relative log paths resolve from anywhere
cd "$(dirname "$0")" || exit 1

process_vitals
water_audit
