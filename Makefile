CC = gcc
CFLAGS = -Wall -O2 -Icommon

BIN = bin

COMMON = common/can_drv.c \
         common/proto_internal.c \
         common/security_common.c

# --- Attacker Node ---
ATTACKER_SRC = attacker_node/main.c \
               attacker_node/attack_spoof.c \
               attacker_node/attack_dos.c

# --- Main ECU ---
MAIN_ECU_SRC = main_ecu/main.c \
               main_ecu/policy_engine.c \
               main_ecu/state_model.c \
               main_ecu/sec_log.c

# --- Chassis Gateway ---
GW_CHASSIS_SRC = gw_chassis/main.c \
                 gw_chassis/gw_chassis_if.c \
                 gw_chassis/gw_chassis_sec.c

# --- FireCAN Gateway ---
GW_FIRECAN_SRC = gw_firecan/main.c \
                 gw_firecan/gw_firecan_if.c \
                 gw_firecan/gw_firecan_sec.c \
                 gw_firecan/routing.c

# --- HMI Gateway ---
GW_HMI_SRC = gw_hmi/main.c \
             gw_hmi/gw_hmi_if.c \
             gw_hmi/gw_hmi_sec.c

# --- HMI ECU ---
HMI_ECU_SRC = hmi_ecu/main.c \
              hmi_ecu/hmi_cmd.c

# --- Build all ---
all: $(BIN)/attacker_node \
     $(BIN)/main_ecu \
     $(BIN)/gw_chassis \
     $(BIN)/gw_firecan \
     $(BIN)/gw_hmi \
     $(BIN)/hmi_ecu \
     $(BIN)/security_monitor

$(BIN):
	mkdir -p $(BIN)

$(BIN)/attacker_node: $(COMMON) $(ATTACKER_SRC) | $(BIN)
	$(CC) $(CFLAGS) -o $@ $^

$(BIN)/main_ecu: $(COMMON) $(MAIN_ECU_SRC) | $(BIN)
	$(CC) $(CFLAGS) -o $@ $^

$(BIN)/gw_chassis: $(COMMON) $(GW_CHASSIS_SRC) | $(BIN)
	$(CC) $(CFLAGS) -o $@ $^

$(BIN)/gw_firecan: $(COMMON) $(GW_FIRECAN_SRC) | $(BIN)
	$(CC) $(CFLAGS) -o $@ $^

$(BIN)/gw_hmi: $(COMMON) $(GW_HMI_SRC) | $(BIN)
	$(CC) $(CFLAGS) -o $@ $^

$(BIN)/hmi_ecu: $(COMMON) $(HMI_ECU_SRC) | $(BIN)
	$(CC) $(CFLAGS) -o $@ $^

# --- Security Monitor Simulator ---
SEC_MON_SRC = tools/security_monitor_simulator.c

$(BIN)/security_monitor: $(SEC_MON_SRC) | $(BIN)
	$(CC) $(CFLAGS) -o $@ $^


clean:
	rm -rf $(BIN)

# ============================================================
# Authority Verification Package (AVP)
# ============================================================

AVP_SCRIPT := ./generate_authority_verification_package.sh

.PHONY: avp
avp:
	@echo "Generating Authority Verification Package..."
	@$(AVP_SCRIPT)
	@echo "Done. Package available in ./authority_verification_package"

# ============================================================
# Monitoring Utilities
# ============================================================

.PHONY: monitor-clean
monitor-clean:
	@echo "Cleaning monitoring logs and snapshots..."
	@rm -f logs/security_monitor.log
	@rm -f compliance/R155/CSMS/snapshots/monitoring_auto.json
	@echo "# Firetruck Security Platform — Security Monitoring Log" > logs/security_monitor.log
	@echo "Monitoring cleaned."

# ============================================================
# Authority Verification Package (AVP)
# ============================================================

AVP_SCRIPT := ./generate_authority_verification_package.sh
AVP_DIR := authority_verification_package
AVP_ZIP := authority_verification_package.zip

.PHONY: avp
avp:
	@echo "Generating Authority Verification Package..."
	@$(AVP_SCRIPT)
	@echo "Done. Package available in ./$(AVP_DIR)"

# ------------------------------------------------------------
# Create a ZIP archive of the AVP
# ------------------------------------------------------------
.PHONY: avp-zip
avp-zip: avp
	@echo "Zipping Authority Verification Package..."
	@rm -f $(AVP_ZIP)
	@zip -r $(AVP_ZIP) $(AVP_DIR) >/dev/null
	@echo "Created $(AVP_ZIP)"

# ------------------------------------------------------------
# Remove AVP directory and ZIP
# ------------------------------------------------------------
.PHONY: avp-clean
avp-clean:
	@echo "Cleaning Authority Verification Package..."
	@rm -rf $(AVP_DIR) $(AVP_ZIP)
	@echo "AVP cleaned."

# ------------------------------------------------------------
# Validate that required evidence files exist
# ------------------------------------------------------------
.PHONY: avp-validate
avp-validate:
	@echo "Validating evidence files..."
	@missing=0; \
    for f in \
        compliance/R155/CSMS/certificate_package/CSMS_Declaration.md \
        compliance/R155/CSMS/CSMS_Traceability_Matrix.md \
        compliance/R155/CSMS/Risk_Register.md \
        compliance/R156/SUMS/SUMS_Declaration.md \
        compliance/R156/RXSWIN/rx_swin.json \
        compliance/R156/dossiers/FW-2026-03/update_dossier.md \
        compliance/R156/dossiers/FW-2026-03/before_after_config.json \
        compliance/R156/dossiers/FW-2026-03/update_log.json \
        logs/security_monitor.log; \
    do \
        if [ ! -f $$f ]; then \
            echo "MISSING: $$f"; \
            missing=1; \
        fi; \
    done; \
    if [ $$missing -eq 0 ]; then \
        echo "All required evidence files are present."; \
    else \
        echo "Some evidence files are missing."; \
    fi

# ------------------------------------------------------------
# Auto-detect latest update ID (future-proof)
# ------------------------------------------------------------
.PHONY: avp-latest
avp-latest:
	@echo "Detecting latest update ID..."
	@latest=$$(ls -1 compliance/R156/dossiers | sort | tail -n 1); \
	echo "Latest update ID: $$latest"; \
	echo "Rebuilding AVP for $$latest..."; \
	UPDATE_ID=$$latest $(AVP_SCRIPT)
