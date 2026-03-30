# Verification Before Completion Rule
# @linked .claude/skills/verification-before-completion/skill.md

**Iron Law: NO COMPLETION CLAIMS WITHOUT FRESH VERIFICATION EVIDENCE.**

This rule applies to ALL agents across ALL tasks.

## Mandatory Verification Points

1. **Before claiming "tests pass"** -- Run the test command and READ the full output
2. **Before claiming "build succeeds"** -- Run the build command and READ the full output
3. **Before claiming "task complete"** -- Verify acceptance criteria with concrete evidence
4. **Before committing** -- Run tests and build, verify both pass
5. **Before claiming "no regressions"** -- Run the FULL test suite, compare test counts
6. **Before moving to next task** -- Verify current task has evidence of completion

## Forbidden Phrases (Without Evidence)

These phrases MUST be accompanied by verification output:
- "should work" / "should be fine"
- "probably fixed" / "likely resolved"
- "seems to be working"
- "looks good" / "that should do it"
- "I believe this is correct"

## The Gate

```
IDENTIFY what proves the claim -> RUN the command -> READ full output -> VERIFY it confirms -> ONLY THEN claim
```

Skip any step = lying, not verifying.

## Source

Adapted from obra/superpowers verification-before-completion pattern. Prevents hallucinated success claims across all agents.
