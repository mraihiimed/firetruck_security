# SUMS Identification
Firetruck Security Platform

## 1. Software Identification Requirements
UNECE R156 §7.1.1.2 requires:
- Unique identification of software versions
- Integrity validation data
- Traceability to vehicle type

## 2. Identification Mechanisms
The Firetruck Security Platform uses:
- Version strings (e.g., v1.2.3)
- Build hashes
- RXSWIN entries
- ECU-specific identifiers

## 3. Identification Sources
- update_simulator.c (version metadata)
- rx_swin.json (canonical version register)
- before_after_config.json (configuration deltas)
