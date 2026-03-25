# RXSWIN Management
Firetruck Security Platform

## 1. Purpose
RXSWIN provides a unique, traceable record of:
- ECU software versions
- Configuration data
- Integrity metadata

## 2. RXSWIN Structure
Stored in:


Contains:
- ECU name
- Version
- Hash
- Timestamp
- Update ID

## 3. Update Rules
- RXSWIN is updated after every successful OTA update.
- Downgrades are rejected.
- RXSWIN is write-protected except via SUMS.

## 4. Auditability
- RXSWIN snapshots are stored for each update.
- RXSWIN is included in the annual R156 report.
