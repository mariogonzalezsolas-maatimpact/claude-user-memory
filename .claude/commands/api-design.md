---
name: api-design
description: Quick command to invoke api-designer for REST/GraphQL/gRPC API design, OpenAPI specs, versioning, error design, and contract-first development.
---

# /api-design Command

Perform API design using the api-designer agent.

## Usage

```
/api-design [API or focus area]
```

## What This Does

1. Invokes `@api-designer` with your scope
2. Designs resource endpoints (REST conventions)
3. Creates OpenAPI/Swagger specifications
4. Defines error response formats (RFC 7807)
5. Designs pagination, filtering, and sorting
6. Plans versioning and deprecation strategy
7. Delivers API Design Report with score (0-100)

## Examples

```
/api-design REST endpoints for user management
/api-design GraphQL schema for the product catalog
/api-design versioning strategy for our public API
/api-design error response standardization
```

## Output

You'll receive an API Design Report including:
- API Design Score (0-100) with breakdown
- Endpoint definitions (method, path, status codes)
- Request/response examples
- Error response catalog
- Pagination strategy
- Versioning plan
- Authentication flow
- OpenAPI spec (if REST)

## Next Steps

After `/api-design` completes:
1. Review and finalize the API contract
2. Use `/database` for schema design
3. Use `/plan` to create implementation blueprint
4. Use `@code-implementer` to implement endpoints
5. Use `@testing-engineer` for API test strategy

## Time

Typical completion: **< 5 minutes**

---

**Executing command...**

Please invoke: `@api-designer {args}`
