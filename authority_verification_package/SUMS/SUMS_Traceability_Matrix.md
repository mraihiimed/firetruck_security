# SUMS Traceability Matrix  
Firetruck Security Platform  
UNECE R156 – Software Update Management System

This matrix maps UNECE R156 requirements to the implementation and evidence in the Firetruck Security Platform.

| R156 Requirement | Implementation | Evidence |
|------------------|---------------|----------|
| §7.1.1.1 – Update Identification | Versioning in update_dossier.md | update_dossier.md |
| §7.1.1.2 – RXSWIN Management | RXSWIN_Management.md | rx_swin.json |
| §7.1.1.3 – Integrity Verification | RSA2048 + SHA256 signing | update_signing.md, integrity_check.log |
| §7.1.1.4 – Update Delivery | update_simulator.c | update_log.json |
| §7.1.1.5 – Configuration Before/After | before_after_config.json | before_after_config.json |
| §7.1.1.6 – Rollback Handling | rollback.md | rollback_log.json |
| §7.1.1.7 – Update Records | SUMS_Records_and_Retention.md | dossiers/FW-2026-03/* |
| §7.1.2 – Update Process | SUMS_Overview.md | SUMS_Documentation_Index.md |
| §7.2 – Organizational Requirements | SUMS_Identification.md | SUMS_Declaration.md |

This matrix is included in the Authority Verification Package.
