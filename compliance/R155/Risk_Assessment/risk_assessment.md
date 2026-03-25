# Vehicle Cybersecurity Risk Assessment

## Methodology (§7.3.3)
- Based on Annex 5 Part A threats
- Includes internal/external interfaces
- Includes interactions between ECUs and gateways

## Identified Risks
1. Spoofing of speed frames (PGN 0xFEF1)
2. DoS on gateway interfaces
3. Manipulation of HMI commands
4. Injection of FireCAN sensor data
5. Replay of valid frames
6. Unauthorized OTA updates
7. Compromised supplier components

## Risk Treatment (§7.3.4)
- PGN whitelist
- SA validation
- DoS detection
- State machine validation
- Logging & forensic data
- Cryptographic signing for updates

## Verification (§7.2.2.2(d))
- Unit tests
- Integration tests
- Attack simulations
