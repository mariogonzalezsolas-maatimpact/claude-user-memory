# Code Quality Standards
# @linked .claude/rules/security-checklist.md

## File & Function Limits
- Functions: < 50 lines
- Files: < 800 lines (200-400 preferred)
- Nesting: max 4 levels (use early returns)
- No `console.log` or debug statements in production code

## Immutability
Create new objects, NEVER mutate existing ones. Use spread/copy patterns.

## Error Handling
- Handle errors explicitly at every level
- Provide user-friendly messages in UI, detailed context in server logs
- Never silently swallow errors

## Input Validation
- Validate ALL user input at system boundaries
- Use schema-based validation (Zod, Pydantic, etc.)
- Fail fast with clear error messages
- Never trust external data

## Review Severity Levels

| Level | Meaning | Action |
|-------|---------|--------|
| CRITICAL | Security vulnerability or data loss | BLOCK merge |
| HIGH | Bug or significant quality issue | Should fix before merge |
| MEDIUM | Maintainability concern | Consider fixing |
| LOW | Style or minor suggestion | Optional |

## Pre-Commit Checklist
- [ ] Code is readable and well-named
- [ ] Functions focused (< 50 lines)
- [ ] No deep nesting (> 4 levels)
- [ ] Errors handled explicitly
- [ ] No hardcoded secrets
- [ ] Tests exist for new functionality
- [ ] Coverage >= 80%

Adapted from affaan-m/everything-claude-code common rules.
