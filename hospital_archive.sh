#!/usr/bin/env bash
# KNH log rotation: moves active logs into archived_logs with a timestamp.
# Owner: Dan

rotate_logs() {
    local timestamp
    timestamp=$(date +%Y%m%d_%H%M)

    # Fail fast if archived_logs doesn't exist - don't silently succeed
    if [ ! -d "archived_logs" ]; then
        echo "Error: archived_logs directory does not exist. Aborting." >&2
        return 1
    fi

    echo "Rotating logs at $timestamp..."

    for log in active_logs/*.log; do
        # Skipping the glob literal if active_logs has no .log files yet
        [ -e "$log" ] || continue

        local base
        base=$(basename "$log" .log)
        local dest="archived_logs/${base}_${timestamp}.log"

        mv "$log" "$dest"
        echo "Archived $log -> $dest"

        touch "$log"
    done

    echo "Log rotation complete - active_logs reset for continued recording."
}

rotate_logs
