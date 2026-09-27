#!/usr/bin/env bash
# KNH log rotation: moves active logs into archived_logs with a timestamp.
# Owner: Dan

rotate_logs() {
    local timestamp
    timestamp=$(date +%Y%m%d_%H%M)

    if [ ! -d "archived_logs" ]; then
        echo "Error: archived_logs directory does not exist. Aborting." >&2
        return 1
    fi

    echo "Rotating logs at $timestamp..."

    for log in active_logs/*.log; do
        [ -e "$log" ] || continue

        local base
        base=$(basename "$log" .log)
        local dest="archived_logs/${base}_${timestamp}.log"

        # Don't clobber an existing archive from the same minute
        if [ -e "$dest" ]; then
            echo "Skipping $log -> $dest (archive already exists)" >&2
            continue
        fi

        mv "$log" "$dest"
        echo "Archived $log -> $dest"

        touch "$log"
    done

    echo "Log rotation complete - active_logs reset for continued recording."
}

rotate_logs
