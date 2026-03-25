# Forensic Logging Specification

## 1. Log Sources
- main_ecu/sec_log.c
- gateway security modules
- security_monitor_simulator
- attacker_node outputs

## 2. Logged Data
- Timestamp
- PGN
- Source Address (SA)
- Attack type (spoofing, DoS, invalid state)
- Decision (blocked, allowed, mitigated)

## 3. Storage
- Primary log: logs/security_monitor.log
- ECU runtime logs: bin/logs/main_ecu.log

## 4. Retention
- Logs retained for minimum 3 years
- Snapshots retained for lifetime of vehicle type

## 5. Access Control
- Logs accessible only to authorized personnel
