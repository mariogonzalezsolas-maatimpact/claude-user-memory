---
name: resume-session
description: Load a saved session file and resume work with full context from where the last session ended.
---

# /resume-session

Load the last saved session and orient fully before doing any work. Counterpart to `/save-session`.

## Usage

```
/resume-session                    # loads most recent session file
/resume-session 2026-03-30         # loads session for specific date
/resume-session path/to/file.md    # loads specific file
```

## Process

### Step 1: Find the Session File

If no argument:
1. Check `.claude/session-data/` in current project
2. Pick the most recently modified `*-session.md` file
3. If not found: "No session files found. Run `/save-session` to create one."

If argument is a date (YYYY-MM-DD): search for files matching that date.
If argument is a path: read that file directly.

### Step 2: Read the Entire File

Read the complete session file. Do not summarize yet.

### Step 3: Present Briefing

```
SESSION LOADED: [path to file]
========================================================

PROJECT: [project name / topic]

WHAT WE'RE BUILDING:
[2-3 sentence summary]

CURRENT STATE:
- Working: [count] items confirmed
- In Progress: [list]
- Not Started: [list]

WHAT NOT TO RETRY:
- [failed approach] -- [reason]
- [failed approach] -- [reason]

BLOCKERS / OPEN QUESTIONS:
[list any]

NEXT STEP:
[exact next step from session file]

========================================================
Ready to continue. What would you like to do?
```

### Step 4: Wait for User

Do NOT start working automatically. Do NOT touch any files. Wait for the user to direct next steps.

## Edge Cases

- **Multiple sessions for same date**: Load most recently modified
- **Referenced files no longer exist**: Note in briefing as WARNING
- **Session > 7 days old**: Warn about staleness, proceed normally
- **Empty/malformed file**: Report and suggest creating new one with `/save-session`

## Rules

- NEVER modify the session file -- it is a read-only historical record
- Always show "What Not To Retry" even if empty ("None") -- too important to skip
- After resuming, suggest `/save-session` at end of new session

Adapted from affaan-m/everything-claude-code /resume-session command.
