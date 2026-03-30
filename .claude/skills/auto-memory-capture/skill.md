---
name: auto-memory-capture
description: "Automatic memory capture during work sessions. Reminds Claude to save important decisions, failed approaches, and successful patterns to the memory system. Prevents knowledge loss between sessions."
auto_invoke: true
tags: [memory, capture, session, persistence, learning]
---

# Auto Memory Capture Skill

Ensures important session knowledge is captured to the memory system before it's lost to context compression or session end.

## When Claude Should Use This Skill

Claude will automatically invoke this skill when:
- A significant decision is made (architecture, technology choice, approach selection)
- An approach is tried and FAILS (critical to prevent retry in future sessions)
- A non-obvious solution is found after multiple attempts
- User provides project context that should persist (deadlines, constraints, stakeholders)
- Session is approaching context limits (compaction imminent)

**Do NOT invoke when:**
- Information is already in CLAUDE.md or existing memory files
- The observation is trivial (typos, simple syntax fixes)

**Boundary with error-learning skill**: error-learning captures CODE-LEVEL errors (test failures, build failures, circuit breaker events) to `memory/errors.md`. auto-memory-capture captures STRATEGIC decisions and APPROACH failures (technology choices, architecture dead-ends, failed integration attempts) to the persistent memory system. If a test fails, error-learning handles it. If an approach was tried and abandoned, auto-memory-capture handles it.

## What to Capture

### High Priority (capture immediately)
1. **Failed approaches** -- What was tried, exact error, why it failed. Format:
   ```
   FAIL: [approach] -- [exact error or reason]
   ```
   This is the MOST VALUABLE type of memory. Future sessions will blindly retry failed approaches without this.

2. **Architecture decisions** -- Why X was chosen over Y, constraints considered
3. **User corrections** -- When the user says "no, do it this way" -- save the preference
4. **Non-obvious solutions** -- Workarounds, library quirks, version-specific fixes

### Medium Priority (capture at natural breakpoints)
5. **Project constraints** -- Deadlines, compliance requirements, stakeholder preferences
6. **Integration discoveries** -- How systems connect, undocumented APIs, auth flows
7. **Performance findings** -- Bottlenecks identified, optimization approaches that worked

### Low Priority (capture if convenient)
8. **Useful commands** -- Non-obvious CLI commands or scripts that solved problems
9. **Configuration details** -- Environment-specific settings that took time to discover

## Capture Protocol

### Step 1: Identify the Observation

Ask: "Would a future session benefit from knowing this?"
- If YES: proceed to capture
- If NO: skip

### Step 2: Classify the Memory Type

| Observation | Memory Type | File Pattern |
|------------|-------------|--------------|
| User preference or correction | `feedback` | `feedback_[topic].md` |
| Project decision or constraint | `project` | `project_[topic].md` |
| User role or knowledge context | `user` | `user_[topic].md` |
| External resource location | `reference` | `reference_[topic].md` |
| Failed approach | `feedback` | `feedback_[what-failed].md` |

### Step 3: Write to Memory

Use the standard memory format:
```markdown
---
name: [descriptive name]
description: [one-line -- used for relevance matching]
type: [feedback|project|user|reference]
---

[Content]

**Why:** [context]
**How to apply:** [when this is relevant]
```

Save to: `~/.claude/projects/<project-hash>/memory/[filename].md`
Update: `MEMORY.md` index with one-line pointer.

### Step 4: "What Did NOT Work" Pattern

Adapted from claude-mem. When capturing failed approaches, use this structured format:

```markdown
---
name: failed-[approach-name]
description: [approach] failed because [reason] -- do not retry
type: feedback
---

FAIL: [What was attempted]
ERROR: [Exact error message or behavior]
REASON: [Root cause analysis]
CONTEXT: [When this was tried -- date, project state]

**Why:** Prevents future sessions from retrying this approach
**How to apply:** If considering [approach], check this memory first. The issue is [root cause] which has not been resolved.
```

## Integration with /save-session

When `/save-session` is invoked, auto-memory-capture ensures the "What Did NOT Work" section is populated with all failed approaches from the session, using the structured FAIL format.

## Quality Checklist

Before ending a significant work session:
- [ ] All failed approaches documented with exact errors
- [ ] Key architecture decisions saved to memory
- [ ] User corrections/preferences captured as feedback memories
- [ ] Non-obvious solutions saved for future reference
- [ ] MEMORY.md index updated with new entries
