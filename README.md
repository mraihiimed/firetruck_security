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

If you want, I can next generate **ARCHITECTURE.md with diagrams + threat model (ISO 21434 style)** — that would make your project stand out strongly for jobs or audits.
```
