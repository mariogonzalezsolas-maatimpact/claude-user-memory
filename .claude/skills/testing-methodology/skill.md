---
name: testing-methodology
description: Systematic methodology for test strategy design. Guides test pyramid construction, coverage analysis, mock strategy, flaky test prevention, and TDD coaching. Claude invokes this when test architecture decisions are needed.
auto_invoke: true
tags: [testing, tdd, coverage, mocking, quality]
---

# Testing Methodology Skill

This skill provides a systematic methodology for designing effective test strategies. It ensures tests are written at the right level, cover the right scenarios, and remain fast and reliable.

## When Claude Should Use This Skill

Claude will automatically invoke this skill when:
- `/do` routes to TESTING
- User explicitly invokes `/test-strategy [topic]`
- @testing-engineer agent is spawned
- Task requires test architecture, coverage improvement, or flaky test fixing

**Do NOT invoke when:**
- Task is pure code implementation with existing tests (use code-implementer)
- Task is security testing (use security-auditor)
- Task is performance testing only (use brahma-optimizer)

## Core Principles

1. **Test behavior, not implementation** - Tests should survive refactoring
2. **Fast tests run often** - Unit tests < 10s, full suite < 5min target
3. **Flaky tests are worse than no tests** - Fix or delete, never ignore
4. **Test at the right level** - Don't e2e what a unit test can catch
5. **Tests are documentation** - A well-named test explains the requirement

## Testing Strategy Protocol

### Step 1: Assessment (< 1 minute)

**Evaluate current state**:
1. **Framework inventory** - Test runner, assertion lib, mocking tools
2. **Coverage analysis** - Line, branch, function percentages
3. **Test distribution** - Count by level (unit/integration/e2e)
4. **Execution time** - Total suite, slowest tests
5. **Flaky tests** - Known intermittent failures
6. **Gaps** - Untested critical paths

### Step 2: Test Pyramid Design (< 1 minute)

```
          /   E2E   \        3-5 tests (critical flows only)
         / Integr.   \      10-20 tests (API, DB, services)
        /    Unit      \    50-200 tests (logic, utils, transforms)
       /________________\
```

**Per feature, decide level**:
| What to Test | Level | Why |
|-------------|-------|-----|
| Pure logic, utils, transforms | Unit | Fast, isolated, focused |
| API endpoints, DB queries | Integration | Tests real boundaries |
| Auth flow, checkout, signup | E2E | Tests full user journey |
| Error messages, validation | Unit | Quick feedback |
| Third-party integrations | Integration (mocked) | Controlled, reliable |

### Step 3: Test Naming Convention

**Format**: `[unit]_[scenario]_[expected]`

```
calculateTotal_withDiscount_returnsDiscountedPrice
login_withInvalidPassword_returns401
createUser_withDuplicateEmail_throwsConflictError
```

**Arrange-Act-Assert (AAA)**:
```
// Arrange: set up data and dependencies
// Act: execute the function under test
// Assert: verify the outcome
```

### Step 4: Mocking Strategy

**Mock rules**:
| What | Mock? | How |
|------|-------|-----|
| External APIs | Yes | MSW, nock, or manual stub |
| Database | Depends | Testcontainers for integration, mock for unit |
| Time/dates | Yes | Fake timers (jest.useFakeTimers) |
| File system | Yes | memfs or mock |
| Internal modules | Rarely | Prefer real implementation |
| The unit under test | Never | That's what we're testing |

**Anti-patterns**:
- Over-mocking: If you mock everything, you test nothing
- Implementation mocking: Don't assert internal method calls
- Snapshot abuse: Snapshots are for UI, not business logic

### Step 5: Coverage Targets

**Recommended targets**:
| Area | Target | Priority |
|------|--------|----------|
| Auth, payments, data mutations | 100% | Must-have |
| Business logic, services | 80%+ | Must-have |
| API endpoints | 80%+ | Must-have |
| UI components (critical) | 70%+ | Should-have |
| Utilities, helpers | 90%+ | Should-have |
| Config, setup | 50%+ | Nice-to-have |

**Coverage ≠ quality**:
- 100% coverage with bad assertions is worthless
- Specific assertions > broad snapshot matches
- Branch coverage matters more than line coverage

### Step 6: Flaky Test Prevention

**Common causes and fixes**:
| Cause | Fix |
|-------|-----|
| Timing/setTimeout | Use fake timers or waitFor |
| Shared state | Reset state in beforeEach |
| Test order dependency | Each test is independent |
| Network calls | Mock with MSW, never hit real APIs |
| File system | Use temp dirs, clean up in afterEach |
| Random data | Use seeded generators or deterministic data |

**Flaky test policy**:
1. Detect: Track tests that fail intermittently in CI
2. Quarantine: Skip flaky tests immediately (don't block CI)
3. Fix: Root cause within 1 sprint
4. Delete: If can't be fixed in 2 sprints, delete and rewrite

## Quality Assurance

Before delivering test strategy:
- [ ] Test distribution follows pyramid (more unit than integration than e2e)
- [ ] Critical paths have 100% coverage
- [ ] Mocking strategy defined (what to mock, what to keep real)
- [ ] No flaky patterns introduced (timing, shared state, order)
- [ ] Test naming is consistent and descriptive
- [ ] Execution time meets targets (unit < 30s, integration < 2min)
- [ ] Coverage targets set per area

## Performance Targets

- **Assessment time**: < 2 minutes
- **Strategy delivery**: < 3 minutes
- **Unit test execution**: < 30 seconds
- **Full suite**: < 5 minutes (target)

---

**This skill ensures test strategies are systematic, tests are written at the right level, and the test suite remains fast, reliable, and maintainable.**
