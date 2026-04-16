# WSTG Findings Report — {{PROJECT_NAME}}

**Execution tag:** {{EXECUTION_TAG}}
**Date:** {{DATE}}
**Performed by:** {{PERFORMER}}
**Scope:** {{SCOPE}}
**Standard:** OWASP WSTG v4.2

This report documents all confirmed security findings from this audit execution. Each finding maps to a WSTG test ID and a tracked issue.

## Executive Summary

| Severity | Count | Resolved | Mitigated | Open |
|---|---|---|---|---|
| Critical | 0 | 0 | 0 | 0 |
| High | 0 | 0 | 0 | 0 |
| Medium | 0 | 0 | 0 | 0 |
| Low | 0 | 0 | 0 | 0 |
| Informational | 0 | 0 | 0 | 0 |
| **Total** | **0** | **0** | **0** | **0** |

## Methodology

- Standard: OWASP Web Security Testing Guide v4.2
- Categories tested: _(list)_
- Environment: _(staging / production / local)_
- Tools used: _(manual review, static analysis, fuzzing, ...)_
- Scope limitations: _(list areas explicitly out of scope)_

## Findings Index

| # | WSTG ID | Title | Compliance Refs | Severity | Status | Issue |
|---|---|---|---|---|---|---|
| 1 | | | | | | |

---

## Finding Template

Copy this block for each finding.

### Finding #{{N}} — {{TITLE}}

- **WSTG ID:** WSTG-v42-{{CATEGORY}}-{{NN}}
- **Compliance Refs:** {{ENS_CONTROLS}} _(from references/compliance/ens-mapping.md)_
- **Severity:** Critical / High / Medium / Low / Informational
- **Status:** Open / Resolved / Mitigated / Partial
- **Issue:** {{ISSUE_TRACKER_LINK}}
- **Affected component:** `path/to/file.py:123` or `module.submodule`
- **Discovered in execution:** {{EXECUTION_TAG}}

#### Description

Clear explanation of the vulnerability, what it allows an attacker to do, and under what conditions it can be exploited.

#### Evidence

Concrete evidence. Minimum one of:
- File path and line number with the vulnerable code snippet
- Command output showing the issue
- Screenshot of the behavior (referenced, not embedded)
- HTTP request/response pair

```
# Example: file path + snippet
backend/app/routers/auth.py:42

@router.post("/login")
def login(username: str, password: str):
    user = db.query(f"SELECT * FROM users WHERE name = '{username}'")  # SQLi
```

#### Reproduction

Step-by-step reproduction. Should be precise enough that another engineer can confirm the finding without guessing.

1. Send a POST to `/auth/login` with body `{"username": "admin' OR '1'='1", "password": "x"}`
2. Observe that the response contains an authenticated session
3. Confirm by calling `/api/me` with the returned token

#### Impact

Concrete impact on the system, users, or data. Avoid vague language like "security risk".

- An unauthenticated attacker can authenticate as any user
- All account data is exposed via subsequent API calls
- No audit trail records the bypass

#### Compliance Impact

ENS controls affected by this finding:
- **{{ENS_CONTROL_ID}}** — {{ENS_CONTROL_NAME}}: {{brief description of how this finding impacts the control requirement}}

_(Repeat for each affected ENS control. If other compliance frameworks are relevant, add their controls here too.)_

#### Recommendation

Specific, actionable remediation advice. Not "fix the SQL injection" but "replace the string-interpolated query with a parameterized query using the existing `db.execute` helper".

#### Resolution

_(Filled in after the fix is applied)_

- **Status:** Resolved / Mitigated / Partial
- **Commit:** `abc1234`
- **PR:** {{PR_LINK}}
- **Validation:**
  - Unit test: `tests/test_auth.py::test_sqli_blocked` passes and demonstrates the old payload is now rejected
  - Manual retest: 2026-04-12, confirmed the injection payload returns 401
- **Retest recorded in register:** Row added with tag `{{RETEST_TAG}}` marking `WSTG-v42-{{CATEGORY}}-{{NN}}` as ✅ OK

---

## Appendix: Severity Rubric

- **Critical** — Remote code execution, authentication bypass with full access, mass data exposure, infrastructure compromise
- **High** — Privilege escalation, significant data leak, weak cryptography on sensitive data, auth bypass on specific flows, SSRF reaching cloud metadata
- **Medium** — Information disclosure without direct credentials, weak session controls, limited IDOR, improper error handling exposing internals, cache poisoning without data exfiltration
- **Low** — Missing security headers without direct impact, verbose errors without sensitive info, minor config hardening gaps
- **Informational** — Best practice deviations with no direct exploit path, observations for future hardening
