#!/bin/bash

# ============================================================
#  Authority Verification Package Generator
#  Firetruck Security Platform — UNECE R155 + R156
# ============================================================

YEAR=$(date +"%Y")
ROOT_DIR="$(dirname "$0")/.."
cd "$ROOT_DIR"

AVP_DIR="authority_verification_package"
UPDATE_ID="FW-2026-03"

echo "Building Authority Verification Package for $YEAR..."
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

#cp compliance/R155/CSMS/certificate_package/CSMS_Declaration.md        "$AVP_DIR/CSMS/" 2>/dev/null
#cp compliance/R155/CSMS/certificate_package/CSMS_Evidence_Index.md     "$AVP_DIR/CSMS/" 2>/dev/null
#cp compliance/R155/CSMS/CSMS_Traceability_Matrix.md                    "$AVP_DIR/CSMS/" 2>/dev/null

#cp compliance/R155/CSMS/Risk_Register.md                               "$AVP_DIR/CSMS/" 2>/dev/null
#cp compliance/R155/CSMS/Threat_Vulnerability_Register.md               "$AVP_DIR/CSMS/" 2>/dev/null
#cp compliance/R155/CSMS/Supplier_Risk_Register.md                      "$AVP_DIR/CSMS/" 2>/dev/null

# Monitoring evidence
#cp logs/security_monitor.log                                            "$AVP_DIR/CSMS/monitoring/" 2>/dev/null
#cp compliance/R155/CSMS/snapshots/monitoring_snapshot_*                "$AVP_DIR/CSMS/monitoring/" 2>/dev/null
#cp compliance/R155/CSMS/snapshots/incident_snapshot_*                  "$AVP_DIR/CSMS/monitoring/" 2>/dev/null

# Annual CSMS report
#cp compliance/reports/report_${YEAR}.md                                 "$AVP_DIR/CSMS/annual_report_R155_${YEAR}.md" 2>/dev/null


# CSMS Declaration
cp compliance/R155/CSMS/certificate_package/CSMS_Declaration.md "$AVP_DIR/CSMS/"

# CSMS Evidence Index
cp compliance/R155/CSMS/certificate_package/CSMS_Evidence_Index.md "$AVP_DIR/CSMS/"

# CSMS Traceability Matrix
cp compliance/R155/CSMS/CSMS_Traceability_Matrix.md "$AVP_DIR/CSMS/"

# Risk Register
cp compliance/R155/CSMS/Risk_Register.md "$AVP_DIR/CSMS/"

# Supplier Risk Register
cp compliance/R155/CSMS/Supplier_Risk_Register.md "$AVP_DIR/CSMS/"

# Threat & Vulnerability Register
cp compliance/R155/CSMS/Threat_Vulnerability_Register.md "$AVP_DIR/CSMS/"

# Annual Report
cp compliance/reports/report_2026.md "$AVP_DIR/CSMS/annual_report_R155_2026.md"


# ------------------------------------------------------------
# 3. Copy SUMS Evidence
# ------------------------------------------------------------

cp compliance/R156/SUMS/SUMS_Declaration.md                             "$AVP_DIR/SUMS/" 2>/dev/null
cp compliance/R156/SUMS/SUMS_Documentation_Index.md                     "$AVP_DIR/SUMS/" 2>/dev/null
cp compliance/R156/SUMS/SUMS_Traceability_Matrix.md                     "$AVP_DIR/SUMS/" 2>/dev/null

# RXSWIN
cp compliance/R156/RXSWIN/rx_swin.json                                  "$AVP_DIR/SUMS/RXSWIN/" 2>/dev/null

# If snapshots exist, copy them
cp compliance/R156/RXSWIN/snapshots/*                                   "$AVP_DIR/SUMS/RXSWIN/snapshots/" 2>/dev/null

# Dossier for the update
DOSSIER_SRC="compliance/R156/dossiers/$UPDATE_ID"
DOSSIER_DST="$AVP_DIR/SUMS/dossiers/$UPDATE_ID"

cp "$DOSSIER_SRC/update_dossier.md"         "$DOSSIER_DST/" 2>/dev/null
cp "$DOSSIER_SRC/update_log.json"           "$DOSSIER_DST/" 2>/dev/null
cp "$DOSSIER_SRC/rollback_log.json"         "$DOSSIER_DST/" 2>/dev/null
cp "$DOSSIER_SRC/before_after_config.json"  "$DOSSIER_DST/" 2>/dev/null
cp "$DOSSIER_SRC/target_vehicle_list.json"  "$DOSSIER_DST/" 2>/dev/null

# Annual SUMS report (same report file, but renamed)
cp compliance/reports/report_${YEAR}.md      "$AVP_DIR/SUMS/annual_report_R156_${YEAR}.md" 2>/dev/null

# ------------------------------------------------------------
# 4. Copy VTA Security Case Documents
# ------------------------------------------------------------

cp compliance/R155/Evidence/R155_Compliance_Dossier.md                  "$AVP_DIR/VTA/Vehicle_Security_Case_R155.md" 2>/dev/null
cp compliance/R156/Evidence/compliance_dossier.md                       "$AVP_DIR/VTA/Vehicle_Update_Case_R156.md" 2>/dev/null

# Combined VTA case (if exists)
if [ -f compliance/VTA/Combined_VTA_Security_Case.md ]; then
    cp compliance/VTA/Combined_VTA_Security_Case.md "$AVP_DIR/VTA/"
fi

# ------------------------------------------------------------
# 5. Final Output
# ------------------------------------------------------------

echo "Authority Verification Package created successfully!"
echo "Directory: $AVP_DIR"
echo "You can now zip this directory and submit it to the Technical Service."
