---
name: pyramid-loop
description: Manages code-producing routes with two modes — Full Pyramid (plan-coordinator -> code-coordinator -> review-coordinator with fix loop) for FEATURE/IMPLEMENT/MIGRATE/ORCHESTRATE, and Lightweight (@programmer direct) for REFACTOR/TEST/DEBUG/OPTIMIZE/CODE/DATABASE/TECH_DEBT. Auto-invoked by /do.
auto_invoke: true
tags: [orchestration, pyramid, loop, quality, lightweight]
---

# Pyramid Loop Skill

This skill manages code-producing routes with two execution modes:

- **Full Pyramid**: 3-coordinator chain (plan -> code -> review) with fix loop (max 3 iterations)
- **Lightweight**: Direct dispatch to @programmer with a simpler plan -> implement -> done flow

## When Claude Should Use This Skill

Claude will automatically invoke this skill when:
- `/do` classifies a route that involves code changes
- `/workflow` is invoked
- Any task requires planning + coding

**Do NOT invoke when:**
- Route is SIMPLE (direct answer)
- Route is RESEARCH or PLAN only (no code changes)
- Route is a review-only command (SECURITY, SEO, UX, etc.)
- Route is CONTEXT (utility command)
- User explicitly opts out: "simple", "sequential", "sin equipo", "no pyramid", "directo"

## Route Classification

### Full Pyramid Routes
**FEATURE, IMPLEMENT, MIGRATE, ORCHESTRATE**

These routes use the full 3-coordinator chain with fix loop:
- @plan-coordinator -> @code-coordinator -> @review-coordinator
- Fix loop: max 3 iterations if review fails
- Quality gates: Plan (85+), Tests pass, Review (80+)

### Lightweight Routes
**REFACTOR, TEST, DEBUG, OPTIMIZE, CODE, DATABASE, TECH_DEBT**

These routes dispatch directly to @programmer:
- Plan (brief) -> @programmer implements -> done
- No coordinator chain, no fix loop
- Quality gate: Tests pass

### Upgrade to Full Pyramid

If the user adds **"con review"** or **"with review"** to a Lightweight route, upgrade it to the Full Pyramid flow. Examples:
- `/do refactor auth module, con review` -> Full Pyramid
- `/do fix login bug, with review` -> Full Pyramid
- `/do optimize queries` -> Lightweight (default)

## Lightweight Protocol

For Lightweight routes (REFACTOR, TEST, DEBUG, OPTIMIZE, CODE, DATABASE, TECH_DEBT):

```
1. Analyze the task and create a brief plan (inline, no coordinator)
2. Dispatch to @programmer with task + context + plan
3. Read @programmer report -> verify tests pass
4. IF tests pass: DONE -> synthesize final report
5. IF tests fail: @programmer self-corrects (up to 3 retries via circuit breaker)
```

### Dispatch to @programmer (Lightweight)
```
You are the programmer for this task.

TASK: {user_request}
ROUTE: {route} (Lightweight)

CONTEXT:
- Project: {project_name}
- Type: {project_type}
- Key files: {relevant_files}
- Conventions: {coding_conventions}
- Constraints: {user_constraints}

PLAN:
{brief_plan}

Implement with TDD discipline. Run tests and verify they pass.
Report back with your Agent Report format.
```

### Lightweight Final Report

```markdown
## Lightweight Execution Complete

**Task**: {original_request}
**Route**: {route} (Lightweight)
**Executor**: @programmer

### Changes Made
{file list from @programmer}

### Test Results
| Tests written | Tests passing | Build |
|{N}|{N/N}|{PASS}|

### Commit
- Hash: {hash}
- Rollback: `git revert {hash}`
```

## Full Pyramid Protocol

For Full Pyramid routes (FEATURE, IMPLEMENT, MIGRATE, ORCHESTRATE):

### The Pyramid Sequence

```
ITERATION 1:
  1. Spawn @plan-coordinator with task + context
  2. Read plan report -> verify score >= 85
  3. Spawn @code-coordinator with plan
  4. Read code report -> verify tests pass
  5. Spawn @review-coordinator with changes + plan
  6. Read review report -> check verdict

IF review PASSES: DONE -> synthesize final report
IF review FAILS (iteration < 3):
  7. Extract fix request from review report
  8. Spawn @plan-coordinator with fix request
  9. GOTO step 3 (code -> review again)

IF review FAILS (iteration = 3):
  10. ESCALATE to user with full context
```

### Coordinator Dispatch Templates

