# WSTG-v42-ERRH — Error Handling

Tests in this category focus on whether error handling leaks information that could aid an attacker.

---

## WSTG-v42-ERRH-01 — Testing for Improper Error Handling

**Objective:** Verify error responses don't leak internal information.

**What to check:**
- 500 errors return a generic message, not a stack trace
- Database errors don't expose SQL, table names, or column names
- ORM errors don't reveal schema or query structure
- File not found errors don't distinguish "doesn't exist" from "no permission"
- Framework debug pages (Flask debug, Django debug, Rails error pages) are OFF in production
- Error codes are consistent (e.g., 401 vs 403 vs 404 don't leak existence)
- Error messages don't echo user input unsanitized (can enable XSS)
- Async/queue errors don't expose internal queue state, job IDs, or retry info

**Pass criteria:** All error responses are generic to unauthenticated/unauthorized users. Detailed errors only in server logs.

**Severity if failing:** Medium. Enables reconnaissance and can escalate to higher findings.

---

## WSTG-v42-ERRH-02 — Testing for Stack Traces

**Objective:** Verify stack traces are never shown to users.

**What to check:**
- No stack traces in HTML error pages
- No stack traces in JSON API error responses
- No stack traces in custom error pages that were supposed to hide them but accidentally echo details
- Framework defaults (DEBUG=False) applied
- Uncaught exceptions return generic 500 with no detail
- Async exceptions are caught and masked

**Pass criteria:** No stack traces ever reach the client, regardless of error type.

**Severity if failing:** Medium.
