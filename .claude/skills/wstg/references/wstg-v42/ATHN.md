# WSTG-v42-ATHN — Authentication

Tests in this category focus on the authentication mechanism itself — how users prove who they are.

---

## WSTG-v42-ATHN-01 — Testing for Credentials Transported over an Encrypted Channel

**Objective:** Verify credentials are never sent over unencrypted channels.

**What to check:**
- Login form POSTs to HTTPS
- Login form itself is loaded over HTTPS (prevents MITM of the form)
- No credentials in URL parameters (GET requests)
- API authentication tokens only transmitted over HTTPS
- HTTP requests redirect to HTTPS before form submission, not after

**Pass criteria:** All credential transmission is over TLS with no HTTP fallback.

**Severity if failing:** Critical.

---

## WSTG-v42-ATHN-02 — Testing for Default Credentials

**Objective:** Verify that no default credentials remain in the deployed application.

**What to check:**
- No default admin/admin, root/root, admin/password accounts
- Default accounts from the framework are removed or have passwords changed
- Seeded development accounts are removed in production
- API keys with default values are rotated
- Database admin accounts have strong passwords

**Pass criteria:** No default or test credentials accepted by any interface.

**Severity if failing:** Critical.

---

## WSTG-v42-ATHN-03 — Testing for Weak Lock Out Mechanism

**Objective:** Verify that the application protects against brute force by locking out or rate-limiting login attempts.

**What to check:**
- Login attempts are rate limited per account
- Login attempts are rate limited per IP
- Lockout threshold is reasonable (typically 5-10 attempts)
- Lockout duration is sufficient to deter brute force
- Lockout cannot be used as a DoS against legitimate users
- Failed attempts are audit logged

**Pass criteria:** Brute force is mitigated without creating a DoS vector.

**Severity if failing:** High.

---

## WSTG-v42-ATHN-04 — Testing for Bypassing Authentication Schema

**Objective:** Verify the authentication schema cannot be bypassed.

**What to check:**
- Direct access to authenticated pages without session returns 401/403
- Cannot skip authentication steps (multi-step login flows)
- SQL injection in login form does not bypass auth
- Parameter manipulation does not elevate privilege (`?admin=true`)
- Forced browsing to post-login pages is blocked
- Cookie/token forgery does not succeed
- OAuth/SSO flows cannot be short-circuited

**Pass criteria:** Every authenticated resource requires valid authentication. No path bypasses the check.

**Severity if failing:** Critical.

---

## WSTG-v42-ATHN-05 — Testing for Vulnerable Remember Password

**Objective:** Verify the "remember me" functionality doesn't weaken authentication.

**What to check:**
- Remember-me tokens are not the raw password
- Tokens are cryptographically random
- Tokens are stored hashed server-side
- Tokens have a reasonable expiration
- Tokens are invalidated on logout and password change
- `Secure` and `HttpOnly` flags on remember-me cookies

**Pass criteria:** Remember-me is implemented via tokens, not credentials, and follows cookie best practices.

**Severity if failing:** High if tokens are weak or leak the password.

---

## WSTG-v42-ATHN-06 — Testing for Browser Cache Weaknesses

**Objective:** Verify sensitive pages are not cached by the browser in a way that leaks data.

**What to check:**
- Sensitive pages set `Cache-Control: no-store`
- `Pragma: no-cache` for HTTP/1.0 compatibility
- Credentials and session info are not in cached responses
- Browser back button after logout does not show authenticated content
- Autocomplete on password fields is disabled where appropriate

**Pass criteria:** Sensitive content is not cached. Browser history does not leak auth state.

**Severity if failing:** Medium.

---

## WSTG-v42-ATHN-07 — Testing for Weak Password Policy

**Objective:** Verify the password policy is strong enough to deter brute force and credential stuffing.

**What to check:**
- Minimum length (at least 8, recommend 12+)
- Check against known-breached password lists (HIBP API or similar)
- No reuse of previous N passwords
- Password expiration policy (modern guidance: don't force rotation unless compromise suspected)
- Multi-factor authentication available or enforced for privileged accounts
- Password hashing uses bcrypt/argon2/scrypt with sufficient cost factor

**Pass criteria:** Aligned with NIST SP 800-63B: min 8 chars, check against breach corpus, no forced rotation, MFA for privileged accounts.

**Severity if failing:** High.

---

## WSTG-v42-ATHN-08 — Testing for Weak Security Question Answer

**Objective:** Verify security questions (if used) are not weaker than the password itself.

**What to check:**
- Security questions have answers not easily findable on social media
- Multiple questions required for reset
- Answers are hashed and case-insensitive
- Security questions are not the sole factor for password reset

**Pass criteria:** Security questions, if used, are supplementary and not the primary reset mechanism. Best practice: don't use security questions at all; use email/SMS verification.

**Severity if failing:** High if security questions allow account takeover.

---

## WSTG-v42-ATHN-09 — Testing for Weak Password Change or Reset Functionalities

**Objective:** Verify password change and reset flows cannot be abused.

**What to check:**
- Password change requires current password
- Password reset token is single-use and expires quickly (typically 1 hour)
- Reset token is not predictable (cryptographically random)
- Reset link uses HTTPS
- Reset flow does not reveal whether an account exists
- Password reset invalidates all existing sessions
- Rate limiting on reset requests

**Pass criteria:** Reset flow cannot be abused for account takeover, enumeration, or DoS.

**Severity if failing:** High to Critical.

---

## WSTG-v42-ATHN-10 — Testing for Weaker Authentication in Alternative Channel

**Objective:** Verify all authentication channels (mobile app, API, legacy interface) apply the same security controls.

**What to check:**
- Mobile API authentication is as strong as web authentication
- Legacy interfaces (SOAP, RPC) apply the same auth policy
- No channel allows lower password complexity
- No channel skips MFA that the main interface requires
- All channels use the same rate limiting and lockout

**Pass criteria:** All authentication channels are equivalent in strength.

**Severity if failing:** High.
