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
