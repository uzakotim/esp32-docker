#!/usr/bin/env bash

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$PROJECT_ROOT"

PORT="${1:-}"

if [[ -z "$PORT" ]]; then
    echo "Usage:"
    echo
    echo "  ./scripts/deploy.sh /dev/cu.usbserial-140"
    echo
    echo "Available serial ports:"
    ls /dev/cu.* 2>/dev/null || true
    exit 1
fi

echo "========================================"
echo " ESP32 DEPLOY"
echo "========================================"

echo
echo "[1/3] Building..."
./scripts/build.sh

echo
echo "[2/3] Flashing..."
./scripts/flash.sh "$PORT"

echo
echo "[3/3] Starting serial monitor..."
echo
echo "Press Ctrl-] to exit the monitor."
echo

./scripts/monitor.sh "$PORT"