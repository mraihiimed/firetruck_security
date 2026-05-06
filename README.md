# 🚒 Firetruck Security Platform  
### Modular Automotive Cybersecurity Simulation (Main ECU + Gateways + Attacker Node)

This project simulates the electronic architecture of a firetruck with segmented CAN buses, secure gateways, a central Main ECU, and an attacker node.  
It is designed as a **teaching, research, and audit platform** for automotive cybersecurity.

The entire implementation is written in **C**, modular, lightweight, and fully reproducible.

---

## 📦 Features

- **Segmented CAN Bus Architecture**
  - Chassis Network
  - FireCAN Network
  - HMI Network  

- **Three Secure Gateways**
  - PGN Whitelisting
  - Source Address (SA) Validation
  - DoS Detection  

- **Main ECU**
  - State Machine (PTO, Pump, Mast)
  - Policy Engine
  - Security Logging  

- **Attacker Node**
  - Spoofing Attacks
  - Denial-of-Service (DoS)
  - Replay Attacks  

- **Virtual CAN Driver (UDP-based)**  
- **Audit-ready Logging System**

---

## 🧩 System Architecture

```

```
    [Attacker Node]
           |
           v
    ┌────────────────┐
    │  GW_CHASSIS    │ → Speed, RPM, Fuel
    └────────────────┘
           |
           v
    ┌────────────────┐
    │   MAIN ECU     │ ← HMI Commands
    └────────────────┘
           ^
           |
    ┌────────────────┐
    │    GW_HMI      │ → PTO, Pump, Mast
    └────────────────┘

    ┌────────────────┐
    │  GW_FIRECAN    │ → Pump Pressure, Water Level, Foam Level
    └────────────────┘
```

````

Each gateway includes:

- Security Filtering Module  
- Routing Logic  
- Dedicated UDP-based CAN Driver  

---

## 🛠️ Build

```bash
make
````

### Output binaries:

```
bin/attacker_node
bin/main_ecu
bin/gw_chassis
bin/gw_firecan
bin/gw_hmi
```

---

## ▶️ Running the Simulation

### 1. Start Main ECU

```bash
./bin/main_ecu
```

### 2. Start Gateways (each in a separate terminal)

```bash
./bin/gw_chassis
./bin/gw_firecan
./bin/gw_hmi
```

### 3. Start Attacker Node

```bash
./bin/attacker_node
```

---

## 📡 Baseline Traffic (Normal Operation)

Before launching attacks, logs should look like:

```
[SEC] State update from frame: PGN=0x00FEF1 SA=0x11 LEN=8
[ECU] From SA=0x11 (Chassis Gateway)
[ECU] Vehicle speed = 0.00 km/h (raw=0)
[ECU] Received frame: PGN=0xFEF1, len=8, data=00 00 00 00 00 00 00 00
```

This confirms:

* Correct routing
* Security filters allow valid frames
* State machine processes data correctly

---

## 🔐 Security Features

### ✔ PGN Whitelisting

Each gateway accepts only predefined PGNs.

### ✔ Source Address (SA) Validation

Example:

* Chassis SA → `0x11`
* FireCAN SA → `0x61`
* HMI SA → `0x21`

### ✔ DoS Detection

Burst protection:

* 20 frames within 5 ms → blocked

### ✔ Security Logging

All decisions are logged:

```
[SEC] DoS detected: PGN=0xFEF1 SA=0x11
[SEC] Frame blocked by policy
```

---

## 🧪 Attack Scenarios

### Spoofing Attack

```bash
./bin/attacker_node spoof
```

### Denial-of-Service (DoS)

```bash
./bin/attacker_node dos
```

### Replay Attack

```bash
./bin/attacker_node replay
```

---

## 🧠 Main ECU State Machine

The Main ECU manages:

* PTO (Power Take-Off)
* Pump System
* Mast Control

All states are:

* Integer-based
* Little-endian encoded
* Designed for auditability

---

## 📁 Project Structure

