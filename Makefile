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
     $(BIN)/hmi_ecu

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

clean:
	rm -rf $(BIN)
