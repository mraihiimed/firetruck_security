#!/bin/bash

echo "=== Running spoof attack ==="
bin/security_monitor spoof

echo
echo "=== Log output ==="
cat logs/security_monitor.log

echo
echo "=== Running spoof attack in --fresh mode ==="
bin/security_monitor spoof --fresh

echo
echo "=== Cleaning monitoring logs ==="
make monitor-clean
