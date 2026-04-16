# WSTG-v42-IDNT — Identity Management

Tests in this category focus on how the application manages user identities, roles, and registration.

---

## WSTG-v42-IDNT-01 — Test Role Definitions

**Objective:** Verify that roles are clearly defined, documented, and correctly implemented.

**What to check:**
- All roles in the system are documented with their permissions
- Role definitions match the implemented authorization logic
- No "god mode" or implicit super-admin roles
- Role changes are audited
- Roles follow principle of least privilege

**Pass criteria:** Documented roles match implementation. Each role has only the permissions it needs.

**Severity if failing:** Medium. Often an input for authorization findings.

---

## WSTG-v42-IDNT-02 — Test User Registration Process

**Objective:** Verify the user registration process is secure and doesn't allow abuse.

**What to check:**
- Registration requires verification (email, phone) before account activation
- Rate limiting on registration endpoint
- CAPTCHA or similar anti-automation on public registration
- Email domain restrictions if applicable
- Strong validation on input fields
- Password policy enforced at registration

**Pass criteria:** Registration requires verification and cannot be abused by automation.

**Severity if failing:** Medium. Enables spam, fake accounts, resource exhaustion.

---

## WSTG-v42-IDNT-03 — Test Account Provisioning Process

**Objective:** Verify that accounts are provisioned through a controlled process, especially for privileged accounts.

**What to check:**
- Admin accounts require elevated approval to create
- Service accounts are created with minimum permissions
- Provisioning actions are audit logged
- Deprovisioning is as controlled as provisioning (terminated users lose access)
- No self-service elevation to privileged roles

**Pass criteria:** Account lifecycle is controlled and audited.

**Severity if failing:** High for privileged accounts.

---

## WSTG-v42-IDNT-04 — Testing for Account Enumeration and Guessable User Account

**Objective:** Verify that the application doesn't reveal whether a given username/email exists.

**What to check:**
- Login returns the same response for "invalid user" and "invalid password"
- Password reset returns the same response whether the email exists or not
- Registration returns generic responses
- Response timing is consistent (avoid timing side-channels)
- Error messages don't distinguish "user not found" from "wrong password"

**Pass criteria:** An attacker cannot determine whether a username exists from the application's responses.

**Severity if failing:** Medium. Enables targeted brute force and phishing.

---

## WSTG-v42-IDNT-05 — Testing for Weak or Unenforced Username Policy

**Objective:** Verify the application enforces a reasonable username policy.

**What to check:**
- No special characters that could cause injection (e.g., `admin'--`, `<script>`)
- Username length limits enforced
- Reserved usernames blocked (`admin`, `root`, `system`)
- Unicode homoglyph attacks prevented (visually similar characters)
- Case sensitivity handled consistently

**Pass criteria:** Username policy prevents injection, impersonation, and automation abuse.

**Severity if failing:** Medium.
