# WSTG-v42-AUTHZ — Authorization

Tests in this category focus on whether authenticated users can access only what they're allowed to.

---

## WSTG-v42-AUTHZ-01 — Testing Directory Traversal File Include

**Objective:** Verify the application does not allow traversing the filesystem via user input.

**What to check:**
- Parameters that accept file paths reject `..`, `%2e%2e`, absolute paths
- File includes (`require`, `include`, `open`) do not accept user input directly
- Null byte injection (`%00`) does not truncate paths
- Encoded traversal (`%252e%252e`, `..././`) is blocked
- Template/view names from user input cannot reach arbitrary files

**Pass criteria:** No user input reaches filesystem operations without validation and canonicalization.

**Severity if failing:** Critical. Often leads to source code disclosure or RCE.

---

## WSTG-v42-AUTHZ-02 — Testing for Bypassing Authorization Schema

**Objective:** Verify authorization is enforced on every protected resource.

**What to check:**
- Every endpoint checks authorization server-side, not just client-side
- Direct URL access to admin pages as a non-admin returns 403
- API endpoints verify the caller has permission for the requested resource
- Authorization is applied at the controller/router level, not just in UI rendering
- HTTP method changes don't bypass authorization (GET vs POST vs PUT)
- Header manipulation doesn't bypass authorization
- Forced browsing to privileged endpoints is rejected

**Pass criteria:** Every protected endpoint performs server-side authorization checks.

**Severity if failing:** Critical.

---

## WSTG-v42-AUTHZ-03 — Testing for Privilege Escalation

**Objective:** Verify a user cannot elevate their privileges through parameter manipulation or flawed logic.

**What to check:**
- Horizontal escalation: cannot access other users' data by changing user IDs
- Vertical escalation: cannot become admin by changing role parameters
- Mass assignment vulnerabilities (e.g., can user set `is_admin=true` via form submission?)
- JWT claims cannot be tampered (signature verified)
- Role checks occur after authentication, not before
- Hidden form fields with privilege values cannot be overridden

**Pass criteria:** Privilege levels are enforced server-side with no user input contributing to the decision.

**Severity if failing:** Critical.

---

## WSTG-v42-AUTHZ-04 — Testing for Insecure Direct Object References

**Objective:** Verify the application verifies ownership/access when resources are referenced by ID.

**What to check:**
- `/api/users/123` checks if the caller is user 123 (or admin)
- `/api/documents/{id}` verifies the caller owns or has access to the document
- Sequential IDs don't expose enumeration (consider UUIDs)
- Predictable IDs (timestamps, incrementing integers) have access checks
- File download endpoints verify ownership before serving
- Multi-tenant scoping is enforced (tenant A cannot access tenant B's data)

**Pass criteria:** Every resource access verifies the caller has permission for THAT specific resource instance.

**Severity if failing:** Critical. IDOR is one of the most common OWASP findings.
