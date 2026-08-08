#!/usr/bin/env bash

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$PROJECT_ROOT"

echo "========================================"
echo " ESP32 SCHEDULER TEST"
echo "========================================"
echo

echo "[1/2] Building test application..."
echo

docker compose run --rm esp32 \
    idf.py build

echo
echo "[2/2] Test build completed."
echo
echo "NOTE: Target tests require an ESP32 connected."
echo