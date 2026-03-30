---
name: save-session
description: Save current session state for later resumption. Captures what was built, what worked, what failed, and exact next steps.
---

# /save-session

Capture everything from this session so the next one can pick up exactly where this one left off.

## When to Use

- Before ending a work session
- Before hitting context limits
- After solving a complex problem worth preserving
- Before handing off to another person

## Process

### Step 1: Gather Context

Review the session:
- What files were modified? (`git status`, `git diff --stat`)
- What was the goal? What was accomplished?
- What errors occurred? What approaches failed?
- Current test/build status?

### Step 2: Create Session File

```bash
mkdir -p .claude/session-data
```

**File**: `.claude/session-data/YYYY-MM-DD-<short-description>-session.md`

Example: `.claude/session-data/2026-03-30-auth-middleware-session.md`

### Step 3: Write All Sections

Fill out EVERY section. If nothing to report, write "None" -- never skip a section.

```markdown
# Session: [Brief Title]

**Date**: [YYYY-MM-DD]
**Duration**: [approximate]
**Goal**: [1-2 sentences]

## What We Built
[1-3 paragraphs with full context. A new session reading this should understand exactly what problem is being solved and why.]

## What WORKED (Confirmed)
Only list things confirmed working with evidence:
- [Feature X]: tests pass (12/12)
- [Endpoint Y]: verified via curl, returns expected response
- [Component Z]: renders correctly, no console errors

Do NOT list "probably works" or "should work" -- only verified items.

## What Did NOT Work
**[MOST IMPORTANT SECTION]**

List every approach tried and failed, with the EXACT reason:

- FAIL: [approach] -- [exact error or reason]
- FAIL: [approach] -- [exact error or reason]

Future sessions will blindly retry these without this information. This prevents wasted effort.

## What Has NOT Been Tried Yet
Promising approaches that haven't been attempted:
- [Approach]: [why it might work]

## Current State of Files

| File | Status | Notes |
|------|--------|-------|
| `path/to/file` | PASS / In Progress / FAIL | brief note |

## Decisions Made
Architecture choices, tradeoffs accepted, approaches chosen. Prevents future sessions from re-litigating settled decisions.

## Blockers & Open Questions
Anything unresolved that needs investigation or a decision.

## Exact Next Step
The single most important thing to do when resuming. Be specific:
- Which file to open
- What to write or change
- What to test
```

### Step 4: Show and Confirm

Display the complete file and ask the user to confirm before saving.

## Rules

- Each session gets its own file -- never append to existing session files
- Write for Claude's audience (the next session will read this via `/resume-session`)
- Evidence-based: apply verification-before-completion to all "WORKED" claims
- "What Did NOT Work" is the most valuable section -- be thorough

Adapted from affaan-m/everything-claude-code /save-session command.
