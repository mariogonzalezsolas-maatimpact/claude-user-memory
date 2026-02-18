# Workflows Overview

## Universal Command: `/do`

Just say what you want -- `/do` analyzes intent and routes automatically:

| Intent | Routes To |
|--------|-----------|
| Build/Add/Create | `/workflow` |
| Research/Learn | `/research` |
| Plan/Design | `/plan` |
| Implement (with plan) | `/implement` |
| Debug/Investigate | `@brahma-investigator` |
| Deploy/Release | `@brahma-deployer` |
| Optimize/Performance | `@brahma-optimizer` |
| Review code | `/review` |
| SEO/Search | `@seo-strategist` |
| Business/Requirements | `@business-analyst` |
| Content/Marketing | `@content-strategist` |
| Product/Roadmap | `@product-strategist` |
| Security/Compliance | `@security-auditor` |
| UX/Accessibility | `@ux-accessibility-reviewer` |
| Complex multi-domain | `@chief-architect` |

---

## Core Workflow: Research -> Plan -> Implement

| Phase | Agent | Time | Deliverable | Gate |
|-------|-------|------|-------------|------|
| Research | docs-researcher | <2 min | ResearchPack | Score >= 80 |
| Plan | implementation-planner | <3 min | Implementation Plan | Score >= 85 |
| Analyze | brahma-analyzer | <2 min | Consistency Report | Score >= 80 |
| Implement | code-implementer | 5-25 min | Code + tests + commit | Tests pass |

```bash
/do Add Redis caching          # Universal (recommended)
/workflow Add Redis caching     # Full automation
/research Redis for Node.js    # Manual step-by-step
```

---

## TDD Cycle (Mandatory)

**RED** (write failing test) -> **GREEN** (minimal code to pass) -> **REFACTOR** (improve quality). 6-10 min per feature unit.

## Error Recovery

3 self-correction attempts, then circuit breaker opens. Check: `/circuit-breaker status`. Reset: `/circuit-breaker reset`.

## Context Management

Run `/context analyze` every 50 messages. `/context optimize` when switching tasks. `/context reset` for fresh start. (39% improvement, 84% token reduction)

---

## Growth & Strategy Patterns

**SEO + Content**: `@seo-strategist` -> `@content-strategist` -> `@code-implementer` (15-25 min)

**Product Launch**: `@product-strategist` -> `@business-analyst` -> `@content-strategist` -> `@seo-strategist` (20-30 min)

**Security-First Deploy**: `@security-auditor` -> `@code-implementer` -> `@brahma-deployer` -> `@brahma-monitor` (30-45 min)

**UX-Driven Dev**: `@ux-accessibility-reviewer` -> `@implementation-planner` -> `@code-implementer` (20-30 min)

**Full Growth Audit**: Run `@seo-strategist` + `@ux-accessibility-reviewer` + `@security-auditor` + `@business-analyst` in parallel, then synthesize with `@product-strategist` (25-40 min)

---

**Updated**: 2026-02-18 | **Version**: 5.3.0
