# Workflows Overview

The Agentic Substrate provides structured workflows for common development patterns:

## Universal Command: `/do`

**The simplest way to use the Agentic Substrate** - just say what you want:

```bash
/do add authentication to my API
/do why is this function slow?
/do deploy to production
/do research WebSockets
```

The `/do` command:
1. **Analyzes your intent** - Detects if you need research, planning, implementation, debugging, etc.
2. **Routes automatically** - Selects the best command or agent for the task
3. **Gathers context** - On first use, discovers project structure, CLAUDE.md, existing artifacts
4. **Handles complexity** - Simple tasks get direct answers, complex tasks trigger full workflows

| Your Intent | `/do` Routes To |
|-------------|-----------------|
| Build/Add/Create | `/workflow` |
| Research/Learn | `/research` |
| Plan/Design | `/plan` |
| Implement (with plan) | `/implement` |
| Debug/Investigate | `@brahma-investigator` |
| Deploy | `@brahma-deployer` |
| Optimize | `@brahma-optimizer` |
| SEO/Search rankings | `@seo-strategist` |
| Business analysis/Requirements | `@business-analyst` |
| Content/Marketing/Social | `@content-strategist` |
| Product strategy/Roadmap | `@product-strategist` |
| Security audit/Compliance | `@security-auditor` |
| UX review/Accessibility | `@ux-accessibility-reviewer` |
| Complex multi-domain | `@chief-architect` |
| Complex parallel work (3+ layers) | Agent Team (with confirmation) |

---

## Research → Plan → Implement Workflow

The core workflow enforced by the Agentic Substrate:

**Phase 1: Research** (< 2 min)
- Fetch authoritative, version-accurate documentation
- Prevent coding from stale memory
- Deliverable: ResearchPack (validated at 80+ score)

**Phase 2: Planning** (< 3 min)
- Transform research into minimal-change blueprint
- Identify surgical edits only
- Deliverable: Implementation Plan (validated at 85+ score)

**Phase 3: Implementation** (< 5 min)
- Execute plan with TDD (test-first mandatory)
- Self-correction with 3 intelligent retries
- Deliverable: Working code with tests passing + git commit

**Total**: ~10 minutes for production-ready features

### Usage

**Universal command** (RECOMMENDED):
```
/do Add Redis caching to ProductService
```

**Automated workflow**:
```
/workflow Add Redis caching to ProductService with 5-minute TTL
```

**Manual Step-by-Step**:
```
/research Redis for Node.js v5.0
/plan Redis caching implementation for ProductService
/implement
```

**Direct Agent Control**:
```
@chief-architect orchestrate complete user authentication system
```

## Quality Gates

Automatic quality enforcement between phases:

**Gate 1: Research → Planning**
- ResearchPack must score 80+ (API research) or 70+ (philosophy research)
- Blocks planning if research incomplete
- Prevents garbage-in-garbage-out

**Gate 2: Planning → Implementation**
- Implementation Plan must score 85+
- Requires: rollback strategy, file list, step-by-step sequence
- Blocks coding if plan unsafe or incomplete

**Gate 3: Implementation → Completion**
- All tests must pass (TDD enforced)
- Self-correction attempts if failures (max 3)
- Circuit breaker prevents infinite loops

## TDD Workflow (Mandatory)

**RED-GREEN-REFACTOR Cycle**:

1. **RED**: Write failing test (2-3 min)
   - Create test file
   - Write test for new functionality
   - Run test - verify it fails

2. **GREEN**: Implement minimal code (3-5 min)
   - Write simplest code to pass test
   - Run test - verify it passes

3. **REFACTOR**: Improve quality (1-2 min)
   - DRY, SOLID, better naming
   - Run test - verify still passes

**Cycle time**: 6-10 minutes per feature unit

**Why mandatory**: "TDD becomes even more powerful with agentic coding" (Anthropic)

## Git Workflow

**Automatic Commits** (after successful implementation):

1. Check git status
2. Stage relevant files only
3. Create descriptive commit message:
   ```
   [type]: [summary]

   [why this change was made]

   Implemented from ImplementationPlan.md

   🤖 Generated with Claude Code

   Co-Authored-By: Claude <noreply@anthropic.com>
   ```
4. Commit locally (user must push)

**Commit types**: feat, fix, refactor, test, docs, perf, style, chore

**Safety**: Never commits .env, credentials, or large binaries

## Multi-Agent Workflow (Advanced)

**Parallel Multi-Agent Mode** (for complex tasks):

**When to use**:
- Task has 3+ independent sub-tasks
- Sub-tasks don't depend on each other
- Economic viability confirmed (15x cost acceptable)

**Performance**:
- 90.2% improvement over single-agent
- Up to 90% time reduction
- Cost: 15x more tokens

**Example**:
```
@chief-architect Build complete authentication system with OAuth, JWT, and session management

→ Spawns 3-5 parallel subagents:
  - @docs-researcher: OAuth 2.0 docs
  - @docs-researcher: JWT best practices
  - @docs-researcher: Session storage patterns
  - @brahma-analyzer: Existing auth patterns in codebase
  - @docs-researcher: Security requirements

→ Synthesizes results into unified plan
→ Proceeds with implementation
```

**Economic viability check**: Runs automatically before spawning (pre-agent-spawn hook)

## Context Management Workflow

**Active Context Curation**:

