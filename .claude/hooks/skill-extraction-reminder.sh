#!/usr/bin/env bash
# UserPromptSubmit hook: Claudeception-style skill extraction reminder
# Injects a reminder for Claude to evaluate whether the current work
# produced extractable, reusable knowledge worth preserving as a skill.
# Exit 0 = always pass (informational injection)

set +e
INPUT=$(cat 2>/dev/null || echo "{}")

# Only inject reminder every ~5 prompts to avoid noise
# Use a counter file to track
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
COUNTER_FILE="$PROJECT_DIR/.claude/.skill-extraction-counter"

# Ensure directory exists
mkdir -p "$(dirname "$COUNTER_FILE")" 2>/dev/null || true

COUNT=0
if [ -f "$COUNTER_FILE" ]; then
    COUNT=$(cat "$COUNTER_FILE" 2>/dev/null || echo "0")
fi
COUNT=$((COUNT + 1))
echo "$COUNT" > "$COUNTER_FILE" 2>/dev/null || true

# Only inject on every 5th prompt
if [ $((COUNT % 5)) -ne 0 ]; then
    exit 0
fi

cat << 'REMINDER'
[Skill Extraction Check] Evaluate whether recent work produced extractable knowledge:
- Did this require actual investigation (not just docs lookup)?
- Is the solution reusable for similar future tasks?
- Are there clear activation conditions (specific error, pattern, scenario)?
- Has the solution been tested and confirmed working?
If ALL criteria met: capture as a pattern in knowledge-core.md with: trigger, solution, verification steps.
REMINDER

exit 0
