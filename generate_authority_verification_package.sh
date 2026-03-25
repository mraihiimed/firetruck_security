#!/bin/bash

# ============================================================
#  Authority Verification Package Generator
#  Firetruck Security Platform — UNECE R155 + R156
# ============================================================

# Always run from project root
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# If script is inside tools/, go one level up
if [[ "$(basename "$SCRIPT_DIR")" == "tools" ]]; then
    cd ..
fi

ROOT_DIR="$(pwd)"
YEAR=$(date +"%Y")
AVP_DIR="authority_verification_package"
UPDATE_ID="FW-2026-03"

echo "Building Authority Verification Package for $YEAR..."
echo "Running from: $ROOT_DIR"
echo "Output directory: $AVP_DIR"

# ------------------------------------------------------------
# 1. Create directory structure
# ------------------------------------------------------------

mkdir -p "$AVP_DIR/CSMS/monitoring"
mkdir -p "$AVP_DIR/SUMS/RXSWIN/snapshots"
mkdir -p "$AVP_DIR/SUMS/dossiers/$UPDATE_ID"
mkdir -p "$AVP_DIR/VTA"

# ------------------------------------------------------------
# 2. Copy CSMS Evidence
# ------------------------------------------------------------

cp compliance/R155/CSMS/certificate_package/CSMS_Declaration.md "$AVP_DIR/CSMS/"
cp compliance/R155/CSMS/certificate_package/CSMS_Evidence_Index.md "$AVP_DIR/CSMS/"
cp compliance/R155/CSMS/CSMS_Traceability_Matrix.md "$AVP_DIR/CSMS/"

cp compliance/R155/CSMS/Risk_Register.md "$AVP_DIR/CSMS/"
cp compliance/R155/CSMS/Supplier_Risk_Register.md "$AVP_DIR/CSMS/"
cp compliance/R155/CSMS/Threat_Vulnerability_Register.md "$AVP_DIR/CSMS/"

# Monitoring evidence
cp logs/security_monitor.log "$AVP_DIR/CSMS/monitoring/" 2>/dev/null
cp compliance/R155/CSMS/snapshots/monitoring_snapshot_* "$AVP_DIR/CSMS/monitoring/" 2>/dev/null
cp compliance/R155/CSMS/snapshots/incident_snapshot_* "$AVP_DIR/CSMS/monitoring/" 2>/dev/null

# Annual CSMS report
cp compliance/reports/report_${YEAR}.md "$AVP_DIR/CSMS/annual_report_R155_${YEAR}.md" 2>/dev/null

# ------------------------------------------------------------
# 3. Copy SUMS Evidence
# ------------------------------------------------------------

cp compliance/R156/SUMS/SUMS_Declaration.md "$AVP_DIR/SUMS/"
cp compliance/R156/SUMS/SUMS_Documentation_Index.md "$AVP_DIR/SUMS/"
cp compliance/R156/SUMS/SUMS_Traceability_Matrix.md "$AVP_DIR/SUMS/"

# RXSWIN
cp compliance/R156/RXSWIN/rx_swin.json "$AVP_DIR/SUMS/RXSWIN/" 2>/dev/null
cp compliance/R156/RXSWIN/snapshots/* "$AVP_DIR/SUMS/RXSWIN/snapshots/" 2>/dev/null

# Dossier for the update
DOSSIER_SRC="compliance/R156/dossiers/$UPDATE_ID"
DOSSIER_DST="$AVP_DIR/SUMS/dossiers/$UPDATE_ID"

cp "$DOSSIER_SRC/update_dossier.md" "$DOSSIER_DST/" 2>/dev/null
cp "$DOSSIER_SRC/update_log.json" "$DOSSIER_DST/" 2>/dev/null
cp "$DOSSIER_SRC/rollback_log.json" "$DOSSIER_DST/" 2>/dev/null
cp "$DOSSIER_SRC/before_after_config.json" "$DOSSIER_DST/" 2>/dev/null
cp "$DOSSIER_SRC/target_vehicle_list.json" "$DOSSIER_DST/" 2>/dev/null

# Annual SUMS report
cp compliance/reports/report_${YEAR}.md "$AVP_DIR/SUMS/annual_report_R156_${YEAR}.md" 2>/dev/null

# ------------------------------------------------------------
# 4. Copy VTA Security Case Documents
# ------------------------------------------------------------

cp compliance/R155/Evidence/R155_Compliance_Dossier.md "$AVP_DIR/VTA/Vehicle_Security_Case_R155.md" 2>/dev/null
cp compliance/R156/Evidence/compliance_dossier.md "$AVP_DIR/VTA/Vehicle_Update_Case_R156.md" 2>/dev/null

# Combined VTA case (optional)
if [ -f compliance/VTA/Combined_VTA_Security_Case.md ]; then
    cp compliance/VTA/Combined_VTA_Security_Case.md "$AVP_DIR/VTA/"
fi

# ------------------------------------------------------------
# 5. Final Output
# ------------------------------------------------------------

echo "Authority Verification Package created successfully!"
echo "Directory: $AVP_DIR"
echo "You can now zip this directory and submit it to the Technical Service."
