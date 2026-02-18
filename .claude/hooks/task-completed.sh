#!/usr/bin/env bash
# Agent Teams hook: Verify task output quality before allowing completion
# Exit 0 = allow completion, Exit 2 = block + stderr feedback

set -euo pipefail
INPUT=$(cat)
TASK_SUBJECT=$(echo "$INPUT" | jq -r '.task_subject // "unknown"' 2>/dev/null)

# Basic check: if task mentions "test" or "implement", verify tests exist
if echo "$TASK_SUBJECT" | grep -iqE "implement|build|create|add"; then
    # Check for recent test files
    RECENT_TESTS=$(find . -name "*test*" -o -name "*spec*" -newer /tmp/.task-start 2>/dev/null | head -1)
    if [ -z "$RECENT_TESTS" ]; then
        echo "Implementation task completed without tests. Add tests before marking complete." >&2
        exit 2
    fi
fi

exit 0
