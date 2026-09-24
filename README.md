# Coding-lab_Group35: KNH Digital Infrastructure

The DevOps setup for Kenyatta National Hospital (KNH). It secures and manages data from 12 critical sensors (Heart Rate, Temperature and Water Usage). `hospital_system.py` generates the data. Three shell scripts handle environment setup, live analysis and log archiving.

## Team Roles

| Name | Role | Deliverable | Branch |
|------|------|-------------|--------|
| Janson | The Architect | `initialize_system()` in `hospital_admin.sh` | `feature/initialize-system` |
| Gahima | The Security Lead | `secure_data()` in `hospital_admin.sh` | `feature/secure-data` |
| Josia | The Orchestrator | Execution logic in `hospital_admin.sh` | `feature/admin-orchestration` |
| Dan | The Archivist | `hospital_archive.sh` | `feature/log-archiving` |
| Bethelhem | Clinical Analyst | `process_vitals()` in `hospital_analysis.sh` | `feature/process-vitals` |
| Alemayehu | Facility Auditor | `water_audit()` in `hospital_analysis.sh` | `feature/water-audit` |

## Repository Structure

```
Coding-lab_Group35/
├── hospital_system.py     # Data engine (simulator)
├── hospital_admin.sh      # Janson, Gahima, Josia: environment setup and permissions
├── hospital_analysis.sh   # Bethelhem, Alemayehu: critical alerts and water audit
├── hospital_archive.sh    # Dan: log rotation
├── .gitignore             # Keeps logs and reports out of version control
└── README.md
```

## Usage

```bash
# 1. Prepare and secure the environment
./hospital_admin.sh

# 2. Start the data engine
python3 hospital_system.py start

# 3. Analyse live data
./hospital_analysis.sh

# 4. Rotate logs into archived_logs
./hospital_archive.sh

# 5. Stop the data engine
python3 hospital_system.py stop
```

## Data Protection

KNH policy forbids uploading patient data. `active_logs/`, `archived_logs/` and `reports/` are ignored by Git and must never be committed.
