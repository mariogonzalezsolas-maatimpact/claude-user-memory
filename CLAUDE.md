# Agentic Substrate v5.4

Source repository for the Claude Code CLI enhancement system. Users install to `~/.claude/` via `install.sh` or `install.ps1`.

## System Rules
- Never code from memory -- use @docs-researcher or /research first
- Every change: minimal, surgical, reversible
- TDD mandatory: RED -> GREEN -> REFACTOR
- Quality gates: Research 80+, Plan 85+, Tests pass
- Circuit breaker opens after 3 failures: /circuit-breaker reset

## Commands (12)
- `/do [anything]` -- Universal router (RECOMMENDED)
- `/workflow [feature]` -- Full automation: research -> plan -> implement
- `/research [topic]` -- Fetch version-accurate docs (<2 min)
- `/plan [feature]` -- Create minimal-change blueprint
- `/implement` -- Execute plan with TDD + self-correction (3 retries)
- `/review [scope]` -- Multi-perspective code review (security + perf + architecture)
- `/mode [token-efficiency|introspection|default]` -- Switch behavioral modes
- `/context [analyze|optimize|reset]` -- Context health
- `/circuit-breaker [status|reset]` -- Manage circuit breaker
- `/security-audit [scope]` -- OWASP Top 10 + code security review
- `/seo-audit [scope]` -- Technical SEO + Core Web Vitals audit
- `/ux-review [scope]` -- WCAG 2.2 + usability heuristics audit

## 15 Agents (4 Tiers)
- **Orchestrator**: chief-architect
- **Core (BUILD+FIX)**: docs-researcher, implementation-planner, brahma-analyzer, code-implementer, brahma-investigator
- **Production (SERVE)**: brahma-deployer, brahma-monitor, brahma-optimizer
- **Growth (GROW)**: seo-strategist, business-analyst, content-strategist, product-strategist, security-auditor, ux-accessibility-reviewer

## Thinking Modes
Add keyword: **think** (30-60s) | **think hard** (1-2min) | **think harder** (2-4min) | **ultrathink** (5-10min)

## Detailed Documentation
@.claude/templates/agents-overview.md
@.claude/templates/skills-overview.md
@.claude/templates/workflows-overview.md
@.claude/agent-teams.md

## Quick Fixes
- Research <80 -> specify library version explicitly
- Plan <85 -> add rollback procedure + complete file list
- Circuit breaker open -> `/circuit-breaker reset`
- Context too large -> `/context optimize`

## Project Context

This repository is the **source** for the Agentic Substrate. Key directories:

| Directory | Contents |
|-----------|----------|
| `.claude/agents/` | 15 agent definitions |
| `.claude/skills/` | 5 auto-invoked skills |
| `.claude/commands/` | 12 slash commands |
| `.claude/hooks/` | 12 lifecycle hooks |
| `.claude/templates/` | Shared templates + overview docs |
| `.claude/validators/` | API matcher + circuit breaker |
| `.claude/metrics/` | Workflow metrics tracker |
| `.claude/data/` | MCP config template |

## Contributing

1. Follow the research-first philosophy (research -> plan -> implement)
2. Test workflow changes end-to-end before committing
3. Keep agent files focused -- extract shared content to templates
4. Run `install.sh --force` or `install.ps1 -Force` to test installation

## Memory Hierarchy
1. **Enterprise** (`/Library/Application Support/ClaudeCode/CLAUDE.md`)
2. **Project** (this file)
3. **User** (`~/.claude/CLAUDE.md`)
4. **Imports** via `@path/to/file.md` (max 5 hops)
