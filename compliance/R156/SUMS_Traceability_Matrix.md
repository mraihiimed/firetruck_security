# SUMS ↔ Codebase Traceability Matrix
Firetruck Security Platform  
UNECE R156 Compliance Mapping

| R156 Requirement | SUMS Process | Implementation in Code | Evidence / Logs / Docs |
|------------------|--------------|-------------------------|-------------------------|
| §7.1.1.1 – Documentation stored securely | SUMS Documentation Process | compliance/R156/* | SUMS_Documentation_Index.md |
| §7.1.1.2 – Unique SW identification | Versioning Process | version tags in update_simulator.c, RXSWIN entries | rx_swin.json |
| §7.1.1.2 – Integrity validation data | Integrity Process | hash generation in update_simulator.c | update_dossier.md |
| §7.1.1.3 – RXSWIN update process | RXSWIN Management | rx_swin.json updated after OTA | RXSWIN snapshot |
| §7.1.1.4 – RXSWIN consistency check | Consistency Check Process | version comparison logic in update_simulator.c | update_log.json |
| §7.1.1.5 – System interdependencies | Impact Analysis Process | update impact logic in update_simulator.c | update_dossier.md |
| §7.1.1.6 – Target vehicle identification | Target Vehicle Process | simulated VIN/vehicle list | target_vehicle_list.json |
| §7.1.1.7 – Compatibility check | Compatibility Process | config comparison in update_simulator.c | before_after_config.json |
| §7.1.1.8 – Impact on type approvals | Type Approval Impact Process | update_dossier.md | update_dossier.md |
| §7.1.1.9 – Impact on functions | Functional Impact Process | function change list in update_simulator.c | update_dossier.md |
| §7.1.1.10 – Impact on safety systems | Safety Impact Process | safety checks in update_simulator.c | safety_impact_report.md |
| §7.1.1.11 – User notification | User Info Process | simulated HMI messages | user_notification_log.txt |
| §7.1.1.12 – Authority data access | Authority Access Process | RXSWIN + update history export | rx_swin.json, update_history.json |
| §7.1.2.1 – SUMS process documentation | SUMS Documentation | compliance/R156/* | SUMS_Documentation_Index.md |
| §7.1.2.2 – Configuration before/after | Config Tracking Process | before/after snapshots in update_simulator.c | before_after_config.json |
| §7.1.2.3 – RXSWIN register | RXSWIN Register Process | rx_swin.json | RXSWIN snapshot |
| §7.1.2.4 – Target vehicle list | Target Vehicle Process | target_vehicle_list.json | target_vehicle_list.json |
| §7.1.2.5 – Update dossier | Update Dossier Process | update_dossier.md auto‑generated | update_dossier.md |
| §7.1.3.1 – Update integrity protection | Integrity Protection | hash + signature simulation | integrity_check.log |
| §7.1.3.2 – Update process protection | Delivery Protection | simulated secure channel in update_simulator.c | update_log.json |
| §7.1.3.3 – SW validation process | Validation Process | validation logic in update_simulator.c | validation_report.md |
| §7.1.4.1 – OTA safety while driving | Safety Check Process | safe‑state check in update_simulator.c | safety_check.log |
| §7.1.4.2 – Skilled action requirement | Skilled Action Process | block updates requiring technician | update_policy.md |
| §7.2.2.1.1 – Rollback capability | Rollback Process | rollback logic in update_simulator.c | rollback_log.json |
| §7.2.2.1.2 – Power check | Power Check Process | simulated power check | power_check.log |
| §7.2.2.1.3 – Safe execution | Safe Execution Process | vehicle state validation | update_log.json |
| §7.2.2.2(a) – Pre‑update info: purpose | User Info Process | HMI simulation | user_notification_log.txt |
| §7.2.2.2(b) – Pre‑update info: changes | User Info Process | change list in update_simulator.c | update_dossier.md |
| §7.2.2.2(c) – Pre‑update info: duration | User Info Process | simulated duration estimate | update_dossier.md |
| §7.2.2.2(d) – Pre‑update info: unavailable functions | User Info Process | function disable list | update_dossier.md |
| §7.2.2.2(e) – Pre‑update info: instructions | User Info Process | HMI instructions | user_notification_log.txt |
| §7.2.2.3(a) – No driving during unsafe updates | Driving Restriction Process | safe‑state enforcement | update_log.json |
| §7.2.2.3(b) – Disable safety‑critical functions | Safety Restriction Process | function disable logic | update_dossier.md |
| §7.2.2.4(a) – User informed of success/failure | Post‑Update Info Process | HMI simulation | user_notification_log.txt |
| §7.2.2.4(b) – User informed of changes | Post‑Update Info Process | change summary | update_dossier.md |
| §7.2.1.1 – Authenticity & integrity | Integrity Check Process | hash/signature simulation | integrity_check.log |
| §7.2.1.2.1 – Unique RXSWIN | RXSWIN Process | rx_swin.json | RXSWIN snapshot |
| §7.2.1.2.2 – RXSWIN readable via OBD | OBD Access Process | simulated OBD read | rx_swin.json |
| §7.2.1.2.3 – RXSWIN protected | RXSWIN Protection Process | write‑protection simulation | update_policy.md |
| §6.3.1 – SUMS documentation | Certificate Package | compliance/R156/* | SUMS_Documentation_Index.md |
| §6.3.2 – SUMS declaration | Declaration | sums_declaration.md | sums_declaration_signed.pdf |
| §6.4 – Initial assessment | Assessment Procedure | full repo + update logs | evidence package |
| §6.6 – Certificate validity | Certificate Lifecycle | renewal plan | certificate_lifecycle.md |
| §6.8 – Change notification | Change Management | update history + RXSWIN changes | update_history.json |
| §6.9 – Renewal | Renewal Procedure | updated SUMS docs | renewal_package/ |
