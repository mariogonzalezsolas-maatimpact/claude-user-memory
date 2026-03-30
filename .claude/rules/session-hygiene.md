# Session Hygiene Rule

## Failed Approaches Must Be Documented

When an approach is tried and fails during a session, it MUST be noted. Future sessions and agents will otherwise blindly retry the same failed approach, wasting time and tokens.

**Format**: `FAIL: [approach] -- [exact error or reason]`

## Memory Before Compaction

If context is about to be compressed (approaching token limits), save critical session state first:
- Failed approaches (highest priority)
- Decisions made
- Current progress state

## Don't Re-Litigate Settled Decisions

Before proposing an alternative approach, check memory for previous decisions on the same topic. If a decision was already made with clear rationale, respect it unless new information changes the calculus.

## Evidence-Based Memory

Only save to memory what is CONFIRMED:
- A failed approach must have been actually attempted (not hypothetical)
- A working solution must have been verified (tests pass, build succeeds)
- A user preference must have been explicitly stated (not inferred)

Adapted from thedotmack/claude-mem session management concepts.

## Related
- Use `/save-session` for structured session state capture
- Use `/resume-session` to restore session context
- Use `auto-memory-capture` skill for persistent cross-session memory
