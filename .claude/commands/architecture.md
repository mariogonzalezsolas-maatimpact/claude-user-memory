---
name: architecture
description: Quick command to invoke software-architect for system design, pattern evaluation, ADRs, module boundaries, and C4 diagramming.
---

# /architecture Command

Perform architecture design or review using the software-architect agent.

## Usage

```
/architecture [system or focus area]
```

## What This Does

1. Invokes `@software-architect` with your scope
2. Analyzes system context (stakeholders, integrations, constraints)
3. Evaluates architectural patterns (Clean, Hexagonal, Event-Driven, etc.)
4. Defines module boundaries with dependency rules
5. Writes Architecture Decision Records (ADRs)
6. Creates C4 diagrams (Context, Container, Component)
7. Delivers Architecture Report with score (0-100)

## Examples

```
/architecture evaluate patterns for our e-commerce backend
/architecture design module boundaries for the payment system
/architecture review current architecture for anti-patterns
/architecture ADR for switching from REST to GraphQL
```

## Output

You'll receive an Architecture Report including:
- Architecture Score (0-100) with breakdown
- Pattern evaluation with trade-off matrix
- Module boundary definitions
- C4 diagrams (at least Context level)
- ADRs for key decisions
- Dependency analysis (coupling, cohesion)
- Tech debt map
- Evolution readiness assessment

## Next Steps

After `/architecture` completes:
1. Review and approve ADRs
2. Use `/api-design` for API contract design
3. Use `/database` for schema design
4. Use `/plan` to create implementation blueprint
5. Use `/workflow` for full implementation

## Time

Typical completion: **< 5 minutes**

---

**Executing command...**

Please invoke: `@software-architect {args}`
