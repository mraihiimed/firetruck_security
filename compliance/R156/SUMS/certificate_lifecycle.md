# Certificate Lifecycle Management – SUMS  
**Date:** 2026‑03‑24

## 1. Overview
Defines how update signing certificates are issued, rotated, revoked, and archived.

## 2. Certificate Types
- OEM Root Certificate  
- Update Signing Certificate  
- ECU Provisioning Certificate  

## 3. Lifecycle Stages
1. **Issuance** – Generated in secure HSM  
2. **Activation** – Distributed to signing pipeline  
3. **Rotation** – Every 12 months or after compromise  
4. **Revocation** – Via CRL distributed in OTA metadata  
5. **Archival** – Retained for 10 years  

## 4. Evidence
- renewal_package/  
- update_signing.md  
