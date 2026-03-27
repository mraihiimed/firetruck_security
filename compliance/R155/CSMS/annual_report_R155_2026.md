# Annual CSMS Report – 2026  
Firetruck Security Platform  
UN Regulation No. 155 – Cybersecurity Management System (CSMS)  
Reporting Year: 2026  
Prepared by: CSMS Compliance Team  
Date: 2026‑03‑24  

---

## 1. Executive Summary

This annual CSMS report summarizes all cybersecurity‑related activities performed on the Firetruck Security Platform during January–March 2026.

It demonstrates compliance with UN R155 requirements, including:

- Cybersecurity monitoring  
- Threat & vulnerability management  
- Incident detection and response  
- Mitigation effectiveness  
- Risk assessment updates  
- Supplier cybersecurity management  
- CSMS process changes  
- Evidence retention  

All referenced artifacts are included in the Authority Verification Package (AVP).

---

## 2. Cybersecurity Monitoring (R155 §7.4)

### 2.1 Threat & Vulnerability Monitoring

Sources monitored:

- CVE database  
- Automotive ISAC  
- Internal ECU/Gateway logs  
- security_monitor_simulator  

Summary of findings:

- No critical vulnerabilities affecting deployed components  
- 3 medium‑severity CVEs evaluated and mitigated  
- 2 internal anomalies detected and resolved  

Evidence:  
`logs/security_monitor.log`

### 2.2 Vulnerability Assessment

| Vulnerability | Severity | Status | Notes |
|---------------|----------|--------|-------|
| CVE‑2026‑1234 | High     | Fixed  | Patched in v1.4 |
| CVE‑2026‑2210 | Medium   | Mitigated | Filtering rule added |
| Internal anomaly #17 | Low | Closed | False positive |

Evidence:  
`Evidence/vulnerability_register.json`

---

## 3. Cybersecurity Incidents (R155 §7.4)

### 3.1 Incident Summary

- Total incidents detected: **2**  
- Critical incidents: **0**  
- Mitigated incidents: **2**  

### 3.2 Forensic Data Summary

Forensic logs stored under:

logs/security_monitor.log
logs/main_ecu.log


### 3.3 Timely Mitigation (R155 §7.2.2.3)

All critical vulnerabilities were mitigated within **30 days**.

Evidence:  
`incident_snapshot.json`

---

## 4. Effectiveness of Mitigations (R155 §7.4)

### 4.1 Mitigation Performance

| Mitigation | Status | Evidence |
|-----------|--------|----------|
| PGN Whitelist | Effective | main_ecu/sec_log.log |
| DoS Detection | Effective | attacker_node tests |
| State Machine Validation | Effective | state_model.c |

### 4.2 Required Improvements

- Improve anomaly classification  
- Add additional spoofing detection rules  

---

## 5. Risk Assessment Update (R155 §7.2.2.2(f))

Updates:

- **New risks identified:** 1  
- **Risks retired:** 2  
- **Updated ratings:** 4  

Evidence:  
`risk_snapshot_2026-03-24.json`  
`Risk_Register.md`

---

## 6. Supplier Risk Review (R155 §7.2.2.5)

Supplier‑related risks documented in:

- `Supplier_Risk_Register.md`  
- `supplier_boundary_map.md`

No new supplier risks identified in 2026.

---

## 7. CSMS Changes (R155 §6.9)

Changes made to:

### Processes
- Updated threat monitoring workflow  
- Added automated snapshot generation  

### Tools
- security_monitor_simulator updated  
- New risk scoring script added  

### Organization
- Added one cybersecurity analyst  

### Responsibilities
- Monitoring escalation thresholds updated  

Evidence:  
`CSMS_Processes.md`

---

## 8. CSMS Snapshots

Included in AVP:

csms_status_2026-03-24_12-53-15.json
monitoring_snapshot_2026-03-24_12-53-15.json
risk_snapshot_2026-03-24_12-53-15.json
testing_snapshot_2026-03-24_12-53-15.json


---

## 9. CSMS ↔ Codebase Traceability Summary (R155 §6.3–§7.3)

A full traceability matrix is included in Appendix D.

---

## 10. Evidence Retention

All CSMS evidence is retained for **10 years**, as defined in:

- `CSMS_Records_and_Retention.md`  
- `CSMS_Documentation_Index.md`

---

## 11. Declaration

I hereby confirm that:

- All cybersecurity incidents have been reported (R155).  
- All mitigations remain effective (R155).  
- All monitoring obligations were fulfilled (R155).  
- All risk assessments were kept up to date (R155).  

Signature: ______________________  
Name: __________________________  
Date: __________________________  

---

# Appendices

---

## Appendix A — Forensic Logs

Included in AVP:

- `logs/security_monitor.log`  
- `logs/main_ecu.log`  

---

## Appendix B — CSMS Snapshots

- `csms_status_2026-03-24_12-53-15.json`  
- `monitoring_snapshot_2026-03-24_12-53-15.json`  
- `risk_snapshot_2026-03-24_12-53-15.json`  
- `testing_snapshot_2026-03-24_12-53-15.json`  

---

## Appendix C — Incident Snapshots

- `incident_snapshot.json`  

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

