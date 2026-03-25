#!/bin/bash

echo "[1] Killing old processes..."
pkill main_ecu 2>/dev/null

echo "[2] Freeing UDP port 20000..."
sudo fuser -k 20000/udp 2>/dev/null

echo "[3] Starting main_ecu..."
cd ~/firetruck_security/bin
./main_ecu &

sleep 1

echo "[4] Checking if log file exists..."
LOG=~/firetruck_security/logs/main_ecu.log

if [ -f "$LOG" ]; then
    echo "[OK] Log file created:"
    echo "--------------------------------"
    cat "$LOG"
    echo "--------------------------------"
else
    echo "[ERROR] main_ecu.log was NOT created."
    echo "Reason: main_ecu did NOT start (bind failed)."
fi
