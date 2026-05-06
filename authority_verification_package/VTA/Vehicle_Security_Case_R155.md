# R155 Cybersecurity Compliance Dossier
Firetruck Security Platform  
Manufacturer: [Your Organization]  
Project: Modular Automotive Cybersecurity Simulation  
Version: 1.0.0  

---

# 1. CSMS Scope (§7.2.2.1)

The manufacturer maintains a Cyber Security Management System (CSMS) covering:
- Development of ECUs, gateways, and communication modules
- Production and integration of software components
- Post‑production monitoring, updates, and incident response
- Decommissioning and end‑of‑life considerations

The CSMS applies to all components:
- main_ecu
- gw_chassis
- gw_firecan
- gw_hmi
- attacker_node (used for testing only)

---

# 2. Cybersecurity Processes (§7.2.2.2)

## 2.1 Security Processes Defined (§7.2.2.2(a))
Documented processes include:
- Secure development lifecycle
- Code review and static analysis
- Security testing and validation
- Release and update management
- Incident response workflow

## 2.2 Risk Identification (§7.2.2.2(b))
Risks identified using:
- Annex 5 Part A threat catalogue
- Internal threat modeling
- CAN bus attack vectors
- Gateway manipulation scenarios

## 2.3 Risk Assessment & Treatment (§7.2.2.2(c))
Each risk is evaluated based on:
- Severity
- Exposure
- Controllability

Mitigations include:
- PGN whitelist
- SA validation
- DoS detection
- State machine validation
- Logging & forensic data

## 2.4 Verification of Risk Treatment (§7.2.2.2(d))
Verification performed via:
- Unit tests
- Integration tests
- Attack simulations using security_monitor_simulator
- Log analysis

## 2.5 Cybersecurity Testing (§7.2.2.2(e))
Testing covers:
- Spoofing
- DoS
- Replay
- Sensor injection
- HMI manipulation
- Logging integrity

## 2.6 Keeping Risk Assessment Current (§7.2.2.2(f))
Risk assessment updated:
- After each software update
- After new vulnerabilities (CVE, ISAC)
- After incidents

---

# 3. Monitoring (§7.2.2.2(g–h), §7.2.2.3, §7.2.2.4)

## 3.1 Threat & Vulnerability Monitoring (§7.2.2.2(g))
Sources:
- CVE database
- Automotive ISAC
- Internal logs from gateways and main ECU

## 3.2 Forensic Data (§7.2.2.2(h))
Stored in:
