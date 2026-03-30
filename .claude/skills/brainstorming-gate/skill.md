---
name: brainstorming-gate
description: "Mandatory design-approval phase before code implementation. Explores context, asks clarifying questions one at a time, proposes 2-3 approaches, writes spec doc to docs/specs/, gets user approval before proceeding. Auto-invoked for FEATURE and ORCHESTRATE routes."
auto_invoke: true
tags: [design, brainstorming, spec, approval, planning]
---

# Brainstorming Gate Skill

Enforces a mandatory design-approval phase BEFORE any implementation begins. Every feature goes through structured brainstorming to prevent premature coding.

## When Claude Should Use This Skill

Claude will automatically invoke this skill when:
- `/do` routes to FEATURE or ORCHESTRATE
- `/workflow` is invoked for a new feature
- User explicitly requests design/brainstorming phase

**Do NOT invoke when:**
- Route is not FEATURE or ORCHESTRATE (other routes skip brainstorming)
- User opts out: "skip design", "no brainstorm", "just code it", "sin diseno"
- A spec document already exists for this feature in `docs/specs/`
- Route is a fix iteration (iteration > 1 in pyramid loop)
- Task is a bug fix, refactor, or test-only change

## Core Principle

**"This Is Too Simple To Need A Design" is ALWAYS wrong.** Every feature benefits from 5 minutes of structured thinking before coding. The brainstorming gate prevents the #1 cause of rework: jumping to code before understanding the problem.

## Brainstorming Protocol

### Phase 1: Context Exploration (< 2 min)

1. **Read relevant files** -- Understand existing codebase patterns
2. **Identify integration points** -- Where does this feature connect?
3. **Check for existing similar features** -- Can we extend rather than build?
4. **Review constraints** -- Performance, security, compatibility requirements

### Phase 2: Clarifying Questions (< 3 min)

Ask questions **one at a time**, not as a batch. Each question should be:
- Specific and answerable
- Multiple-choice when possible (reduce cognitive load)
- Ordered by impact (most important first)

**Question format:**
```
Before I design this, I need to clarify one thing:

[Question]

Options:
A) [Option with brief explanation]
B) [Option with brief explanation]
C) [Something else -- please describe]
```

**Max 3-4 questions.** If you need more, the requirements are too vague -- suggest the user write a brief description first.

### Phase 3: Design Proposals (< 3 min)

Present 2-3 approaches:

```
## Design Proposals

### Approach A: [Name]
- **How**: [2-3 sentences]
- **Pros**: [key advantages]
- **Cons**: [key disadvantages]
- **Effort**: [Small / Medium / Large]

### Approach B: [Name]
- **How**: [2-3 sentences]
- **Pros**: [key advantages]
- **Cons**: [key disadvantages]
- **Effort**: [Small / Medium / Large]

**Recommendation**: Approach [X] because [1-line reason].

Which approach? (A / B / modify)
```

### Phase 4: Design Presentation

After user selects approach, present the full design:

```
## Design: [Feature Name]

**Approach**: [Selected approach name]

### Components
- [Component 1]: [purpose, 1 line]
- [Component 2]: [purpose, 1 line]

### File Changes
- `path/to/file1`: [what changes]
- `path/to/file2`: [new file, purpose]

### Data Flow
[Brief description of how data moves through the system]

### Edge Cases
- [Edge case 1]: [how handled]
- [Edge case 2]: [how handled]

### Out of Scope
- [What this design intentionally does NOT include]

Approve this design? (yes / modify / start over)
```

### Phase 5: Spec Document

After user approves, write a spec document:

**File**: `docs/specs/[feature-name].md`

```markdown
# Spec: [Feature Name]

**Date**: [YYYY-MM-DD]
**Status**: Approved
**Approach**: [Selected approach]

## Summary
[2-3 sentences]

## Design Decisions
- [Decision 1]: [rationale]

## Components
[From Phase 4]

## File Changes
[From Phase 4]

## Edge Cases
[From Phase 4]

## Out of Scope
[From Phase 4]

## Acceptance Criteria
- [ ] [Criterion 1]
- [ ] [Criterion 2]
```

### Phase 6: Spec Self-Review

Before handing to plan-coordinator, self-review:

1. **Placeholder scan** -- No `[TBD]`, `[TODO]`, or `[PLACEHOLDER]` remaining
2. **Internal consistency** -- Components match file changes match data flow
3. **Scope check** -- Spec doesn't exceed what user asked for (YAGNI)
4. **Ambiguity check** -- No vague language ("might", "could", "possibly")

Fix any issues before proceeding.

## Integration with Pyramid Orchestration

```
/do [FEATURE request]
  -> Step 1: CLASSIFY (route = FEATURE)
  -> Step 1.5: BRAINSTORMING GATE (this skill)
     -> Context exploration
     -> Clarifying questions (one at a time)
     -> Design proposals (2-3 options)
     -> User approves design
     -> Spec document written to docs/specs/
  -> Step 2: PLAN (pyramid plan with spec reference)
  -> Step 3: CONFIRM
  -> Step 4: EXECUTE PYRAMID
     -> plan-coordinator receives spec as additional context
     -> code-coordinator implements per spec
     -> review-coordinator checks against spec
```

## Design Principles

- **Isolation and clarity** -- Break into units with clear, single purpose
- **Design for testability** -- Every component independently testable
- **Minimal surface area** -- Expose only what's needed
- **Extension over modification** -- Prefer adding new files over changing existing
- **YAGNI ruthlessly** -- Remove unnecessary features from all designs

## Quality Checklist

Before exiting the brainstorming gate:
- [ ] User approved the design
- [ ] Spec document written to `docs/specs/[feature].md`
- [ ] Spec passes self-review (no placeholders, consistent, scoped, unambiguous)
- [ ] All clarifying questions answered
- [ ] Edge cases documented
- [ ] Out-of-scope items listed
