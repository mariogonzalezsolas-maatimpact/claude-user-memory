---
name: database
description: Quick command to invoke database-architect for schema design, migration planning, query optimization, and index strategy review.
---

# /database Command

Perform database design or review using the database-architect agent.

## Usage

```
/database [schema, query, or focus area]
```

## What This Does

1. Invokes `@database-architect` with your scope
2. Analyzes schema design (normalization, constraints, types)
3. Reviews query performance (EXPLAIN ANALYZE, indexes)
4. Detects ORM anti-patterns (N+1, over-fetching)
5. Plans safe migrations (reversible, zero-downtime)
6. Assesses scalability (partitioning, replicas, caching)
7. Delivers Database Report with score (0-100)

## Examples

```
/database design schema for user subscriptions
/database optimize slow queries in the orders service
/database review migration safety for column rename
/database index strategy for the products table
```

## Output

You'll receive a Database Report including:
- Database Score (0-100) with breakdown
- Schema analysis (normalization, constraints)
- Query performance profiles
- Index recommendations
- ORM anti-pattern findings
- Migration safety assessment
- Scalability recommendations

## Next Steps

After `/database` completes:
1. Apply recommended indexes
2. Fix N+1 queries
3. Use `@code-implementer` for migration execution
4. Use `/architecture` for data architecture decisions

## Time

Typical completion: **< 5 minutes**

---

**Executing command...**

Please invoke: `@database-architect {args}`
