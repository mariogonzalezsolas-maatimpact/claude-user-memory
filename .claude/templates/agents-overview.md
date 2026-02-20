# Agents Overview

**15 agents** across 4 tiers. Models: Opus 4.6 (3 critical) + Sonnet 4.6 (12 standard).

## Quick Reference

| # | Agent | Tier | Model | Use When |
|---|-------|------|-------|----------|
| 1 | chief-architect | Orchestration | opus | 3+ capabilities, multi-domain, uncertain scope |
| 2 | docs-researcher | Core | sonnet | External libraries/APIs need documentation |
| 3 | implementation-planner | Core | sonnet | ResearchPack ready, need execution blueprint |
| 4 | brahma-analyzer | Core | sonnet | Pre-implementation consistency check |
| 5 | code-implementer | Core | opus | Plan ready, TDD implementation needed |
| 6 | brahma-investigator | Core | opus | Complex bugs, production incidents |
| 7 | brahma-deployer | Production | sonnet | Deploy to production, release management |
| 8 | brahma-monitor | Production | sonnet | Observability, SLI/SLO, alerting |
| 9 | brahma-optimizer | Production | sonnet | Performance, scaling, cost optimization |
| 10 | seo-strategist | Growth | sonnet | Search visibility, organic traffic, Core Web Vitals |
| 11 | business-analyst | Growth | sonnet | Requirements, ROI, process optimization |
| 12 | content-strategist | Growth | sonnet | Content marketing, brand voice, social media |
| 13 | product-strategist | Growth | sonnet | Market analysis, roadmaps, GTM strategy |
| 14 | security-auditor | Growth | sonnet | OWASP Top 10, compliance, vulnerability scanning |
| 15 | ux-accessibility-reviewer | Growth | sonnet | WCAG 2.2, usability heuristics, inclusive design |

---

## Tier 1: Orchestration

### chief-architect
Master orchestrator. Decomposes complex projects into specialized tasks, selects agent teams, manages handoffs, coordinates parallel execution. Use for multi-step features or cross-domain tasks.

---

## Tier 2: Core Workflow (Research -> Plan -> Analyze -> Implement -> Debug)

### docs-researcher
Fetches version-accurate docs from official sources in <2 min. Delivers ResearchPack (must score 80+). Auto-invokes research-methodology skill. **Tools**: Read, Grep, Glob, WebFetch, WebSearch.

### implementation-planner
Transforms ResearchPacks into minimal-change blueprints with rollback procedures. No API hallucination (matches ResearchPack exactly). Plan must score 85+. **Tools**: Read, Grep, Glob, Write.

### brahma-analyzer
Validates alignment between specs, plans, tasks, and code. Detects gaps and conflicts before implementation. Analysis must score 80+. **Tools**: Read, Grep, Glob, Write.

### code-implementer
Executes plans with TDD (RED->GREEN->REFACTOR). Self-corrects with 3 retries + circuit breaker. Creates git commits with co-author attribution. All tests must pass.

### brahma-investigator
Systematic root cause analysis for complex bugs and production incidents. Progressive thinking: think (routine) -> think hard (multi-component) -> think harder (novel failures). 3-retry limit. **Tools**: Read, Grep, Glob, Bash.

---

## Tier 3: Production (Deploy -> Monitor -> Optimize)

### brahma-deployer
Safe deployments with canary rollout (5%->25%->50%->100%). Auto-rollback on error rate >1% or latency >500ms. Supports blue-green, feature flags, IaC. **Tools**: Bash, Read, Write, Grep, WebFetch.

### brahma-monitor
Three pillars: Metrics + Logs + Traces. SLI/SLO tracking, proactive incident detection, runbook automation. **Tools**: Bash, Read, Write, WebFetch.

### brahma-optimizer
Performance profiling, scaling strategies, caching (Redis/CDN/app-level), DB query optimization. Profile first, optimize second, measure impact. **Tools**: Bash, Read, Write, WebFetch, Grep.

---

## Tier 4: Growth & Strategy

### seo-strategist
Technical SEO audits, meta tags, schema markup (JSON-LD), keyword strategy, competitive benchmarking, Core Web Vitals. Output: SEO Score 0-100.

### business-analyst
Requirements (MoSCoW), process mapping, SWOT/ROI analysis, stakeholder management, KPI definition. Output: Business Analysis Report.

### content-strategist
Brand voice, SEO content, content calendars (3-month), audience personas, content pillars. Output: Content Strategy + brand guide.

### product-strategist
Market sizing (TAM/SAM/SOM), competitive intelligence, RICE prioritization, roadmaps (Now/Next/Later), GTM planning. Output: Product Strategy.

### security-auditor
OWASP Top 10, code security patterns, dependency scanning, compliance (SOC2/GDPR/HIPAA/PCI DSS). Output: Security Score 0-100.

### ux-accessibility-reviewer
Nielsen's 10 heuristics, WCAG 2.2 (A/AA/AAA), keyboard/screen reader testing, color contrast, JTBD analysis. Output: UX+A11y Score 0-100.

---

## Quality Gates

| Transition | Gate | Threshold |
|------------|------|-----------|
| Research -> Plan | ResearchPack score | >= 80 |
| Plan -> Analyze | Plan score | >= 85 |
| Analyze -> Implement | Analysis score | >= 80 |
| Implement -> Done | Tests pass, circuit breaker closed | All green |

---

## Invocation

```bash
# Universal (recommended)
/do [anything]

# Full workflow
/workflow [feature]

# Direct
@chief-architect [complex task]
@docs-researcher [research topic]
@security-auditor [audit scope]
```

---

**Updated**: 2026-02-20 | **Version**: 5.4.0 | **Agents**: 15 (3 Opus + 12 Sonnet)
