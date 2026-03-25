#!/bin/bash

YEAR=$(date +"%Y")
DATE=$(date +"%Y-%m-%d")
OUTPUT_DIR="compliance/reports"
TEMPLATE="compliance/reporting_template.md"
OUTPUT="$OUTPUT_DIR/report_$YEAR.md"

mkdir -p "$OUTPUT_DIR"

echo "Generating combined R155 + R156 report for $YEAR..."

# Copy template
cp "$TEMPLATE" "$OUTPUT"

# Replace placeholders
sed -i "s/__YEAR__/$YEAR/g" "$OUTPUT"
sed -i "s/__DATE__/$DATE/g" "$OUTPUT"
sed -i "s/__AUTHOR__/Imed/g" "$OUTPUT"

# Append forensic logs
echo -e "\n\n# Appendix A — Forensic Logs\n" >> "$OUTPUT"
echo '```' >> "$OUTPUT"
cat logs/security_monitor.log >> "$OUTPUT"
echo '```' >> "$OUTPUT"

# Append CSMS snapshots
echo -e "\n\n# Appendix B — CSMS Snapshots\n" >> "$OUTPUT"
echo '```' >> "$OUTPUT"
ls compliance/R155/CSMS/snapshots >> "$OUTPUT"
echo '```' >> "$OUTPUT"

# Append RXSWIN
echo -e "\n\n# Appendix C — RXSWIN\n" >> "$OUTPUT"
echo '```' >> "$OUTPUT"
cat compliance/R156/RXSWIN/rx_swin.json >> "$OUTPUT"
echo '```' >> "$OUTPUT"

echo "Report generated:"
echo "$OUTPUT"
