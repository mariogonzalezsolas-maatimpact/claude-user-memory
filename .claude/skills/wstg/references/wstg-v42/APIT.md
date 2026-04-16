# WSTG-v42-APIT — API Testing

Tests in this category focus specifically on API-layer concerns that don't fit cleanly in other categories. In WSTG v4.2, this category is small and focuses on GraphQL, but the broader API test surface is covered across other categories (ATHN, AUTHZ, SESS, INPV).

---

## WSTG-v42-APIT-01 — Testing GraphQL

**Objective:** Verify GraphQL endpoints are secured against GraphQL-specific attacks.

**What to check:**
- **Introspection:** GraphQL introspection is disabled in production (or authenticated)
- **GraphiQL / Playground:** Dev UI is disabled in production
- **Query depth limiting:** Limits on nested query depth to prevent DoS via deeply nested queries
- **Query complexity limiting:** Cost analysis prevents expensive queries
- **Field-level authorization:** Authorization checked at resolver level, not just at endpoint level
- **Batching attacks:** Query batching is rate-limited
- **Aliases abuse:** Aliases can't be used to bypass rate limits (same field queried many times via aliases)
- **Introspection-based schema enumeration:** Error messages don't leak schema even when introspection is off
- **Mutation authorization:** Every mutation has its own authorization check
- **N+1 query resolution:** DataLoader or similar prevents N+1 DoS
- **Injection via arguments:** GraphQL arguments are validated server-side, not just at schema level

**Pass criteria:**
- Introspection and playground disabled in production
- Depth and complexity limits enforced
- Authorization applied per-resolver
- No information leakage through errors or field suggestions

**Severity if failing:**
- Disabled introspection missing: Medium
- No depth/complexity limits: High (DoS)
- Missing resolver-level auth: Critical (horizontal/vertical privilege escalation)
