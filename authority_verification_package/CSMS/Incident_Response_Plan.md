# Incident Response Plan

## 1. Detection
Incidents detected via:
- security_monitor.log
- gateway filtering events
- state machine violations
- attacker_node simulations

## 2. Triage
Incidents classified as:
- Low (non‑critical anomalies)
- Medium (suspicious behavior)
- High (confirmed attack attempt)

## 3. Containment
Actions:
- Block malicious PGNs
- Enforce safe state transitions
- Trigger alerts in monitoring system

## 4. Mitigation
- Apply patches via OTA subsystem
- Update gateway rules
- Adjust state machine logic

## 5. Documentation
All incidents documented in:
- CSMS Incident Register
- Annual R155 report
