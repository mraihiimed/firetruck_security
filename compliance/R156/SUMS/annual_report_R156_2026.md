# Annual SUMS Report – 2026  
**Firetruck Security Platform**  
**UN Regulation No. 156 – Software Update Management System (SUMS)**  
**Reporting Year:** 2026  
**Prepared by:** SUMS Compliance Team  
**Date:** 2026‑03‑24

---

## 1. Introduction
This annual report summarizes all software update activities performed on the Firetruck Security Platform during the reporting period of January–March 2026.  
It demonstrates compliance with the requirements of UN R156, including:

- Software update governance  
- Update identification and documentation  
- Impact analysis  
- Verification and validation  
- User notification  
- Update integrity and safety assurance  
- RXSWIN management  
- Evidence retention  

All referenced artifacts are included in the Authority Verification Package (AVP).

---

## 2. Overview of Updates Performed in 2026
During this reporting period, one software update was released:

| Update ID | ECU | Version Change | Release Date | Type |
|-----------|-----|----------------|--------------|------|
| FW‑2026‑03 | Main ECU | v1.3 → v1.4 | 2026‑03‑24 | Security + Logging Improvements |

The update was deployed to all vehicles listed in `target_vehicle_list.json`.

---

## 3. Update Description (FW‑2026‑03)
### 3.1 Purpose
The FW‑2026‑03 update introduces:

- Improved security logging  
- Certificate lifecycle enhancements  
- Minor OTA handler improvements  
- No functional or safety‑critical behavior changes  

### 3.2 Affected Components
- Main ECU logging subsystem  
- Certificate renewal logic  
- OTA update handler  

### 3.3 Update Package Evidence
Included in AVP under:

SUMS/dossiers/FW-2026-03/


---

## 4. Impact Analysis

### 4.1 Safety Impact  
Documented in `safety_impact_report.md`.

**Conclusion:**  
No safety‑critical functions were modified.

### 4.2 Cybersecurity Impact  
- Logging improvements enhance detection capability  
- Certificate lifecycle improvements reduce long‑term exposure  
- No new attack surfaces introduced  

### 4.3 Functional Impact  
No functional behavior changes outside the logging subsystem.

---

## 5. Verification & Validation

| Test Category        | Result | Evidence                     |
|----------------------|--------|------------------------------|
| Integrity Check      | PASS   | integrity_check.log          |
| Power Stability      | PASS   | power_check.log              |
| Safety Check         | PASS   | safety_check.log             |
| User Notification    | PASS   | user_notification_log.txt    |
| Rollback Procedure   | PASS   | rollback_log.json            |
| Update Validation    | PASS   | validation_report.md         |

---

## 6. RXSWIN Management

RXSWIN snapshot included in:

SUMS/RXSWIN/snapshots/rx_swin_snapshot_2026-03-24.json


- ECU: Main ECU  
- Software Version: 1.4  
- RXSWIN: RXSWIN‑2026‑03‑21  

---

## 7. Certificate Lifecycle Activities

A scheduled certificate rotation was performed.

Artifacts:

- `certificate_renewal_request.json`  
- `certificate_renewal_report.md`  
- `certificate_lifecycle.md`  

Outcome: **SUCCESS**

---

## 8. User Notification

Users were notified via HMI.

Evidence:

logs/user_notification_log.txt


---

## 9. Update History

Maintained in:

Evidence/update_history.json


History shows:

- v1.2 installed (2025‑11‑10)  
- v1.3 installed (2026‑01‑15)  
- v1.4 installed (2026‑03‑24)  

---

## 10. Evidence Retention & Documentation

All SUMS evidence is retained for **10 years**, as defined in:

- `SUMS_Records_and_Retention.md`  
- `SUMS_Documentation_Index.md`  

---

## 11. Compliance Statement

I hereby confirm that:

- All software updates were performed safely (R156).  
- All RXSWIN entries are accurate (R156).  
- All update integrity checks were performed (R156).  
- All cybersecurity monitoring obligations were fulfilled (R155).  

Signature: ______________________  
Name: __________________________  
Date: __________________________  

---

# Appendices

---

## Appendix A — Update Dossier (FW‑2026‑03)

Included in:

SUMS/dossiers/FW-2026-03/


---

## Appendix B — RXSWIN Snapshot

{
"timestamp": "2026-03-24T12:05:00Z",
"rx_swin": "RXSWIN-2026-03-21",
"ecu": "main_ecu",
"software_version": "1.4",
"dossier": "FW-2026-03"
}


---

## Appendix C — Validation & Safety Logs

- integrity_check.log  
- power_check.log  
- safety_check.log  
- user_notification_log.txt  

---

## Appendix D — CSMS ↔ Codebase Traceability Matrix

| R155 Requirement | CSMS Process | Implementation | Evidence |
|------------------|-------------|----------------|----------|
| §7.2.2.1 – CSMS in place | CSMS_Scope.md | Entire architecture | CSMS_Documentation_Index.md |
| §7.2.2.2(a) – Security processes | CSMS_Processes.md | state_model.c, policy_engine.c | CSMS_Processes.md |
| §7.2.2.2(b) – Risk identification | Risk Assessment Procedure | attacker_node, CAN analysis | Risk_Register.md |
| §7.2.2.2(c) – Risk assessment | Risk Assessment Procedure | mitigations in gw_*_sec.c | risk_assessment.md |
| §7.2.2.2(d) – Risk verification | Verification Process | gateway filtering | security_monitor.log |
| §7.2.2.2(e) – Cybersecurity testing | Security Testing Process | attack_dos.c, attack_spoof.c | testing_snapshot.json |
| §7.2.2.2(f) – Keep risk assessment current | Lifecycle Update Process | update_simulator.c | CSMS snapshots |
| §7.2.2.2(g) – Threat monitoring | Threat Monitoring Procedure | security_monitor_simulator.c | security_monitor.log |
| §7.2.2.2(h) – Forensic data | Forensic Logging Specification | sec_log.c | forensic_log_reference.md |
| §7.2.2.3 – Timely mitigation | Incident Response Plan | gateway blocking logic | incident_snapshot.json |
| §7.2.2.4 – Continual monitoring | Monitoring Procedure | monitoring simulator | monitoring_snapshot.json |
| §7.2.2.5 – Supplier dependency | Supplier Cybersecurity Policy | subsystem boundaries | Supplier_Risk_Register.md |
| §7.3.3 – Vehicle risk assessment | Risk Assessment Process | architecture threat model | risk_assessment.md |
| §7.3.4 – Mitigations implemented | Mitigation Mapping | gw_*_sec.c, state_model.c | mitigation_snapshot.json |
| §7.3.5 – Security monitoring | Monitoring Procedure | runtime logs | monitoring_snapshot.json |
| §7.3.6 – Incident response | Incident Response Plan | state machine logic | incident_snapshot.json |
| §7.3.7 – Forensic logging | Forensic Logging Specification | main_ecu logs | forensic_log_reference.md |
| §7.3.8 – Cryptography | Cryptographic Controls | RSA‑2048, SHA‑256 | update_signing.md |

---

## Appendix E — Risk Register

Included in AVP.

---

## Appendix F — Supplier Risk Register

Included in AVP.

---

## Appendix G — Threat & Vulnerability Register

Included in AVP.

