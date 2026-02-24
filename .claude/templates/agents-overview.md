# Agents Overview

**15 agents** across 4 tiers. Models: Opus (3 critical) + Sonnet (7 analysis) + Haiku (5 checklist).

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
| 10 | seo-strategist | Growth | haiku | Search visibility, organic traffic, Core Web Vitals |
| 11 | business-analyst | Growth | haiku | Requirements, ROI, process optimization |
| 12 | content-strategist | Growth | haiku | Content marketing, brand voice, social media |
| 13 | product-strategist | Growth | haiku | Market analysis, roadmaps, GTM strategy |
| 14 | security-auditor | Growth | sonnet | OWASP Top 10, compliance, vulnerability scanning |
| 15 | ux-accessibility-reviewer | Growth | haiku | WCAG 2.2, usability heuristics, inclusive design |

## Model Distribution

| Model | Count | Agents | Rationale |
|-------|-------|--------|-----------|
| Opus | 3 | chief-architect, code-implementer, brahma-investigator | Orchestration + deep reasoning |
| Sonnet | 7 | docs-researcher, implementation-planner, brahma-analyzer, brahma-deployer, brahma-monitor, brahma-optimizer, security-auditor | Analysis + code generation |
| Haiku | 5 | seo-strategist, business-analyst, content-strategist, product-strategist, ux-accessibility-reviewer | Checklist + content tasks |

---

## Agent Format (v6.0)

Every agent follows a standardized professional structure:

| Section | Purpose |
|---------|---------|
| **Role** | 3-sentence identity: who, what, how |
| **Philosophy** | 5-bullet guiding principles |
| **Technical Expertise** | 7-10 focused skills |
| **Scope** | What You DO / DON'T Do / File Ownership |
| **Communication Style** | Report format and tone |
| **Think Protocol** | Shared template reference |
| **[Protocol]** | Agent-specific operational sections |
| **Quality Gates** | Checklist before marking complete |
| **Output Protocol** | Agent Report format reference |

---

## Tier 1: Orchestration

### chief-architect
Master orchestrator. Decomposes complex projects into specialized tasks, selects agent teams, manages handoffs, coordinates parallel execution. Use for multi-step features or cross-domain tasks. **Tools**: Read, Write, Edit, Bash, Grep, Glob, WebFetch, WebSearch, Task.

---

## Tier 2: Core Workflow (Research -> Plan -> Analyze -> Implement -> Debug)

### docs-researcher
Fetches version-accurate docs from official sources in <2 min. Delivers ResearchPack (must score 80+). **Tools**: Read, Grep, Glob, WebFetch, WebSearch.

### implementation-planner
Transforms ResearchPacks into minimal-change blueprints with rollback procedures. Plan must score 85+. **Tools**: Read, Grep, Glob, Write.

### brahma-analyzer
Validates alignment between specs, plans, tasks, and code. Detects gaps and conflicts before implementation. Analysis must score 80+. **Tools**: Read, Grep, Glob, Write.

### code-implementer
Executes plans with TDD (RED->GREEN->REFACTOR). Self-corrects with 3 retries + circuit breaker. All tests must pass. **Tools**: Read, Write, Edit, Bash, Grep, Glob.

### brahma-investigator
Systematic root cause analysis for complex bugs and production incidents. Progressive thinking: think -> think hard -> think harder. 3-retry limit. **Tools**: Read, Grep, Glob, Bash.

---

## Tier 3: Production (Deploy -> Monitor -> Optimize)

### brahma-deployer
Safe deployments with canary rollout (5%->25%->50%->100%). Auto-rollback on error rate >1% or latency >500ms. **Tools**: Bash, Read, Write, Grep, WebFetch.

### brahma-monitor
Three pillars: Metrics + Logs + Traces. SLI/SLO tracking, proactive incident detection, runbook automation. **Tools**: Bash, Read, Write, WebFetch, Grep.

### brahma-optimizer
Performance profiling, scaling strategies, caching (Redis/CDN/app-level), DB query optimization. Profile first, optimize second. **Tools**: Bash, Read, Write, WebFetch, Grep.

---

## Tier 4: Growth & Strategy

### seo-strategist
Technical SEO audits, meta tags, schema markup (JSON-LD), keyword strategy, Core Web Vitals. Output: SEO Score 0-100. **Tools**: Read, Write, Grep, Glob, WebFetch, WebSearch.

### business-analyst
Requirements (MoSCoW), process mapping, SWOT/ROI analysis, KPI definition. Output: Business Analysis Report. **Tools**: Read, Write, Edit, Glob, Grep, WebFetch, WebSearch.

### content-strategist
Brand voice, SEO content, content calendars, audience personas, content pillars. Output: Content Strategy. **Tools**: Read, Write, Edit, WebFetch, WebSearch, Glob, Grep.

### product-strategist
Market sizing (TAM/SAM/SOM), competitive intelligence, RICE prioritization, roadmaps (Now/Next/Later). Output: Product Strategy. **Tools**: Read, Write, WebSearch, WebFetch, Glob, Grep.

### security-auditor
OWASP Top 10, code security patterns, dependency scanning, compliance (SOC2/GDPR/HIPAA/PCI DSS). Output: Security Score 0-100. **Tools**: Read, Grep, Glob, Write, WebSearch, WebFetch.

### ux-accessibility-reviewer
Nielsen's 10 heuristics, WCAG 2.2 (A/AA/AAA), keyboard/screen reader testing, color contrast. Output: UX+A11y Score 0-100. **Tools**: Read, Write, Grep, Glob, WebFetch, WebSearch.

---

## Quality Gates

| Transition | Gate | Threshold |
|------------|------|-----------|
| Research -> Plan | ResearchPack score | >= 80 |
| Plan -> Analyze | Plan score | >= 85 |
| Analyze -> Implement | Analysis score | >= 80 |
| Implement -> Done | Tests pass, circuit breaker closed | All green |

Full gate definitions: @.claude/templates/quality-gates.md

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

**Updated**: 2026-02-24 | **Version**: 6.0.0 | **Agents**: 15 (3 Opus + 7 Sonnet + 5 Haiku)
