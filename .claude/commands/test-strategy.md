---
name: test-strategy
description: Quick command to invoke testing-engineer for test architecture design, coverage analysis, mocking strategy, flaky test fixing, and TDD coaching.
---

# /test-strategy Command

Perform test strategy design or review using the testing-engineer agent.

## Usage

```
/test-strategy [focus area]
```

## What This Does

1. Invokes `@testing-engineer` with your scope
2. Assesses current test architecture and coverage
3. Designs test pyramid (unit/integration/e2e balance)
4. Defines mocking strategy
5. Identifies coverage gaps in critical paths
6. Fixes flaky tests (if applicable)
7. Delivers Testing Report with score (0-100)

## Examples

```
/test-strategy coverage improvement for the auth module
/test-strategy fix flaky tests in CI
/test-strategy test architecture for the new payment feature
/test-strategy mocking strategy for external API calls
```

## Output

You'll receive a Testing Report including:
- Testing Score (0-100) with breakdown
- Test distribution (pyramid analysis)
- Coverage by area with gaps highlighted
- Mocking strategy recommendations
- Flaky test analysis and fixes
- Test naming and organization review
- Prioritized test additions

## Next Steps

After `/test-strategy` completes:
1. Write missing tests (critical paths first)
2. Fix flaky tests
3. Use `@code-implementer` for TDD implementation
4. Set up coverage gates in CI

## Time

Typical completion: **< 5 minutes**

---

**Executing command...**

Please invoke: `@testing-engineer {args}`
