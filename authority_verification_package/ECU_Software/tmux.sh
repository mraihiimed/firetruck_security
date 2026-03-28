#!/bin/bash

BASE_DIR="$HOME/firetruck_security/authority_verification_package/ECU_Software/bin"
SESSION="cvhsm"

echo "[INFO] Starting C‑V‑HSM‑CAN test environment..."
echo "[INFO] Using binaries from: $BASE_DIR"

# Ensure tmux session does not already exist
tmux has-session -t $SESSION 2>/dev/null
if [ $? -eq 0 ]; then
    echo "[WARN] Session '$SESSION' already exists. Attaching instead."
    tmux attach -t $SESSION
    exit 0
fi

# Start tmux session with bus server
tmux new-session -d -s $SESSION "$BASE_DIR/bus_server"
sleep 0.3

# Monitor
tmux new-window -t $SESSION "$BASE_DIR/monitor"
sleep 0.3

# Steering sensor
tmux new-window -t $SESSION "$BASE_DIR/steering_sensor"
sleep 0.2

# Steering controller
tmux new-window -t $SESSION "$BASE_DIR/steering_controller"
sleep 0.2

# Brake controller
tmux new-window -t $SESSION "$BASE_DIR/brake_controller"
sleep 0.2

# Engine ECU
tmux new-window -t $SESSION "$BASE_DIR/engine_ecu"
sleep 0.2

# Autonomous controller
tmux new-window -t $SESSION "$BASE_DIR/autonomous_controller"
sleep 0.2

echo ""
echo "[INFO] All ECUs started in tmux session '$SESSION'."
echo "[INFO] Attach with: tmux attach -t $SESSION"
echo ""
