---
name: review
description: Multi-perspective code review using parallel subagents. Spawns 3-5 reviewers examining security, performance, complexity, and correctness simultaneously.
---

# /review Command

Multi-perspective code review inspired by the Compound Engineering pattern.

## Usage

```
/review [scope - file, directory, PR, or feature area]
```

## What This Does

Spawns **parallel subagents**, each reviewing from a different quality dimension:

1. **Security Reviewer** (`@security-auditor`) - Injection, auth flaws, data exposure, OWASP patterns
2. **Performance Reviewer** (`@brahma-optimizer`) - N+1 queries, memory leaks, unnecessary computation, caching opportunities
3. **Architecture Reviewer** (`@brahma-analyzer`) - Over-engineering, SOLID violations, coupling, DRY, naming
4. **UX/A11y Reviewer** (`@ux-accessibility-reviewer`) - Only for UI code: WCAG, keyboard nav, contrast (skipped for backend-only)

Each reviewer works independently with a focused scope, then results are synthesized.

## Examples

```
/review src/auth/
/review the changes in the last 3 commits
/review PR #42
/review the new payment integration
```

## Output

### Review Summary

| Dimension | Score | Critical | Warnings |
|-----------|-------|----------|----------|
| Security | X/100 | N | N |
| Performance | X/100 | N | N |
| Architecture | X/100 | N | N |
| UX/A11y | X/100 | N | N |
| **Overall** | **X/100** | **N** | **N** |

### Findings (prioritized by severity)
- Critical findings requiring immediate fix
- High-priority improvements
- Medium suggestions
- Low-priority polish

### Compound Learning
Patterns and decisions extracted for `knowledge-core.md` update.

## Execution Strategy

**For small scope** (1-3 files): Run 2 reviewers sequentially (security + architecture)
**For medium scope** (4-10 files): Run 3 reviewers in parallel
**For large scope** (10+ files or full PR): Run all 4 reviewers in parallel

## Time

| Scope | Reviewers | Duration |
|-------|-----------|----------|
| Small | 2 sequential | 3-5 min |
| Medium | 3 parallel | 5-8 min |
| Large | 4 parallel | 8-15 min |

---

**Executing command...**

Analyze the scope to determine how many reviewers to spawn:

1. **Identify files in scope** (from args, git diff, or directory listing)
2. **Classify scope size** (small/medium/large)
3. **Detect if UI code is present** (to include UX reviewer)
4. **Spawn appropriate reviewers in parallel** using Task tool with matching subagent_types
5. **Synthesize results** into unified review report with prioritized findings
6. **Extract compound learnings** for knowledge preservation

For each reviewer, provide:
- The exact files to review
- The specific quality dimension to focus on
- The output format (findings list with severity)

Synthesize all reviewer outputs into the summary table format above.
