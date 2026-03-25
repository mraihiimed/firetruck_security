# Update Dossier — FW-2026-03
Firetruck Security Platform  
UNECE R156 Compliance

## 1. Purpose
Security improvements and gateway filtering enhancements.

## 2. Summary of Changes
- Updated gateway filtering rules
- Improved DoS detection
- Updated HMI interface

## 3. Safety Impact (R156 §7.1.1.10)
- No safety-critical functions modified
- State machine unchanged
- Safe-state behavior validated

## 4. Functional Impact (R156 §7.1.1.9)
- HMI display updated
- Diagnostics temporarily unavailable during update

## 5. Compatibility (R156 §7.1.1.7)
Compatible with:
- main_ecu hardware rev 2
- gateway firmware v1.1+

## 6. Integrity & Authenticity (R156 §7.1.3.1)
- Hash verified: PASS
- Signature verified: PASS

## 7. Configuration Before/After
See: before_after_config.json

## 8. RXSWIN Before/After
See: rx_swin_before.json  
See: rx_swin_after.json

## 9. Logs
- integrity_check.log  
- update_log.json  
- rollback_log.json  

## 10. Rollback Status
No rollback required.

## 11. Target Vehicles
See: target_vehicle_list.json
