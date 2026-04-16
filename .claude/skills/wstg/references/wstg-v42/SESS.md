# WSTG-v42-SESS — Session Management

Tests in this category focus on how sessions are created, maintained, and invalidated.

---

## WSTG-v42-SESS-01 — Testing for Session Management Schema

**Objective:** Verify the session management scheme is sound.

**What to check:**
- Session tokens are cryptographically random (sufficient entropy)
- Session tokens are long enough to resist brute force (at least 128 bits)
- Session tokens are not predictable (sequential, timestamp-based, user-derived)
- New session issued on privilege change (login, privilege escalation)
- Server-side session store (or signed stateless tokens like JWT)

**Pass criteria:** Session tokens are unpredictable, high-entropy, and managed server-side or cryptographically signed.

**Severity if failing:** Critical.

---

## WSTG-v42-SESS-02 — Testing for Cookies Attributes

**Objective:** Verify session cookies have appropriate security attributes.

**What to check:**
- `Secure` flag set (cookie only sent over HTTPS)
- `HttpOnly` flag set (cookie not readable from JavaScript)
- `SameSite` attribute set to `Lax` or `Strict`
- Appropriate `Path` restricting scope
- `Domain` not overly broad (avoid leading dot unless needed)
- Reasonable expiration (`Expires`/`Max-Age`)
- `__Host-` or `__Secure-` prefix for sensitive cookies

**Pass criteria:** Session cookies have Secure, HttpOnly, and SameSite attributes appropriately set.

**Severity if failing:** High.

---

## WSTG-v42-SESS-03 — Testing for Session Fixation

**Objective:** Verify the application issues a new session ID upon authentication.

**What to check:**
- Session ID before login is different from session ID after login
- Pre-authentication session IDs cannot be carried into authenticated sessions
- Session ID is regenerated on privilege change (e.g., becoming admin)
- Session ID is regenerated on password change

**Pass criteria:** Session ID is regenerated on every authentication and privilege change.

**Severity if failing:** High.

---

## WSTG-v42-SESS-04 — Testing for Exposed Session Variables

**Objective:** Verify session tokens are not exposed where they could be captured.

**What to check:**
- Session tokens never appear in URLs (query string)
- Session tokens never appear in logs
- Session tokens never appear in Referer headers
- Session tokens not stored in localStorage (XSS-accessible)
- Error messages do not echo session tokens
- Analytics and monitoring tools don't capture session tokens

**Pass criteria:** Session tokens only travel in secure cookie headers.

**Severity if failing:** High.

---

## WSTG-v42-SESS-05 — Testing for Cross Site Request Forgery

**Objective:** Verify state-changing operations are protected against CSRF.

**What to check:**
- State-changing endpoints (POST, PUT, DELETE) require CSRF token
- CSRF token is bound to the session
- CSRF token is verified server-side on every state change
- `SameSite=Lax` or `Strict` on session cookies as defense in depth
- JSON-only APIs with `Content-Type: application/json` verification
- Double-submit cookie pattern if used is correctly implemented
- CORS policy does not undermine CSRF protection

**Pass criteria:** All state-changing operations are protected by at least one anti-CSRF mechanism (token, SameSite, origin check).

**Severity if failing:** High.

---

## WSTG-v42-SESS-06 — Testing for Logout Functionality

**Objective:** Verify logout correctly terminates the session.

**What to check:**
- Logout invalidates the session server-side (not just client-side)
- Cannot replay the session cookie after logout
- Logout link is protected (not accessible via GET without CSRF — to prevent forced logout)
- "Log out everywhere" option exists for sensitive accounts
- UI reflects logged-out state immediately
- Timeout-based logout is enforced server-side

**Pass criteria:** Logout invalidates the session server-side and subsequent requests with the old token are rejected.

**Severity if failing:** High.

---

## WSTG-v42-SESS-07 — Testing Session Timeout

**Objective:** Verify sessions expire after a reasonable period of inactivity.

**What to check:**
- Inactivity timeout is enforced (typically 15-30 min for sensitive apps, up to a few hours for low-sensitivity)
- Absolute timeout (session valid for max N hours regardless of activity)
- Timeout is enforced server-side, not relying only on cookie Max-Age
- Timeout is appropriate for the sensitivity of the application
- Re-authentication required for sensitive operations even within active session

**Pass criteria:** Both inactivity and absolute timeouts are enforced server-side.

**Severity if failing:** Medium to High.

---

## WSTG-v42-SESS-08 — Testing for Session Puzzling

**Objective:** Verify session variables are not reused across different contexts in ways that leak privilege or identity.

**What to check:**
- Session keys used in one flow cannot be reused in another (e.g., password reset token used as auth token)
- Multi-step flows don't allow skipping steps by manipulating session state
- Pre-authentication session state cannot be promoted to authenticated state without authentication
- Temporary privileges (e.g., "just logged in") don't persist past their intended scope

**Pass criteria:** Session state is scoped to its intended use and cannot be repurposed.

**Severity if failing:** High.

---

## WSTG-v42-SESS-09 — Testing for Session Hijacking

**Objective:** Verify session tokens cannot be stolen and replayed by an attacker.

**What to check:**
- HTTPS enforced everywhere (no HTTP fallback)
- HSTS header set
- Session tokens bound to additional factors (IP, User-Agent) if feasible
- Detection of concurrent sessions from different locations/devices
- Alerting on suspicious session activity
- No XSS vulnerabilities that could steal tokens (see CLNT-*)

**Pass criteria:** Session tokens cannot be easily captured or replayed. Defense in depth is applied.

**Severity if failing:** High.
