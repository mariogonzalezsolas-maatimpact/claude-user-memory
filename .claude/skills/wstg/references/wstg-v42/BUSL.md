# WSTG-v42-BUSL — Business Logic

Tests in this category focus on flaws in the application's business logic. These are typically the hardest to find automatically because they require understanding the domain.

---

## WSTG-v42-BUSL-01 — Test Business Logic Data Validation

**Objective:** Verify that business rules are enforced server-side.

**What to check:**
- Quantities are within acceptable ranges (no negative quantities, no zero prices)
- State transitions follow the allowed workflow (can't skip from "pending" to "paid" without "processing")
- Relationships between fields are validated (end date > start date, total = sum of line items)
- Currency and numeric values are validated for sign, magnitude, precision
- Required fields are required server-side, not just client-side
- Calculations are done server-side, not trusted from client

**Pass criteria:** All business rules are enforced server-side. Client validation is only for UX.

**Severity if failing:** Varies. Can be High (financial fraud) or Medium (data integrity).

---

## WSTG-v42-BUSL-02 — Test Ability to Forge Requests

**Objective:** Verify that users cannot forge requests to perform actions they shouldn't.

**What to check:**
- Requests include server-verified identity, not client-declared
- Sequence of operations cannot be skipped (e.g., cannot skip payment step)
- Hidden fields cannot be manipulated to change meaning
- Referer and Origin headers are validated where appropriate
- Signed requests / HMACs where used are correctly validated

**Pass criteria:** No forged request can bypass intended business logic.

**Severity if failing:** High.

---

## WSTG-v42-BUSL-03 — Test Integrity Checks

**Objective:** Verify that data integrity is preserved through all operations.

**What to check:**
- Checksums / signatures on critical data are validated
- Database transactions ensure atomicity (no partial updates)
- Audit logs cannot be tampered with
- Time-based records (timestamps) are set server-side
- Immutable records stay immutable

**Pass criteria:** Integrity controls are in place for critical data.

**Severity if failing:** High for financial or legal records.

---

## WSTG-v42-BUSL-04 — Test for Process Timing

**Objective:** Verify that the application doesn't leak information or allow manipulation based on timing.

**What to check:**
- Authentication responses have consistent timing (constant-time comparison)
- No race conditions in critical operations (e.g., double-spend, duplicate coupon redemption)
- Atomic operations for balance checks and updates
- Locking or optimistic concurrency for shared resources
- Token generation and validation use constant-time functions

**Pass criteria:** No timing side channels or race conditions in sensitive operations.

**Severity if failing:** High.

---

## WSTG-v42-BUSL-05 — Test Number of Times a Function Can Be Used

**Objective:** Verify that functions with usage limits are enforced server-side.

**What to check:**
- Coupons cannot be used more than allowed
- One-time tokens are single-use
- Free trials cannot be reset
- Rate limits apply per user, not just per IP
- Usage counters are updated atomically

**Pass criteria:** Usage limits are enforced server-side and cannot be reset or bypassed.

**Severity if failing:** High.

---

## WSTG-v42-BUSL-06 — Testing for the Circumvention of Work Flows

**Objective:** Verify that multi-step workflows cannot be circumvented.

**What to check:**
- Cannot skip mandatory steps (e.g., cannot place order without shipping address)
- Cannot reorder steps to bypass checks
- State transitions enforced server-side
- Cannot resubmit completed steps to re-trigger payment/shipping
- Cannot manipulate workflow state via URL parameters

**Pass criteria:** Workflows enforce their intended sequence server-side.

**Severity if failing:** High.

---

## WSTG-v42-BUSL-07 — Test Defenses Against Application Misuse

**Objective:** Verify the application detects and responds to abuse patterns.

**What to check:**
- Anomaly detection on unusual patterns (rapid requests, unusual sequences)
- Alerting on repeated failed operations
- Lockout or challenge-response on suspected abuse
- Audit logging captures enough detail to investigate misuse
- WAF or rate limiter in place

**Pass criteria:** The application can detect and mitigate automated or suspicious misuse.

**Severity if failing:** Medium.

---

## WSTG-v42-BUSL-08 — Test Upload of Unexpected File Types

**Objective:** Verify file upload restricts file types appropriately.

**What to check:**
- File extension allowlist (not blocklist)
- MIME type verification (via magic bytes, not trusted Content-Type header)
- Files stored with a safe name, not user-provided name
- Files stored outside web root or served from a separate domain
- `Content-Disposition: attachment` for user-uploaded files
- Double extension attacks blocked (`image.php.jpg`)
- Files scanned for malware where applicable

**Pass criteria:** Only expected file types can be uploaded. File type is verified by content, not headers.

**Severity if failing:** High.

---

## WSTG-v42-BUSL-09 — Test Upload of Malicious Files

**Objective:** Verify uploaded files cannot be used to attack the application or other users.

**What to check:**
- Uploaded files cannot be executed server-side (no `.php`, `.jsp`, `.aspx` in web-accessible paths)
- Uploaded SVG files are sanitized (SVG can contain JavaScript)
- Uploaded HTML/JS files are served with `Content-Disposition: attachment`
- Image uploads are re-processed (defeats polyglot files)
- File size limits enforced
- Zip bombs and decompression bombs detected
- Metadata (EXIF) stripped where appropriate
- Anti-virus scanning for downloadable content

**Pass criteria:** No uploaded file can be used to attack the server or other users.

**Severity if failing:** High to Critical.
