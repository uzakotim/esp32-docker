#!/usr/bin/env bash

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$PROJECT_ROOT"

PORT="${1:-}"

if [[ -z "$PORT" ]]; then
    echo "ERROR: No serial port specified."
    echo
    echo "Usage:"
    echo "  ./scripts/flash.sh /dev/cu.usbserial-140"
    echo
    echo "Available serial ports:"
    ls /dev/cu.* 2>/dev/null || true
    exit 1
fi

if [[ ! -e "$PORT" ]]; then
    echo "ERROR: Serial port does not exist:"
    echo "  $PORT"
    echo
    echo "Available serial ports:"
    ls /dev/cu.* 2>/dev/null || true
    exit 1
fi

if [[ ! -f ".venv/bin/python" ]]; then
    echo "ERROR: Flash environment does not exist."
    echo
    echo "Create it with:"
    echo
    echo "  python3 -m venv .venv"
    echo "  .flash-venv/bin/python -m pip install esptool"
    exit 1
fi

if [[ ! -f "build/flash_project_args" ]]; then
    echo "ERROR: No build/flash_project_args found."
    echo
    echo "Build the project first:"
    echo
    echo "  ./scripts/build.sh"
    exit 1
fi

echo "========================================"
echo " ESP32 FLASH"
echo "========================================"
echo
echo "Port: $PORT"
echo

echo "Checking ESP32 connection..."

.venv/bin/python -m esptool \
    --port "$PORT" \
    chip_id

echo
echo "Flashing firmware..."
echo

(
    cd build

    ../.venv/bin/python -m esptool \
        --port "$PORT" \
        write-flash \
        @flash_project_args
)

echo
echo "========================================"
echo " FLASH SUCCESSFUL"
echo "========================================"