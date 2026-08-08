#!/usr/bin/env bash

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$PROJECT_ROOT"

echo "========================================"
echo " ESP32 BUILD"
echo "========================================"

docker compose run --rm esp32 \
    idf.py build

echo
echo "Build complete."
echo
echo "Firmware:"
find build -maxdepth 1 -name "*.bin" -print