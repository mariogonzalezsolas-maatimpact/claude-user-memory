#!/usr/bin/env bash
# validate-implementation.sh
# Quality gate: Validates implementation output (tests pass + circuit breaker closed)
# Exit 0 = pass, Exit 2 = block (Claude Code convention)
# Wired as SubagentStop hook for code-implementer in settings.json

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

SCORE=0
DEFECTS=()
CIRCUIT_FILE="$HOME/.claude/.circuit-breaker-state"

echo "Validating Implementation..."

# === CHECK 1: Circuit breaker state ===
if [ -f "$CIRCUIT_FILE" ]; then
    # Check if any agent has 3+ failures
    MAX_COUNT=$(grep -oE '[0-9]+' "$CIRCUIT_FILE" 2>/dev/null | sort -rn | head -1)
    if [ "${MAX_COUNT:-0}" -ge 3 ]; then
        echo -e "${RED}BLOCK: Circuit breaker is OPEN (${MAX_COUNT} consecutive failures)${NC}"
        echo "   Run: /circuit-breaker reset"
        exit 2
    fi
    echo -e "${GREEN}Circuit breaker: CLOSED${NC}"
else
    echo "Circuit breaker: No state file (assuming CLOSED)"
fi

# === CHECK 2: Detect project test runner ===
TEST_CMD=""
PROJECT_DIR="."

if [ -f "$PROJECT_DIR/package.json" ]; then
    if grep -q '"test"' "$PROJECT_DIR/package.json" 2>/dev/null; then
        TEST_CMD="npm test"
    fi
elif [ -f "$PROJECT_DIR/Cargo.toml" ]; then
    TEST_CMD="cargo test"
elif [ -f "$PROJECT_DIR/go.mod" ]; then
    TEST_CMD="go test ./..."
elif [ -f "$PROJECT_DIR/pyproject.toml" ] || [ -f "$PROJECT_DIR/setup.py" ] || [ -f "$PROJECT_DIR/pytest.ini" ]; then
    TEST_CMD="python -m pytest"
elif [ -f "$PROJECT_DIR/Makefile" ] && grep -q "^test:" "$PROJECT_DIR/Makefile" 2>/dev/null; then
    TEST_CMD="make test"
fi

# === CHECK 3: Run tests if runner detected ===
if [ -n "$TEST_CMD" ]; then
    echo "Running tests: $TEST_CMD"
    TEST_OUTPUT=$(eval "$TEST_CMD" 2>&1) && TEST_EXIT=0 || TEST_EXIT=$?

    if [ "$TEST_EXIT" -eq 0 ]; then
        echo -e "${GREEN}Tests: PASS${NC}"
    else
        echo -e "${RED}BLOCK: Tests FAILED (exit code: $TEST_EXIT)${NC}"
        # Show last 20 lines of test output for debugging
        echo "--- Test output (last 20 lines) ---"
        echo "$TEST_OUTPUT" | tail -20
        echo "---"
        exit 2
    fi
else
    echo -e "${YELLOW}No test runner detected (skipping test verification)${NC}"
    echo "   Supported: package.json, Cargo.toml, go.mod, pyproject.toml, Makefile"
fi

# === CHECK 4: Verify git changes exist ===
if command -v git &>/dev/null && git rev-parse --git-dir &>/dev/null; then
    CHANGED_FILES=$(git diff --name-only HEAD 2>/dev/null | wc -l)
    STAGED_FILES=$(git diff --cached --name-only 2>/dev/null | wc -l)
    TOTAL=$((CHANGED_FILES + STAGED_FILES))

    if [ "$TOTAL" -eq 0 ]; then
        echo -e "${YELLOW}Warning: No git changes detected after implementation${NC}"
    else
        echo "Git changes: $TOTAL file(s) modified"
    fi
fi

echo ""
echo -e "${GREEN}Implementation validation PASSED${NC}"
exit 0
