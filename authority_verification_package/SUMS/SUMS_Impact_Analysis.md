# SUMS Impact Analysis
Firetruck Security Platform

## 1. Purpose
To ensure updates do not negatively affect:
- Safety systems
- Cybersecurity posture
- Type approval compliance
- Functional behavior

## 2. Impact Analysis Inputs
- Update metadata
- ECU configuration before/after
- Function change list
- Safety-critical dependencies
- Risk assessment (R155 linkage)

## 3. Impact Analysis Outputs
- before_after_config.json
- update_dossier.md
- safety_impact_report.md
- functional_change_list.md

## 4. Decision Criteria
An update is approved only if:
- Integrity checks pass
- Safety impact is acceptable
- No type approval impact is detected
- No new cybersecurity risks are introduced
