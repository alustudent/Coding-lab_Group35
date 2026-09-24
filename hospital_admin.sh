#!/usr/bin/env bash
# KNH environment setup and permission hardening.
# Owners: Janson, Gahima, Josia

# Janson: create active_logs, archived_logs and reports if missing
initialize_system() {
# Creating directories active_logs, archived_logs and reports if they do not exist
	for dir in active_logs archived_logs reports; do 
		if [ -d "$dir" ]; then
			echo "$dir directory already exists."
		else
			echo "Creating $dir directory..."
			mkdir "$dir"
		fi
	done
}

# Gahima: restrict active_logs to owner read/write and display permissions
# Applied strict 700 directory restriction
secure_data() {
    
    echo "Securing active_logs directory..."
        # 7=owner read/write/execute, 0=no access for group and others

    chmod 700 active_logs
    echo "Updated permissions for active_logs:"
    ls -ld active_logs

}

    


# Josia: execution logic
