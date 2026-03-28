# ---------------------------------------------------------------------------
# Compiler settings
# ---------------------------------------------------------------------------
CC      = gcc
CFLAGS  = -Wall -Wextra -O2 -Iinclude -MMD -MP

# ---------------------------------------------------------------------------
# Directory structure (REAL structure)
# ---------------------------------------------------------------------------
CORE_DIR = core
SRC_DIR  = src
BIN_DIR  = bin

# Ensure bin directory exists
$(shell mkdir -p $(BIN_DIR))

# ---------------------------------------------------------------------------
# Source files
# ---------------------------------------------------------------------------
CORE_SRC = $(wildcard $(CORE_DIR)/*.c)
ECU_SRC  = $(wildcard $(SRC_DIR)/*.c)

# Remove monitor.c from generic ECU list
ECU_SRC_NO_MONITOR = $(filter-out $(SRC_DIR)/monitor.c,$(ECU_SRC))

# Object files
CORE_OBJ = $(CORE_SRC:$(CORE_DIR)/%.c=$(SRC_DIR)/%.o)
ECU_OBJ  = $(ECU_SRC_NO_MONITOR:$(SRC_DIR)/%.c=$(SRC_DIR)/%.o)
MONITOR_OBJ = $(SRC_DIR)/monitor.o

# ECU binaries (bin/engine_ecu, bin/brake_controller, etc.)
ECU_BINS = $(ECU_SRC_NO_MONITOR:$(SRC_DIR)/%.c=$(BIN_DIR)/%)
MONITOR_BIN = $(BIN_DIR)/monitor

# ---------------------------------------------------------------------------
# Default target
# ---------------------------------------------------------------------------
all: $(ECU_BINS) $(MONITOR_BIN)

# ---------------------------------------------------------------------------
# Build rule for monitor (needs ncurses)
# ---------------------------------------------------------------------------
$(MONITOR_BIN): $(CORE_OBJ) $(MONITOR_OBJ)
	$(CC) $(CFLAGS) -o $@ $^ -lncurses

# ---------------------------------------------------------------------------
# Generic build rule for all other ECUs
# ---------------------------------------------------------------------------
$(BIN_DIR)/%: $(CORE_OBJ) $(SRC_DIR)/%.o
	$(CC) $(CFLAGS) -o $@ $^

# ---------------------------------------------------------------------------
# Compilation rules
# ---------------------------------------------------------------------------
$(SRC_DIR)/%.o: $(CORE_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

$(SRC_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

# ---------------------------------------------------------------------------
# Auto-generated dependencies
# ---------------------------------------------------------------------------
-include $(SRC_DIR)/*.d

# ---------------------------------------------------------------------------
# Cleanup
# ---------------------------------------------------------------------------
clean:
	rm -f $(SRC_DIR)/*.o $(SRC_DIR)/*.d
	rm -rf $(BIN_DIR)

.PHONY: all clean
