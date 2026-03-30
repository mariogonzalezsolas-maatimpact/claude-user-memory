---
name: learn
description: Extract reusable patterns from the current session and save them to memory for future sessions.
---

# /learn

Analyze the current session and extract patterns worth preserving.

## When to Use

Run `/learn` when you've solved a non-trivial problem during a session.

## What to Extract

1. **Error Resolution Patterns** -- What error? Root cause? Fix? Reusable for similar errors?
2. **Debugging Techniques** -- Non-obvious steps, tool combinations, diagnostic patterns
3. **Workarounds** -- Library quirks, API limitations, version-specific fixes
4. **Project-Specific Patterns** -- Codebase conventions, architecture decisions, integration patterns

## What NOT to Extract

- Trivial fixes (typos, simple syntax errors)
- One-time issues (specific API outages, transient failures)
- Anything already documented in CLAUDE.md or existing rules
- General knowledge (things any developer would know)

## Process

### Step 1: Review Session

Scan the conversation for:
- Problems that took multiple attempts to solve
- Non-obvious solutions or workarounds
- Patterns that will save time in future sessions

### Step 2: Draft the Pattern

```markdown
---
name: [descriptive-name]
description: [one-line summary]
type: feedback
---

[Problem description]

**Why:** [Root cause or context]
**How to apply:** [When and how to use this pattern]

## Solution
[The technique/workaround/pattern]

## Example
[Code example if applicable]
```

### Step 3: Confirm with User

Present the drafted pattern and ask:
- Is this accurate?
- Is this worth saving?
- Any adjustments?

### Step 4: Save

Save to the project's auto-memory directory (the standard Claude Code memory path):
`~/.claude/projects/<project-hash>/memory/learned-[pattern-name].md`

Update the project's `MEMORY.md` index with a one-line pointer.

## Notes

- One pattern per file -- keep focused
- Use our memory system (not a separate skills/learned directory)
- Patterns should be actionable, not just informational
- Apply the "would this save 5+ minutes in a future session?" test

Adapted from affaan-m/everything-claude-code /learn command.
