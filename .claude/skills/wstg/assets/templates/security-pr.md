# Security PR Template

Every PR that addresses a WSTG finding MUST include this block in the PR description. This creates the evidence chain required for compliance audits.

## Template

```md
## Security Fix

- **WSTG ID:** WSTG-v42-XXXX-YY
- **Compliance Refs:** {{COMPLIANCE_CONTROLS}} _(e.g., ENS: op.acc.5, mp.com.3)_
- **Issue:** {{ISSUE_TRACKER_LINK}}
- **Severity:** Critical / High / Medium / Low / Informational

### Problem

Clear description of the vulnerability being fixed. Reference the finding in the audit report.

### Solution

Description of the change being made. Explain WHY it addresses the root cause, not just the symptom.

### Verification

Evidence that the fix works:

- [ ] New or updated test: `path/to/test_file.py::test_name`
- [ ] Test demonstrates the vulnerability is no longer reachable
- [ ] Tests pass locally (output below)
- [ ] Manual validation performed (steps below)

**Test output:**
\`\`\`
<paste test command and output>
\`\`\`

**Manual validation:**
<steps performed and observed behavior>

### Status after the change

- [ ] Resolved — vulnerability fully mitigated with test evidence
- [ ] Mitigated — risk reduced but compensating controls still needed
- [ ] Partial — some cases addressed, others tracked in {{FOLLOW_UP_ISSUE}}

### Audit trail updates

- [ ] `docs/wstg/test-register.md` updated with retest row
- [ ] `docs/wstg/executions/{{DATE}}-{{TAG}}-findings.md` status updated
- [ ] Issue commented with fix summary and PR link
```

## Why this matters

Compliance audits (SOC 2, ISO 27001, ENS, PCI-DSS) require three things for every security finding:

1. **Traceability** — the finding can be traced from audit → issue → PR → commit → test
2. **Evidence** — objective proof that the fix works (test output, repro)
3. **Status** — explicit resolution state, not implicit

Without this block, a fix is just a code change. With this block, it's audit evidence.

## Anti-patterns to avoid

- **"Fixed the thing"** — no WSTG ID, no issue, no verification. Useless for audit.
- **Passing tests that don't exercise the vulnerability** — a green build doesn't prove the fix works. The test must demonstrate the old payload now fails.
- **Marking Resolved without retest** — the register must record a retest execution showing the test now passes.
- **Closing the issue without commenting** — the issue is the long-lived record. It needs a comment explaining what happened.
- **Hiding the fix in a large refactor PR** — security fixes should be atomic and reviewable on their own. Split refactors from fixes.
