# CSMS Core Processes

## 1. Risk Identification Process
Inputs:
- CAN message flows
- Security mechanisms (policy engine, state model)
- Attack simulations (DoS, spoofing)
- Forensic logs

Activities:
- Identify assets and attack surfaces
- Identify threats using Annex 5, CVE feeds, ISAC, internal logs
- Identify vulnerabilities in ECUs, gateways, OTA subsystem

Outputs:
- Risk Register

## 2. Risk Assessment & Treatment
Activities:
- Score risks (likelihood × impact)
- Map risks to mitigations implemented in code
- Define acceptance criteria
- Document treatment decisions

Outputs:
- Updated risk_assessment.md

## 3. Cybersecurity Testing Process
Test sources:
- attacker_node (DoS, spoofing)
- security_monitor_simulator
- gateway filtering logic
- state machine validation

Outputs:
- Security testing reports
- CSMS snapshots

## 4. Verification Process
Activities:
- Validate mitigations remain effective
- Compare expected vs. actual behavior
- Confirm logs capture required forensic data
- Re‑verify after updates

Outputs:
- Verification reports
