#!/bin/bash

# Always run from project root
ROOT_DIR="$(dirname "$0")/.."
cd "$ROOT_DIR"

YEAR=$(date +"%Y")
DATE=$(date +"%Y-%m-%d")
OUTPUT_DIR="compliance/reports"
TEMPLATE="compliance/reporting_template.md"
OUTPUT="$OUTPUT_DIR/report_$YEAR.md"

mkdir -p "$OUTPUT_DIR"

echo "Generating combined R155 + R156 report for $YEAR..."

###############################################
# 1. Copy template and replace placeholders
###############################################
cp "$TEMPLATE" "$OUTPUT"

sed -i "s/__YEAR__/$YEAR/g" "$OUTPUT"
sed -i "s/__DATE__/$DATE/g" "$OUTPUT"
sed -i "s/__AUTHOR__/Imed/g" "$OUTPUT"

###############################################
# 2. Append Forensic Logs (Appendix A)
###############################################
echo -e "\n\n# Appendix A — Forensic Logs\n" >> "$OUTPUT"
if [ -f logs/security_monitor.log ]; then
    echo '```' >> "$OUTPUT"
    cat logs/security_monitor.log >> "$OUTPUT"
    echo '```' >> "$OUTPUT"
else
    echo "_No forensic logs found._" >> "$OUTPUT"
fi

###############################################
# 3. Append CSMS Snapshots (Appendix B)
###############################################
echo -e "\n\n# Appendix B — CSMS Snapshots\n" >> "$OUTPUT"
if [ -d compliance/R155/CSMS/snapshots ]; then
    echo '```' >> "$OUTPUT"
    ls compliance/R155/CSMS/snapshots >> "$OUTPUT"
    echo '```' >> "$OUTPUT"
else
    echo "_No CSMS snapshots found._" >> "$OUTPUT"
fi

###############################################
# 4. Append RXSWIN (Appendix C)
###############################################
echo -e "\n\n# Appendix C — RXSWIN\n" >> "$OUTPUT"
if [ -f compliance/R156/RXSWIN/rx_swin.json ]; then
    echo '```json' >> "$OUTPUT"
    cat compliance/R156/RXSWIN/rx_swin.json >> "$OUTPUT"
    echo '```' >> "$OUTPUT"
else
    echo "_No RXSWIN file found._" >> "$OUTPUT"
fi

###############################################
# 5. Append CSMS Traceability Matrix (Appendix D)
###############################################
echo -e "\n\n# Appendix D — CSMS Traceability Matrix\n" >> "$OUTPUT"
if [ -f compliance/R155/CSMS/CSMS_Traceability_Matrix.md ]; then
    # Insert raw Markdown (NO code fences → proper table rendering)
    echo -e "\n\n# Appendix D - CSMS Traceability Matrix\n" >> "$OUTPUT"
    cat compliance/R155/CSMS/CSMS_Traceability_Matrix.md >> "$OUTPUT"
else
    echo "_No CSMS Traceability Matrix found._" >> "$OUTPUT"
fi

###############################################
# 6. Append Risk Register (Appendix E)
###############################################
echo -e "\n\n# Appendix E — Risk Register\n" >> "$OUTPUT"
if [ -f compliance/R155/CSMS/Risk_Register.md ]; then
    cat compliance/R155/CSMS/Risk_Register.md >> "$OUTPUT"
else
    echo "_No Risk Register found._" >> "$OUTPUT"
fi

###############################################
# 7. Append Supplier Risk Register (Appendix F)
###############################################
echo -e "\n\n# Appendix F — Supplier Risk Register\n" >> "$OUTPUT"
if [ -f compliance/R155/CSMS/Supplier_Risk_Register.md ]; then
    cat compliance/R155/CSMS/Supplier_Risk_Register.md >> "$OUTPUT"
else
    echo "_No Supplier Risk Register found._" >> "$OUTPUT"
fi

###############################################
# 8. Append Threat & Vulnerability Register (Appendix G)
###############################################
echo -e "\n\n# Appendix G — Threat & Vulnerability Register\n" >> "$OUTPUT"
if [ -f compliance/R155/CSMS/Threat_Vulnerability_Register.md ]; then
    cat compliance/R155/CSMS/Threat_Vulnerability_Register.md >> "$OUTPUT"
else
    echo "_No Threat & Vulnerability Register found._" >> "$OUTPUT"
fi

###############################################
# Done
###############################################
echo "Report generated:"
echo "$OUTPUT"
