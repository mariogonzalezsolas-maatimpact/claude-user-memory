#!/usr/bin/env bash
# Agent Teams hook: Prevent premature teammate idle
# Exit 0 = allow idle, Exit 2 = block idle + stderr feedback

set -euo pipefail

# Guard: jq is required for JSON parsing
if ! command -v jq &>/dev/null; then
    exit 0
fi

INPUT=$(cat 2>/dev/null || echo "{}")
TEAMMATE=$(echo "$INPUT" | jq -r '.teammate_name // "unknown"' 2>/dev/null)

# Check if there are still pending tasks
PENDING=$(echo "$INPUT" | jq -r '.pending_tasks // 0' 2>/dev/null)
if [ "$PENDING" -gt 0 ]; then
    echo "You still have $PENDING pending tasks. Check the task list and claim the next one." >&2
    exit 2
fi

exit 0
