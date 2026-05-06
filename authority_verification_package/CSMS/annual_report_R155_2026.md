# Combined R155 + R156 Annual Compliance Report
Manufacturer: Firetruck Security Platform  
Vehicle Type: Firetruck Security Platform  
Reporting Period: 2026  
Prepared by: Imed  
Date: 2026-03-24

---

# 1. Executive Summary
This report summarizes the cybersecurity and software update posture of the Firetruck Security Platform for the reporting period.

It includes:
- Cybersecurity monitoring results (R155)
- Cybersecurity incidents and mitigations (R155)
- Risk assessment updates (R155)
- Supplier risk review (R155)
- Software update activities (R156)
- RXSWIN changes and integrity verification (R156)
- CSMS traceability summary (R155 §6.3–§7.3)

---

# 2. R155 — Cybersecurity Monitoring (§7.4)

## 2.1 Threat & Vulnerability Monitoring
Sources:
- CVE database
- Automotive ISAC
- Internal ECU/Gateway logs

Summary of findings:
- [New vulnerabilities]
- [Relevant CVEs]
- [Internal anomalies]

## 2.2 Vulnerability Assessment
| Vulnerability | Severity | Status | Notes |
|---------------|----------|--------|-------|
| Example CVE   | High     | Fixed  | Patched in v1.2 |

---

# 3. R155 — Cybersecurity Incidents (§7.4)

## 3.1 Incident Summary
- Total incidents detected:
- Critical incidents:
- Mitigated incidents:

## 3.2 Forensic Data Summary
Forensic logs stored under:

Attach relevant excerpts here.

---

# 4. R155 — Effectiveness of Mitigations (§7.4)

## 4.1 Mitigation Performance
| Mitigation | Status | Evidence |
|-----------|--------|----------|
| PGN Whitelist | Effective | main_ecu/sec_log.log |
| DoS Detection | Effective | attacker_node tests |
| State Machine Validation | Effective | state_model.c |

## 4.2 Required Improvements
[List improvements]

---

# 5. R155 — Risk Assessment Update (§7.2.2.2(f))
Attach updated file:

- New risks identified:
- Risks retired:
- Updated risk ratings:

---

# 6. R155 — Supplier Risk Review (§7.2.2.5)
Supplier-related risks documented in:

---

# 7. R155 — CSMS Changes (§6.9)
Document any changes to:
- Processes  
- Tools  
- Organization  
- Responsibilities  

---

# 8. R156 — Software Updates Performed (§7.4)

## 8.1 Update List
| Update ID | Version | Date | Status | Notes |
|-----------|---------|------|--------|-------|
| Example FW-2026-01 | v1.1.0 | 2026-02-10 | Applied | Security patch |

Attach update dossier:

---

# 9. CSMS Traceability Summary (§6.3–§7.3)

This section provides a summary of how the Firetruck Security Platform implements  
UNECE R155 requirements through its Cyber Security Management System (CSMS).

The full traceability matrix is included below.

---

# CSMS ↔ Codebase Traceability Matrix
(Automatically inserted by generate_report.sh)

---

# 10. R156 — RXSWIN Changes (§7.1.1.2)
Attach current RXSWIN:

List changes:
- ECU version changes  
- Hash changes  
- Configuration changes  

---

# 11. R156 — Update Integrity & Safety (§7.1.1.3)

## 11.1 Integrity Verification
- Hash verification: Passed/Failed  
- Signature verification: Passed/Failed  

Evidence:

## 11.2 Rollback Events
| Event | Date | Reason | Result |
|-------|------|--------|--------|
| None | — | — | — |

---

# 12. R156 — Configuration Before/After (§7.1.1.5)
Attach:

---

# 13. Declaration

I hereby confirm that:
- All cybersecurity incidents have been reported (R155).  
- All mitigations remain effective (R155).  
- All software updates were performed safely (R156).  
- All RXSWIN entries are accurate (R156).  
- All update integrity checks were performed (R156).  

Signature: ______________________  
Name: __________________________  
Date: __________________________

---

# Appendix A — Forensic Logs
(Automatically inserted by generate_report.sh)

---

# Appendix B — CSMS Snapshots
(Automatically inserted by generate_report.sh)

---

# Appendix C — RXSWIN
(Automatically inserted by generate_report.sh)

---

# Appendix D — CSMS Traceability Matrix
(Automatically inserted by generate_report.sh)

---

# Appendix E — Risk Register
(Automatically inserted by generate_report.sh)

---

# Appendix F — Supplier Risk Register
(Automatically inserted by generate_report.sh)

---

# Appendix G — Threat & Vulnerability Register
(Automatically inserted by generate_report.sh)


# Appendix A — Forensic Logs

```
Includes:
- Timestamp
- PGN
- SA
- Attack type
- Decision

## 3.3 Timely Mitigation (§7.2.2.3)
Critical vulnerabilities patched within 30 days.

## 3.4 Continual Monitoring (§7.2.2.4)
Monitoring applies to:
- Development vehicles
- Production vehicles
- Vehicles after registration

---

# 4. Supplier Management (§7.2.2.5)

Supplier risks documented in:




---

# 8. Cryptography (§7.3.8)

Updates protected using:
- SHA256 hashing
- RSA2048 signing

Documented in:
```


# Appendix B — CSMS Snapshots