**Every 50 messages**:
```
/context analyze
```

**When switching tasks**:
```
/context optimize
```

**Fresh start for new project**:
```
/context reset
```

**Benefits**:
- 39% performance improvement
- 84% token reduction
- Clearer, more focused context
- Better decision-making

## Error Recovery Workflow

**Self-Correction Protocol** (automatic):

1. **Attempt 1**: Analyze error, categorize, apply first fix
2. **Attempt 2**: Try alternative approach
3. **Attempt 3**: Minimal working version

**Circuit Breaker**: Opens after 3 failed attempts
- Check status: `/circuit-breaker status`
- Reset: `/circuit-breaker reset`

**Categories**:
- Syntax Error → Direct correction
- Logic Error → Review against ResearchPack
- API Usage Error → Re-check API signatures
- Type Error → Add type annotations
- Configuration Error → Check setup section
- Test Issue → Adjust test expectations

## Knowledge Preservation Workflow

**Automatic Pattern Capture**:

After every successful implementation:
1. Pattern-recognition skill identifies reusable patterns
2. Updates knowledge-core.md automatically
3. Patterns become available for future sessions

**Manual Knowledge Addition**:
```
# Quick add
# (prompts for location)

# Edit knowledge files
/memory

# Bootstrap new project
/init
```

## Performance Benchmarks

**Typical Feature Implementation**:
- **Before Agentic Substrate**: 55-120 minutes
- **With Agentic Substrate**: 10-25 minutes
- **Speedup**: 4.8-5.5x faster

**Quality Metrics**:
- API accuracy: 95%+ (prevents hallucination)
- Test coverage: 80%+ (TDD enforced)
- Code quality: Consistent (style/conventions enforced)

## Best Practices

**Start with /do**: Let Claude figure out the best approach for your task

**Use /workflow for features**: Automated orchestration is faster and safer

**Trust the quality gates**: If research scores < 80, fix it before planning

**Use think protocols**: Add "ultrathink" for critical architecture decisions

**Run /context optimize**: Every 50 messages or when switching tasks

**Review knowledge-core.md**: Periodically to see accumulated patterns

**Git commits locally only**: Review with `git show HEAD` before pushing

**Check circuit breaker**: If blocked, run `/circuit-breaker status` and reset after fixing issues

## Growth & Strategy Workflows (Tier 4)

### SEO & Content Growth Workflow
```
/do improve our search visibility and content strategy

Sequence:
@seo-strategist → Technical audit + keyword opportunities
    ↓
@content-strategist → Content plan aligned with keywords
    ↓
@code-implementer → Implement schema markup, meta tags
    ↓
@seo-strategist → Validate improvements

Duration: 15-25 min
```

### Product Launch Workflow
```
/do launch our new product

Sequence:
@product-strategist → Market analysis + positioning + GTM plan
    ↓
@business-analyst → Requirements + ROI validation
    ↓
@content-strategist → Launch content + messaging
    ↓
@seo-strategist → SEO for launch pages
    ↓
@ux-accessibility-reviewer → Landing page UX review

Duration: 20-30 min
```

### Security-First Deployment Workflow
```
/do deploy securely to production

Sequence:
@security-auditor → OWASP Top 10 audit
    ↓
@code-implementer → Fix critical vulnerabilities
    ↓
@brahma-deployer → Canary deployment
    ↓
@brahma-monitor → Security monitoring

Duration: 30-45 min
```

### UX-Driven Development Workflow
```
/do improve accessibility and user experience

Sequence:
@ux-accessibility-reviewer → WCAG audit + UX heuristics
    ↓
@implementation-planner → Plan accessibility fixes
    ↓
@code-implementer → Implement ARIA, keyboard nav, contrast
    ↓
@seo-strategist → Validate SEO impact

Duration: 20-30 min
```

### Business Intelligence Workflow
```
/do analyze our business processes

Sequence:
@business-analyst → Process mapping + requirements
    ↓
@product-strategist → Market validation + prioritization
    ↓
@content-strategist → Stakeholder communication plan
    ↓
@chief-architect → Technical feasibility assessment

Duration: 15-25 min
```

### Complete Growth Audit
```
/do full growth audit

Sequence (parallel where possible):
@seo-strategist → SEO health audit
@ux-accessibility-reviewer → UX + accessibility audit
@security-auditor → Security posture audit
@business-analyst → Process efficiency audit
    ↓ (synthesize)
@product-strategist → Prioritized improvement roadmap
@content-strategist → Communication plan for changes

Duration: 25-40 min (with parallel execution)
```

---

## Project Brahma Integration

If you have the Unified Brahma Orchestration System V2.0 installed:

**Agentic Substrate** (15 agents - Research -> Plan -> Implement -> Grow):
- System-wide workflow automation
- Works in ANY directory
- Quality gates and TDD enforcement
- Growth & Strategy analysis

**Project Brahma** (18 agents - BUILD -> FIX -> SERVE):
- Multi-project orchestration
- Constitution-driven workflows
- Production deployment automation

**They work together**:
```bash
# Agentic Substrate handles feature development
/workflow Add payment processing with Stripe

# Growth & Strategy analysis
@seo-strategist Audit SEO for launch readiness
@security-auditor OWASP Top 10 audit before deployment

# Project Brahma handles deployment
@brahma-deployer v2.5.0 to production with canary
```
