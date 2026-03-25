# CSMS Evidence Index
Firetruck Security Platform  
UNECE R155 – CSMS Assessment Support

This index lists the evidence available to support the CSMS assessment by the Technical Service / Approval Authority.

## 1. Core CSMS Documentation

- CSMS_Scope.md  
  - Scope of vehicle types, lifecycle phases, and organizational boundaries.

- CSMS_Processes.md  
  - Description of risk, testing, verification, monitoring, and supplier processes.

- Threat_Monitoring_Procedure.md  
  - Threat and vulnerability monitoring sources and activities.

- Forensic_Logging_Specification.md  
  - Log sources, content, retention, and access control.

- Incident_Response_Plan.md  
  - Detection, triage, containment, mitigation, and documentation of incidents.

- Supplier_Cybersecurity_Policy.md  
  - Supplier identification, requirements, risk assessment, and monitoring.

## 2. Traceability and Requirement Coverage

- CSMS_Traceability_Matrix.md  
  - Mapping of UNECE R155 requirements to:
    - CSMS processes
    - Code implementation
    - Evidence (logs, snapshots, documents)

## 3. Risk and Threat Management

- Risk_Register.md  
  - List of identified risks, ratings, mitigations, and status.

- Threat_Vulnerability_Register.md  
  - List of threats and vulnerabilities (CVE, ISAC, internal findings).

- Supplier_Risk_Register.md  
  - Supplier-related risks and mitigations.

## 4. Technical Evidence (Implementation & Effectiveness)

- Logs:
  - logs/security_monitor.log  
  - bin/logs/main_ecu.log  

- Snapshots:
  - compliance/R155/CSMS/snapshots/*  
    - risk assessment snapshots  
    - monitoring snapshots  
    - incident snapshots  
    - testing snapshots  

- Code (selected examples):
  - main_ecu/sec_log.c  
  - main_ecu/state_model.c  
  - main_ecu/policy_engine.c  
  - gw_*/gw_*_sec.c  
  - attacker_node/attack_dos.c  
  - attacker_node/attack_spoof.c  
  - tools/security_monitor_simulator.c  

## 5. Reporting and Lifecycle

- Annual R155 Report:
  - compliance/reports/report_YYYY.md  
  - Includes:
    - monitoring results
    - incidents
    - effectiveness of mitigations
    - risk updates
    - supplier risk review
    - CSMS traceability summary
    - appendices (logs, snapshots, registers)

- CSMS snapshots:
  - Evidence of continuous operation and updates of the CSMS.

## 6. Link to SUMS (R156)

- R156 documentation and RXSWIN:
  - compliance/R156/*  
  - Demonstrates linkage between CSMS and SUMS for OTA-related risks.