```
firetruck_security/
│
├── attacker_node/
├── common/
├── gw_chassis/
├── gw_firecan/
├── gw_hmi/
├── main_ecu/
└── Makefile
```

---

## 📝 License

This project is intended for:

* Education
* Research
* Automotive cybersecurity demonstrations

---

## 🚀 Next Steps (Optional Enhancements)

To further professionalize your repository, you can add:

* `ARCHITECTURE.md` (deep system design)
* `CONTRIBUTING.md` (collaboration guidelines)
* `CHANGELOG.md` (version tracking)
* Visual diagrams (PNG/SVG)

---
---

## 🔄 OTA Update System (Secure Firmware Delivery)

This project includes a **secure OTA (Over-The-Air) update pipeline**, inspired by real automotive update systems.

---

### 📦 OTA Pipeline Overview

Each release follows a structured pipeline:

```text
Build binaries
→ Generate firmware images (.img)
→ Compute SHA256 hashes
→ Generate metadata.json
→ Sign metadata (GPG)
→ Publish via OTA server (NGINX + API)
```

---

### 📁 OTA Directory Structure

```
ota/
├── campaigns/
│   └── 2026-05-06/
│       ├── main_ecu-<version>.img
│       ├── gw_chassis-<version>.img
│       ├── gw_firecan-<version>.img
│       ├── media-<version>.img
│       ├── security_monitor-<version>.img
│       ├── metadata.json
│       └── metadata.json.asc
│
└── latest.json
```

---

### 🔐 OTA Security Model

The system implements a **3-layer trust architecture**:

#### 1. Integrity Layer

Each firmware image includes:

```json
"sha256": "<hash>"
```

Used to detect corruption or tampering.

---

#### 2. Authenticity Layer (GPG)

The release metadata is signed:

```bash
gpg --detach-sign --armor metadata.json
```

This generates:

```
metadata.json.asc
```

👉 Ensures the update comes from a trusted source.

---

#### 3. Deployment Manifest

`metadata.json` defines:

* firmware files
* SHA256 hashes
* download URLs
* versioning

Example:

```json
{
  "version": "2026.05.06.1730",
  "campaign_id": "2026-05-06",
  "components": {
    "main_ecu": {
      "file": "main_ecu-2026.05.06.1730.img",
      "sha256": "...",
      "url": "https://ota.geeksolution.ovh/campaigns/2026-05-06/main_ecu-..."
    }
  }
}
```

---

### 🌐 OTA API Endpoints

The OTA backend exposes:

```
GET /api/campaign/latest
GET /api/campaign/<campaign_id>
```

Example:

```bash
curl https://ota.geeksolution.ovh/api/campaign/latest
```

Response:

```json
{
  "active_campaign": "2026-05-06"
}
```

---

### 🚀 Creating a New OTA Release

Run:

```bash
./tools/release_ota.sh
```

This will:

* generate firmware images
* compute hashes
* build metadata.json
* sign metadata
* update latest.json

---

### ⚠️ Important Security Notes

* GPG signing must NOT be executed as root
* Private keys are stored per-user (`~/.gnupg`)
* `gpg-agent` is used to securely cache passphrases
* Metadata MUST NOT be modified after signing

---

### 🧠 OTA Design Principles

This system follows key automotive OTA principles:

* separation of build and signing (recommended)
* signed manifest as trust anchor
* deterministic versioning
* campaign-based deployment

---

### 🚗 Future OTA Improvements

* ECU-side signature verification (C implementation)
* A/B partition rollback system
* delta updates (bandwidth optimization)
* CI/CD-based signing pipeline
* fleet management dashboard

---

# 🔥 Reviewer verdict

After this addition, your project becomes:

| Before          | After                      |
| --------------- | -------------------------- |
| CAN simulator   | Full OTA security platform |
| local execution | distributed update system  |
| basic security  | layered trust model        |

---
---

## ✍️ Maintainer Signature

Project maintained and developed by:

**IMR** 
Firetruck Security Platform – OTA & Embedded Systems Lab 
Date: 2026-05-06

---

> “Security is not a feature — it is a system property.”
