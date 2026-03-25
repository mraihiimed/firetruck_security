# Create root folder
mkdir -p authority_verification_package

cd authority_verification_package

# Create CSMS structure
mkdir -p CSMS/monitoring

touch CSMS/CSMS_Declaration.md \
      CSMS/CSMS_Evidence_Index.md \
      CSMS/CSMS_Traceability_Matrix.md \
      CSMS/Risk_Register.md \
      CSMS/Threat_Vulnerability_Register.md \
      CSMS/Supplier_Risk_Register.md \
      CSMS/annual_report_R155_2026.md

touch CSMS/monitoring/security_monitor.log \
      CSMS/monitoring/monitoring_snapshot_1.json \
      CSMS/monitoring/incident_snapshot_1.json


# Create SUMS structure
mkdir -p SUMS/RXSWIN/snapshots
mkdir -p SUMS/dossiers/FW-2026-03

touch SUMS/SUMS_Declaration.md \
      SUMS/SUMS_Documentation_Index.md \
      SUMS/SUMS_Traceability_Matrix.md \
      SUMS/annual_report_R156_2026.md

touch SUMS/RXSWIN/rx_swin.json

touch SUMS/dossiers/FW-2026-03/update_dossier.md \
      SUMS/dossiers/FW-2026-03/update_log.json \
      SUMS/dossiers/FW-2026-03/rollback_log.json \
      SUMS/dossiers/FW-2026-03/integrity_check.log \
      SUMS/dossiers/FW-2026-03/before_after_config.json \
      SUMS/dossiers/FW-2026-03/target_vehicle_list.json


# Create VTA structure
mkdir -p VTA

touch VTA/Vehicle_Security_Case_R155.md \
      VTA/Vehicle_Update_Case_R156.md \
      VTA/Combined_VTA_Security_Case.md
