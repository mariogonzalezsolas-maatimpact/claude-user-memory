---
name: architecture-methodology
description: Systematic methodology for software architecture design. Guides C4 diagramming, ADR writing, pattern evaluation, trade-off analysis, and module boundary definition. Claude invokes this when architecture decisions are needed.
auto_invoke: true
tags: [architecture, design, patterns, ADR, C4]
---

# Architecture Methodology Skill

This skill provides a systematic methodology for making and documenting software architecture decisions. It ensures architecture work is structured, trade-offs are explicit, and decisions are reversible.

## When Claude Should Use This Skill

Claude will automatically invoke this skill when:
- `/do` routes to ARCHITECTURE
- User explicitly invokes `/architecture [topic]`
- @software-architect agent is spawned
- Task requires system design, pattern selection, or module boundary decisions

**Do NOT invoke when:**
- Task is pure code implementation (use code-implementer or programmer)
- Task is API endpoint design only (use api-methodology)
- Task is database schema only (use database-architect directly)

## Core Principles

1. **Trade-offs over dogma** - No pattern is universally best; document why you chose
2. **Simplest architecture that works** - Don't over-engineer for hypothetical futures
3. **Decisions are reversible** - Design for change, document escape hatches
4. **Boundaries are contracts** - Clear interfaces between modules prevent coupling

## Architecture Decision Protocol

### Step 1: Context Gathering (< 1 minute)

**Assess the system**:
1. **Current state** - Existing architecture, patterns, dependencies
2. **Quality attributes** - What matters most: performance, scalability, maintainability, security?
3. **Constraints** - Team size, tech stack, budget, timeline, compliance
4. **Change drivers** - Why is this decision needed now?

**Output**:
```
System: [name]
Current Architecture: [monolith/microservices/modular/none]
Key Quality Attributes: [top 3]
Constraints: [top 3]
Decision Needed: [1-line description]
```

### Step 2: Pattern Evaluation (< 2 minutes)

**Evaluate candidate patterns against context**:

| Pattern | Fits When | Avoid When |
|---------|-----------|------------|
| Clean Architecture | Domain-rich, testability critical | Simple CRUD apps |
| Hexagonal (Ports/Adapters) | Many integrations, swappable adapters | Single integration |
| Event-Driven | Async workflows, loose coupling | Simple sync flows |
| CQRS | Read/write asymmetry, complex queries | Simple uniform access |
| Microservices | Independent scaling, large teams | Small teams, early stage |
| Modular Monolith | Clear boundaries + deployment simplicity | Need independent scaling |
| Layered (N-Tier) | Simple apps, clear responsibilities | Complex cross-cutting concerns |

**Score each candidate** (1-5) on:
- Fit to quality attributes
- Team familiarity
- Implementation complexity
- Evolution flexibility

### Step 3: Module Boundary Design (< 2 minutes)

**Define boundaries using DDD-inspired approach**:

1. **Identify bounded contexts** - What domains exist?
2. **Define public interfaces** - What can modules expose?
3. **Enforce dependency direction** - Outer depends on inner, never reverse
4. **Minimize shared kernel** - Less shared code = less coupling
5. **Anti-corruption layers** - Protect domain from external models

**Boundary validation checklist**:
- [ ] Each module has a single responsibility
- [ ] Dependencies flow inward (UI -> App -> Domain -> Infrastructure)
- [ ] No circular dependencies between modules
- [ ] Shared types are in a dedicated shared kernel (minimized)
- [ ] Each module can be tested independently

### Step 4: ADR Documentation (< 1 minute)

**For each significant decision, write an ADR**:

```markdown
# ADR-[N]: [Title]

## Status: [Proposed | Accepted | Deprecated | Superseded]

## Context
[2-3 sentences: Why is this decision needed? What forces are at play?]

## Decision
[2-3 sentences: What was decided and the key reasoning]

## Consequences
### Positive
- [Benefit 1]
- [Benefit 2]

### Negative
- [Trade-off 1]
- [Trade-off 2]

### Risks
- [Risk 1] → Mitigation: [how to address]
```

### Step 5: C4 Diagram Guidance

**Use the appropriate level of detail**:

| Level | Shows | When to Use |
|-------|-------|-------------|
| L1: Context | System + external actors | Always (start here) |
| L2: Container | Deployable units (apps, DBs, queues) | Multi-container systems |
| L3: Component | Modules within a container | When designing internals |
| L4: Code | Classes/functions | Rarely (code speaks for itself) |

**Diagram format** (text-based for Claude):
```
[User] --> [Web App]
[Web App] --> [API Service]
[API Service] --> [Database]
[API Service] --> [Cache]
[API Service] --> [Message Queue] --> [Worker Service]
```

## Quality Assurance

Before delivering architecture work:
- [ ] At least 2 patterns evaluated with trade-offs
- [ ] Decision documented as ADR
- [ ] Module boundaries defined with dependency rules
- [ ] C4 Context diagram provided (at minimum)
- [ ] Risks identified with mitigations
- [ ] Simplest viable architecture chosen (not most sophisticated)

## Performance Targets

- **Total time**: < 5 minutes for architecture assessment
- **ADR quality**: Every decision has context, rationale, and consequences
- **Diagram coverage**: At least L1 (Context) for every system

---

**This skill ensures architecture decisions are systematic, documented, and grounded in trade-off analysis rather than preference or habit.**
