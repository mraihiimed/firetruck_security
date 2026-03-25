# Combined R155 + R156 Annual Compliance Report
Manufacturer: Firetruck Security Platform  
Vehicle Type: Firetruck Security Platform  
Reporting Period: __YEAR__  
Prepared by: __AUTHOR__  
Date: __DATE__

---

# 1. Executive Summary
Provide a high-level summary of:
- Cybersecurity posture (R155)
- Software update posture (R156)
- Major incidents
- Improvements implemented
- Risk trends

---

# 2. R155 — Cybersecurity Monitoring (§7.4)

## 2.1 Threat & Vulnerability Monitoring
Sources:
- CVE database
- Automotive ISAC
- Internal ECU/Gateway logs

Summary of findings:
- [List new vulnerabilities]
- [List relevant CVEs]
- [List internal anomalies]

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

# 9. R156 — RXSWIN Changes (§7.1.1.2)
Attach current RXSWIN:

List changes:
- ECU version changes  
- Hash changes  
- Configuration changes  

---

# 10. R156 — Update Integrity & Safety (§7.1.1.3)

## 10.1 Integrity Verification
- Hash verification: Passed/Failed  
- Signature verification: Passed/Failed  

Evidence:

## 10.2 Rollback Events
| Event | Date | Reason | Result |
|-------|------|--------|--------|
| None | — | — | — |

---

# 11. R156 — Configuration Before/After (§7.1.1.5)
Attach:

---

# 12. Declaration

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

