#!/usr/bin/env bash

set -euo pipefail

PORT="${1:-}"

if [[ -z "$PORT" ]]; then
    echo "Usage:"
    echo
    echo "  ./scripts/monitor.sh /dev/cu.usbserial-140"
    exit 1
fi

if [[ ! -e "$PORT" ]]; then
    echo "ERROR: Port does not exist:"
    echo "  $PORT"
    exit 1
fi

if [[ ! -f ".venv/bin/python" ]]; then
    echo "ERROR: Virtual environment not found."
    exit 1
fi

.venv/bin/python -m serial.tools.miniterm \
    "$PORT" \
    115200