```
csms_status_2026-03-24_12-53-15.json
monitoring_snapshot_2026-03-24_12-53-15.json
risk_snapshot_2026-03-24_12-53-15.json
testing_snapshot_2026-03-24_12-53-15.json
```


# Appendix C — RXSWIN

```json
{
  "version": "1.0.0",
  "components": {
    "main_ecu": {
      "version": "1.0.0",
      "hash": "SHA256:MAIN_ECU_HASH_PLACEHOLDER"
    },
    "gw_chassis": {
      "version": "1.0.0",
      "hash": "SHA256:GW_CHASSIS_HASH_PLACEHOLDER"
    },
    "gw_firecan": {
      "version": "1.0.0",
      "hash": "SHA256:GW_FIRECAN_HASH_PLACEHOLDER"
    },
    "gw_hmi": {
      "version": "1.0.0",
      "hash": "SHA256:GW_HMI_HASH_PLACEHOLDER"
    }
  }
}
```


# Appendix D — CSMS Traceability Matrix



# Appendix D - CSMS Traceability Matrix

# CSMS ↔ Codebase Traceability Matrix
Firetruck Security Platform 
UNECE R155 Compliance Mapping

| R155 Requirement | CSMS Process | Implementation in Code | Evidence / Logs / Docs |
|------------------|--------------|-------------------------|-------------------------|
| §7.2.2.1 – CSMS in place | CSMS_Scope.md | Entire architecture (main_ecu, gateways, OTA) | CSMS_Documentation_Index.md |
| §7.2.2.2(a) – Security processes defined | CSMS_Processes.md | process logic reflected in state_model.c, policy_engine.c | CSMS_Processes.md |
| §7.2.2.2(b) – Risk identification | Risk Assessment Procedure | attacker_node (DoS, spoofing), CAN flow analysis | Risk_Register.md, snapshots |
| §7.2.2.2(c) – Risk assessment & treatment | Risk Assessment Procedure | mitigations in gw_*_sec.c, state_model.c | risk_assessment.md |
| §7.2.2.2(d) – Risk verification | Verification Process | gateway filtering, state validation | security_monitor.log |
| §7.2.2.2(e) – Cybersecurity testing | Security Testing Process | attack_dos.c, attack_spoof.c | testing_snapshot.json |
| §7.2.2.2(f) – Keep risk assessment current | Lifecycle Update Process | update_simulator.c triggers reassessment | CSMS snapshots |
| §7.2.2.2(g) – Threat & vulnerability monitoring | Threat Monitoring Procedure | security_monitor_simulator.c | security_monitor.log |
| §7.2.2.2(h) – Forensic data | Forensic Logging Specification | sec_log.c, main_ecu logging | logs/security_monitor.log |
| §7.2.2.3 – Timely mitigation | Incident Response Plan | gateway blocking logic, state machine | incident_snapshot.json |
| §7.2.2.4(a) – Continual monitoring | Monitoring Procedure | monitoring simulator, runtime logs | monitoring_snapshot.json |
| §7.2.2.4(b) – Privacy‑compliant data | Logging Specification | no personal data collected | Forensic_Logging_Specification.md |
| §7.2.2.5 – Supplier dependency management | Supplier Cybersecurity Policy | subsystem boundaries (CAN driver, gateways, OTA) | Supplier_Risk_Register.md |
| §7.3.3 – Vehicle risk assessment | Risk Assessment Process | architecture-level threat model | risk_assessment.md |
| §7.3.4 – Mitigations implemented | Mitigation Mapping | gw_*_sec.c, state_model.c, policy_engine.c | mitigation_snapshot.json |
| §7.3.6 – Security testing | Testing Process | attacker_node tests | testing_snapshot.json |
| §7.3.7(a) – Attack detection | Detection Logic | gateway filtering, state validation | security_monitor.log |
| §7.3.7(b) – Monitoring support | Monitoring Process | security_monitor_simulator.c | monitoring_snapshot.json |
| §7.3.7(c) – Forensic capability | Forensic Logging | sec_log.c | logs/security_monitor.log |
| §7.3.8 – Cryptographic standards | Crypto Policy (if applicable) | (future OTA signing) | update_simulator.c |
| §6.3.1 – CSMS documentation submitted | Certificate Package | CSMS docs directory | CSMS_Documentation_Index.md |
| §6.3.2 – CSMS declaration | Declaration | declaration.md | declaration_signed.pdf |
| §6.4 – Initial assessment | Assessment Procedure | full repo + logs | evidence package |
| §6.7 – Certificate validity | Certificate Lifecycle | renewal plan | certificate_lifecycle.md |
| §6.9 – Change notification | Change Management | snapshots auto‑generated | CSMS/snapshots |
| §6.10 – Renewal | Renewal Procedure | updated CSMS docs | renewal_package/ |
| §6.11 – Expiry impact | Compliance Policy | monitoring ensures continuity | compliance_policy.md |


# Appendix E — Risk Register

# Risk Register
(Automatically updated during risk assessment)

Columns:
- Risk ID
- Description
- Threat Source
- Likelihood
- Impact
- Risk Level
- Mitigation
- Status


# Appendix F — Supplier Risk Register

# Supplier Risk Register

Columns:
- Supplier Component
- Dependency
- Risk Description
- Impact
- Mitigation
- Status


# Appendix G — Threat & Vulnerability Register

# Threat & Vulnerability Register

Columns:
- ID
- Source (CVE, ISAC, Logs)
- Description
- Affected Component
- Severity
- Required Action
- Status
