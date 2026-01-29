---
name: circuit-breaker
description: View and manage circuit breaker status. Use to check if implementation is blocked or to reset after failures.
---

# /circuit-breaker Command

Manage the circuit breaker that prevents infinite retry loops during implementation.

## Usage

```bash
/circuit-breaker              # Show current status
/circuit-breaker status       # Show current status
/circuit-breaker reset        # Reset to closed (ready) state
/circuit-breaker history      # Show recent failure history
```

## What is the Circuit Breaker?

The circuit breaker is a safety mechanism that:
- **CLOSES** when implementation succeeds (ready for new tasks)
- **OPENS** after 3 consecutive implementation failures (blocks new implementations)

When OPEN, the system refuses to start new implementations until you manually reset it. This prevents infinite retry loops and wasted tokens.

## States

| State | Meaning | Action |
|-------|---------|--------|
| **CLOSED** | Ready | Implementations can proceed |
| **OPEN** | Blocked | Must reset before continuing |

## When to Reset

**Reset only after**:
1. You've reviewed the failure logs
2. You understand why implementations failed
3. You've addressed the root cause (fixed code, clarified requirements, etc.)

**Do NOT reset if**:
- You haven't reviewed failures
- The same issue will cause another failure
- You're just trying to "force" it to work

## Implementation

**Check status**:
```bash
cat ~/.claude/.circuit-breaker-state
# Returns: "closed" or "open"
```

**Reset manually**:
```bash
echo "closed" > ~/.claude/.circuit-breaker-state
```

## Integration with Workflow

The circuit breaker is checked automatically:
1. Before `/implement` command
2. Before `@code-implementer` agent starts
3. Before `/workflow` enters implementation phase

If OPEN, you'll see:
```
Circuit breaker is OPEN after 3 failed attempts.
Review failures and run: /circuit-breaker reset
```

## Failure Tracking

Each failure is logged with:
- Timestamp
- Error message
- Files affected
- Retry count

Access logs at: `~/.claude/data/circuit-breaker-log.json`

## Best Practices

1. **Don't ignore the circuit breaker** - It's protecting you from wasted effort
2. **Always review failures** - Understand what went wrong
3. **Fix root causes** - Don't just retry the same thing
4. **Use smaller steps** - If complex tasks keep failing, break them down

## Troubleshooting

**"Circuit breaker won't reset"**:
- Check file permissions on `~/.claude/.circuit-breaker-state`
- Manually delete and recreate the file

**"State file missing"**:
- The file is created on first failure
- No file = CLOSED state (ready)

**"Implementations still failing after reset"**:
- The circuit breaker doesn't fix underlying issues
- Review your code, requirements, or approach
- Consider using `/plan` to create a clearer implementation plan

---

**Executing command...**

Read the circuit breaker state file at `~/.claude/.circuit-breaker-state` and report:
- Current state (CLOSED or OPEN)
- If OPEN, when it opened and failure count
- Recommendations based on state
