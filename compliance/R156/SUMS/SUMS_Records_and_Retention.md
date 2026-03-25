# SUMS Records and Retention
Firetruck Security Platform

## 1. Required Records (R156 §7.1.2)
The following records are retained:
- Update dossiers
- RXSWIN snapshots
- Update logs
- Rollback logs
- Configuration before/after
- Target vehicle lists
- Integrity check results

## 2. Retention Period
Records are retained for:
- The lifetime of the vehicle type approval
- Minimum 3 years after end of production

## 3. Storage Locations
- compliance/R156/update_history.json
- compliance/R156/RXSWIN/rx_swin.json
- compliance/R156/dossiers/*
- logs/update_log.json
- logs/rollback_log.json

## 4. Audit Access
Records are:
- Exportable on request
- Included in annual R156 report
- Linked to CSMS evidence (R155)