#### Dispatch to Plan Coordinator (New Task)
```
You are the plan-coordinator for this task.

TASK: {user_request}

CONTEXT:
- Project: {project_name}
- Type: {project_type}
- Key files: {relevant_files}
- Conventions: {coding_conventions}
- Constraints: {user_constraints}

ITERATION: {N}

Create a complete implementation plan following your Planning Protocol.
Report back with your Plan Coordinator Report format.
```

#### Dispatch to Plan Coordinator (Fix Request)
```
You are the plan-coordinator. The review-coordinator found issues that need fixing.

FIX REQUEST from review-coordinator:

ISSUES FOUND:
{review_findings}

FILES AFFECTED:
{file_list}

ORIGINAL PLAN REFERENCE:
{original_plan_summary}

ITERATION: {N}

Create a targeted fix plan that addresses ALL reviewer issues.
Include regression tests for each issue.
Report back with your Plan Coordinator Report format.
```

#### Dispatch to Code Coordinator
```
You are the code-coordinator. Implement the following plan.

IMPLEMENTATION PLAN from plan-coordinator:
{full_plan}

CONTEXT:
- Project: {project_name}
- Conventions: {coding_conventions}
- Iteration: {N}
{if_fix: "FOCUS: This is a fix iteration. Address the specific issues listed in the plan."}

Execute with TDD discipline. Report back with your Code Coordinator Report format.
```

#### Dispatch to Review Coordinator
```
You are the review-coordinator. Review the implementation.

REVIEW REQUEST:
CHANGES: {changed_files_list}
PLAN: {original_plan_summary}
COMMIT: {git_hash}
PROJECT TYPE: {project_type}
ITERATION: {N}
{if_iteration_gt_1: "PREVIOUS ISSUES: Focus primarily on these issues from the last review: {previous_findings}"}

Perform full review (code + browser if applicable).
Report back with your Review Coordinator Report format.
```

### State Tracking

Track across iterations:
```
pyramid_state = {
  task: "original user request",
  iteration: 1,          # 1-3
  plan_score: null,       # from plan-coordinator
  tests_pass: null,       # from code-coordinator
  review_verdict: null,   # PASS or FAIL
  review_score: null,     # from review-coordinator
  total_findings: 0,      # cumulative
  critical_findings: 0,   # cumulative unresolved
  files_changed: [],      # from code-coordinator
  commit_hash: null,      # from code-coordinator
}
```

### Iteration Escalation

| Iteration | Plan Coordinator Focus | Code Coordinator Focus | Review Coordinator Focus |
|-----------|----------------------|----------------------|------------------------|
| 1 | Full plan from scratch | Full implementation | Full review (all dimensions) |
| 2 | Fix plan (reviewer issues only) | Fix implementation (targeted) | Focus on previous issues + regression |
| 3 | Minimal fix plan (critical only) | Minimal fixes (critical only) | Final check (critical only) |

### Early Exit Conditions

- **Plan score < 85 after 2 attempts**: Escalate to user (requirements may be unclear)
- **Code coordinator BLOCKED**: Escalate (may need different approach)
- **Circuit breaker OPEN**: Stop immediately, report state
- **User cancels**: Stop at current point, preserve work

## Final Report Synthesis

After the loop completes (PASS or max iterations), synthesize:

```markdown
## Pyramid Execution Complete

**Task**: {original_request}
**Iterations**: {N}/3
**Final Verdict**: {PASS | FAIL (escalated)}

### Pyramid Summary
| Phase | Score/Status | Iterations |
|-------|-------------|------------|
| Plan | {score}/100 | {plan_iterations} |
| Code | {PASS/BLOCKED} | {code_iterations} |
| Review | {score}/100 | {review_iterations} |

### Changes Made
{aggregated file list from code-coordinator}

### Key Findings Resolved
{findings that were found and fixed across iterations}

### Remaining Issues (if any)
{unresolved findings from final review}

### Commit
- Hash: {hash}
- Rollback: `git revert {hash}`
```

## Integration with Quality Gates

The pyramid loop enforces quality gates at each transition:

| Transition | Gate | Threshold |
|------------|------|-----------|
| Task -> Plan | Plan Coordinator self-scores | >= 85 |
| Plan -> Code | Plan report present and valid | Plan complete |
| Code -> Review | Tests pass, build succeeds | All green |
| Review -> Done | Review verdict | PASS (score >= 80, no critical) |
| Review -> Fix Loop | Review verdict | FAIL |

## Integration with Circuit Breaker

- Code-coordinator failures count toward the circuit breaker
- 3 consecutive BLOCKED reports = circuit breaker OPENS
- When OPEN: pyramid loop cannot proceed, must reset first

---

**This skill ensures that every code change follows the appropriate execution path. Full Pyramid routes get planned, implemented, and reviewed with fix loops. Lightweight routes get fast @programmer execution with TDD. Both paths drive quality convergence.**
