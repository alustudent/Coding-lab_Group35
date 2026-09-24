#!/usr/bin/env bash
# KNH environment setup and permission hardening.
# Owners: Janson, Gahima, Josia

# Janson: create active_logs, archived_logs and reports if missing
initialize_system() {

# Creating directory active-logs if it's not there!
	if [ -d "active_logs" ]; then
		echo "active_logs already exists!"
	else
		echo "Creating active_logs directory"
		mkdir active_logs
	fi
# Creating archived_logs directory if it's not there it would create it
	if [ -d "archived_logs" ]; then
		echo "archived_logs alreaady exists"
	else
		echo "Creating archived_logs"
		mkdir archived_logs
	fi
# Creating reports dir if it's not there it creates one!
	if [ -d "reports" ]; then
		echo "reports already exists"
	else
		echo "Creating reports"
		mkdir reports
	fi
}

# Gahima: restrict active_logs to owner read/write and display permissions
secure_data() {
    :
}

# Josia: execution logic
