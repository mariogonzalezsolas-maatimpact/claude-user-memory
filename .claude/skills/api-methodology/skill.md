---
name: api-methodology
description: Systematic methodology for API design. Guides contract-first development, OpenAPI spec creation, versioning strategy, error design, and backward compatibility validation. Claude invokes this when API design decisions are needed.
auto_invoke: true
tags: [api, rest, graphql, openapi, contract-first]
---

# API Methodology Skill

This skill provides a systematic methodology for designing clean, consistent, developer-friendly APIs. It ensures APIs are contract-first, well-documented, and backward-compatible by default.

## When Claude Should Use This Skill

Claude will automatically invoke this skill when:
- `/do` routes to API
- User explicitly invokes `/api-design [topic]`
- @api-designer agent is spawned
- Task requires API endpoint design, versioning, or contract definition

**Do NOT invoke when:**
- Task is API implementation only (use code-implementer or programmer)
- Task is database schema design (use database-architect)
- Task is API security audit (use security-auditor)

## Core Principles

1. **Contract-first** - Design the API before writing implementation code
2. **Consistency is king** - Predictable patterns reduce developer friction
3. **Backward compatible by default** - Breaking changes are a last resort
4. **Errors are first-class** - Design error responses as carefully as successes
5. **Documentation is the UI** - If it's not documented, it doesn't exist

## API Design Protocol

### Step 1: Requirements Analysis (< 30 seconds)

**Identify**:
1. **Consumers** - Who calls this API? (web, mobile, third-party, internal)
2. **Operations** - What CRUD operations are needed?
3. **Data model** - Core entities and their relationships
4. **Auth** - Public, authenticated, role-based?
5. **Existing patterns** - What conventions does this project already use?

### Step 2: Resource Modeling (< 1 minute)

**REST resource design rules**:
- Nouns, not verbs: `/users` not `/getUsers`
- Plural for collections: `/users`, `/orders`
- Nested for relationships: `/users/{id}/orders`
- Max 2 levels deep: `/users/{id}/orders` (not `/users/{id}/orders/{id}/items/{id}`)

**Method mapping**:
| Operation | Method | Status | Body |
|-----------|--------|--------|------|
| List | GET /resources | 200 | Array |
| Get | GET /resources/:id | 200 | Object |
| Create | POST /resources | 201 | Created object |
| Update (full) | PUT /resources/:id | 200 | Updated object |
| Update (partial) | PATCH /resources/:id | 200 | Updated object |
| Delete | DELETE /resources/:id | 204 | Empty |

### Step 3: Response Envelope Design (< 30 seconds)

**Standard success response**:
```json
{
  "data": { },
  "meta": { "page": 1, "total": 100, "cursor": "abc" }
}
```

**Standard error response (RFC 7807)**:
```json
{
  "type": "https://api.example.com/errors/validation",
  "title": "Validation Error",
  "status": 422,
  "detail": "Email format is invalid",
  "errors": [{ "field": "email", "message": "Must be valid email" }]
}
```

**Conventions**:
- ISO 8601 dates, UTC timezone
- Consistent casing (camelCase or snake_case -- pick one)
- Nullable fields explicit, undefined fields omitted
- IDs as strings (UUID) for future flexibility

### Step 4: Pagination & Filtering (< 30 seconds)

**Cursor-based (recommended)**:
```
GET /users?cursor=abc123&limit=20
Response: { "data": [...], "meta": { "next_cursor": "def456", "has_more": true } }
```

**Filtering**: `?status=active&created_after=2024-01-01`
**Sorting**: `?sort=created_at&order=desc`
**Field selection**: `?fields=id,name,email`

### Step 5: Versioning Strategy (< 30 seconds)

**Default: URL path versioning**
- `/api/v1/users` for major versions
- Additive changes (new fields, new endpoints): no version bump
- Breaking changes: new version + migration guide + 6-month sunset

**Headers to include**:
- `X-RateLimit-Limit`, `X-RateLimit-Remaining`, `X-RateLimit-Reset`
- `Sunset: [date]` for deprecated endpoints
- `Link: <url>; rel="next"` for pagination

### Step 6: OpenAPI Spec Validation

**Minimum OpenAPI spec should include**:
- [ ] All endpoints with methods and paths
- [ ] Request body schemas with required fields
- [ ] Response schemas for success AND error cases
- [ ] Authentication scheme defined
- [ ] Example request/response for each endpoint
- [ ] Description for every field

## Quality Assurance

Before delivering API design:
- [ ] All endpoints follow REST conventions (nouns, methods, status codes)
- [ ] Error responses use consistent format (RFC 7807)
- [ ] Pagination strategy defined
- [ ] Versioning strategy documented
- [ ] Authentication flow designed
- [ ] No breaking changes to existing endpoints (or documented with migration)
- [ ] OpenAPI spec valid (if applicable)

## Performance Targets

- **Total time**: < 3 minutes for API design
- **Consistency**: 100% of endpoints follow same conventions
- **Documentation**: Every endpoint has examples

---

**This skill ensures APIs are designed systematically with consistent patterns, proper error handling, and clear documentation.**
