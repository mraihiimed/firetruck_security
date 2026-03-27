#!/bin/bash
set -e

AVP_DIR="authority_verification_package"
CSMS_DIR="$AVP_DIR/CSMS"
SUMS_DIR="$AVP_DIR/SUMS"

echo "[INFO] Generating Authority Verification Package (AVP)..."

# Clean previous AVP
rm -rf "$AVP_DIR"
mkdir -p "$CSMS_DIR/monitoring"
mkdir -p "$SUMS_DIR/RXSWIN/snapshots"
mkdir -p "$SUMS_DIR/dossiers/FW-2026-03"
mkdir -p "$SUMS_DIR/renewal_package"
mkdir -p "$SUMS_DIR/logs"
mkdir -p "$SUMS_DIR/evidence"


echo "[INFO] Copying CSMS evidence..."

# Core CSMS documents
cp compliance/R155/CSMS/certificate_package/CSMS_Declaration.md "$CSMS_DIR/"
cp compliance/R155/CSMS/certificate_package/CSMS_Evidence_Index.md "$CSMS_DIR/"
cp compliance/R155/CSMS/certificate_package/CSMS_Certificate_Lifecycle.md "$CSMS_DIR/"

cp compliance/R155/CSMS/CSMS_Documentation_Index.md "$CSMS_DIR/"
cp compliance/R155/CSMS/CSMS_Traceability_Matrix.md "$CSMS_DIR/"
cp compliance/R155/CSMS/CSMS_Scope.md "$CSMS_DIR/"
cp compliance/R155/CSMS/csms_overview.md "$CSMS_DIR/"
cp compliance/R155/CSMS/CSMS_Processes.md "$CSMS_DIR/"
cp compliance/R155/CSMS/csms_process_flowchart.md "$CSMS_DIR/"

# Registers
cp compliance/R155/CSMS/Risk_Register.md "$CSMS_DIR/"
cp compliance/R155/CSMS/Supplier_Risk_Register.md "$CSMS_DIR/"
cp compliance/R155/CSMS/Threat_Vulnerability_Register.md "$CSMS_DIR/"

# Policies & procedures
cp compliance/R155/CSMS/Forensic_Logging_Specification.md "$CSMS_DIR/"
cp compliance/R155/CSMS/Incident_Response_Plan.md "$CSMS_DIR/"
cp compliance/R155/CSMS/Supplier_Cybersecurity_Policy.md "$CSMS_DIR/"
cp compliance/R155/CSMS/Threat_Monitoring_Procedure.md "$CSMS_DIR/"

# Snapshots
cp compliance/R155/CSMS/snapshots/*.json "$CSMS_DIR/monitoring/" 2>/dev/null || true

# Pentest logs (optional)
cp pentest/logs/*.json "$CSMS_DIR/monitoring/" 2>/dev/null || true
cp pentest/logs/*.log "$CSMS_DIR/monitoring/" 2>/dev/null || true






###############################################
# 1. Copy CSMS Evidence
###############################################

#echo "[INFO] Copying CSMS evidence..."

#cp compliance/R155/CSMS/CSMS_Declaration.md "$CSMS_DIR/"
#cp compliance/R155/CSMS/CSMS_Evidence_Index.md "$CSMS_DIR/"
#cp compliance/R155/CSMS/CSMS_Traceability_Matrix.md "$CSMS_DIR/"
#cp compliance/R155/CSMS/Risk_Register.md "$CSMS_DIR/"
#cp compliance/R155/CSMS/Supplier_Risk_Register.md "$CSMS_DIR/"
#cp compliance/R155/CSMS/Threat_Vulnerability_Register.md "$CSMS_DIR/"
#cp compliance/R155/CSMS/annual_report_R155_2026.md "$CSMS_DIR/"

# Monitoring evidence
#cp compliance/R155/CSMS/snapshots/incident_snapshot_*.json "$CSMS_DIR/monitoring/" 2>/dev/null || true
#cp compliance/R155/CSMS/snapshots/testing_snapshot_*.json "$CSMS_DIR/monitoring/" 2>/dev/null || true

# Pentest logs (optional but recommended)
#cp pentest/logs/*.json "$CSMS_DIR/monitoring/" 2>/dev/null || true
#cp pentest/logs/*.log "$CSMS_DIR/monitoring/" 2>/dev/null || true

###############################################
# 2. Copy SUMS Evidence
###############################################

echo "[INFO] Copying SUMS evidence..."

# Core SUMS documentation
cp compliance/R156/SUMS/SUMS_Declaration.md "$SUMS_DIR/"
cp compliance/R156/SUMS/SUMS_Documentation_Index.md "$SUMS_DIR/"
cp compliance/R156/SUMS/SUMS_Traceability_Matrix.md "$SUMS_DIR/"
cp compliance/R156/SUMS/SUMS_Overview.md "$SUMS_DIR/"
cp compliance/R156/SUMS/SUMS_Identification.md "$SUMS_DIR/"
cp compliance/R156/SUMS/SUMS_Impact_Analysis.md "$SUMS_DIR/"
cp compliance/R156/SUMS/SUMS_Records_and_Retention.md "$SUMS_DIR/"
cp compliance/R156/SUMS/update_policy.md "$SUMS_DIR/"
cp compliance/R156/SUMS/certificate_lifecycle.md "$SUMS_DIR/"
cp compliance/R156/SUMS/update_signing.md "$SUMS_DIR/"
cp compliance/R156/SUMS/user_information_template.md "$SUMS_DIR/"
cp compliance/R156/SUMS/update_dossier.md "$SUMS_DIR/"
cp compliance/R156/SUMS/sums_declaration_signed.pdf "$SUMS_DIR/"

# Annual report
cp compliance/R156/SUMS/annual_report_R156_2026.md "$SUMS_DIR/"

###############################################
# 3. RXSWIN
###############################################

echo "[INFO] Copying RXSWIN data..."

cp compliance/R156/RXSWIN/rx_swin.json "$SUMS_DIR/RXSWIN/"
cp compliance/R156/RXSWIN/snapshots/*.json "$SUMS_DIR/RXSWIN/snapshots/" 2>/dev/null || true

###############################################
# 4. Dossier FW‑2026‑03
###############################################

echo "[INFO] Copying update dossier..."

cp -r compliance/R156/dossiers/FW-2026-03/* "$SUMS_DIR/dossiers/FW-2026-03/"

###############################################
# 5. SUMS Evidence Files (newly created)
###############################################

echo "[INFO] Copying SUMS evidence files..."

cp compliance/R156/Evidence/safety_impact_report.md "$SUMS_DIR/evidence/"
cp compliance/R156/Evidence/validation_report.md "$SUMS_DIR/evidence/"
cp compliance/R156/Evidence/update_history.json "$SUMS_DIR/evidence/"

###############################################
# 6. Logs (integrity, power, safety, user notification)
###############################################

echo "[INFO] Copying SUMS logs..."

cp logs/integrity_check.log "$SUMS_DIR/logs/"
cp logs/power_check.log "$SUMS_DIR/logs/"
cp logs/safety_check.log "$SUMS_DIR/logs/"
cp logs/user_notification_log.txt "$SUMS_DIR/logs/"

###############################################
# 7. Certificate Renewal Package
###############################################

echo "[INFO] Copying certificate renewal package..."

cp compliance/R156/renewal_package/* "$SUMS_DIR/renewal_package/"

###############################################
# 8. Finalization
###############################################

echo "[INFO] AVP generation complete."
tree "$AVP_DIR" || ls -R "$AVP_DIR"
