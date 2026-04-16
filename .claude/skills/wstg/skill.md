---
name: wstg
description: Audit, document, and fix web application security issues using the OWASP Web Security Testing Guide (WSTG) v4.2. Use this skill when the user asks to run a WSTG audit, perform a security review, check WSTG compliance, document a security finding, fix a vulnerability with WSTG traceability, generate a security findings report, prepare evidence for SOC 2 / ISO 27001 / ENS / PCI-DSS compliance, or draft a security PR following a structured protocol. Triggers include mentions of "WSTG", "OWASP WSTG", "security audit", "security compliance", "vulnerability finding", "security evidence", "compliance evidence".
---

# WSTG Skill

You are helping the user apply the **OWASP Web Security Testing Guide v4.2** methodology to their project. The WSTG is the reference standard for web application security testing. Your job is to drive a structured, evidence-based audit process that produces compliance-grade documentation.

## Core principles

1. **Traceability is mandatory.** Every finding must have a WSTG ID (format `WSTG-v42-<CATEGORY>-<NN>`), link to an issue in the project's tracker (Linear, GitHub, Jira, GitLab), and be reproducible.
2. **Evidence beats assertion.** Do not mark a test as "pass" or "fail" based on intuition. Read the actual code, run the actual check, or cite the actual file. If you can't produce evidence, mark it `⬜ Pendiente` / `Pending` and say why.
3. **Registers are cumulative.** The `test-register.md` grows over time. Never delete rows from prior executions — add new rows for each new execution so history stays intact.
4. **Don't close findings without validation.** A code change is not a resolution. The resolution is a code change plus evidence that the new behavior is correct (test, manual repro, runtime check).
5. **Stay within scope.** WSTG has ~100 test cases. Most projects only need a subset. Detect the stack first and skip tests that are N/A (e.g., skip `CLNT-*` on a pure backend, skip `APIT-01` if there's no GraphQL).

## Operations

This skill supports five operations. When the user's request matches one, follow that operation's workflow. If it's unclear, ask which one they want.

### 1. `init` — Set up WSTG infrastructure in the project

**Trigger phrases:** "set up WSTG", "initialize WSTG", "start using WSTG", "add WSTG to this project"

**Workflow:**
1. Detect the project stack by checking for: `package.json`, `requirements.txt`, `pyproject.toml`, `go.mod`, `Gemfile`, `composer.json`, `pom.xml`, `build.gradle`. Note both backend and frontend frameworks.
2. Detect the issue tracker: check `.linear/`, `.github/ISSUE_TEMPLATE/`, `CONTRIBUTING.md`, or ask the user.
3. Create the following structure in the project:
   ```
   docs/wstg/
   ├── test-register.md              # Cumulative audit registry
   ├── checklist-template.md         # Copy of the checklist template
   ├── findings-report-template.md   # Copy of the findings report template
   └── executions/                   # One folder; will be populated per audit
   ```
4. Copy the templates from `assets/templates/` into `docs/wstg/`, substituting the project name and detected stack into the headers.
5. Append a "Protocolo WSTG y PRs de Seguridad" section to the project's `CLAUDE.md` (create it if missing) that references this skill and the mandatory PR format. Use the template in `assets/templates/security-pr.md`.
6. Summarize what was created and what categories will apply based on the detected stack.

### 2. `audit` — Run a guided WSTG audit

**Trigger phrases:** "run a WSTG audit", "audit security", "do a security review using WSTG", "apply WSTG to this project"

**Workflow:**
1. Verify `docs/wstg/test-register.md` exists. If not, run `init` first.
2. Ask the user to name this execution (e.g., `baseline`, `quarterly-2026Q2`, `post-refactor-auth`). The execution tag will be used in the register.
3. For each applicable category (determined by stack), load the corresponding reference file from `references/wstg-v42/<CATEGORY>.md`. Do NOT load all categories upfront — load on demand as you move through them.
4. For each test in the category:
   - State the WSTG ID and title
   - Read the relevant project files to evaluate the test
   - Record one of: `✅ OK` (no finding), `⚠️ Parcial` (control exists but weak), `❌ Fallo` (confirmed finding), `⬜ Pendiente` (needs manual validation), `N/A` (not applicable to this architecture)
   - If `❌ Fallo` or `⚠️ Parcial`, note the evidence (file path + line, or description of the gap)
   - Look up the corresponding compliance controls from `references/compliance/ens-mapping.md` and populate the "Compliance Refs" column in the register row. For `❌ Fallo` and `⚠️ Parcial` results, note which specific ENS controls are impacted in the evidence field.
5. After each category, append the results as new rows in `test-register.md` tagged with the execution name.
6. Create an execution checklist at `docs/wstg/executions/<DATE>-<TAG>-checklist.md` using the checklist template.
7. If any `❌ Fallo` results exist, proceed to the `finding` operation for each.
8. Summarize: total tests run, breakdown by status, list of confirmed findings.

**Important:** Do not rush through categories. A real WSTG audit requires actually reading the code. If you don't have enough information to evaluate a test, mark it `⬜ Pendiente` and state what information is needed — do NOT guess.

### 3. `finding` — Document a security finding

**Trigger phrases:** "document a finding", "log a vulnerability", "record a WSTG finding", "I found a security issue"

**Workflow:**
1. Ask the user for (or extract from conversation):
   - Short title
   - Affected component (file path or module)
   - Description of the vulnerability
   - How you identified it (WSTG test ID, manual discovery, tool output)
2. Map the finding to a WSTG ID. If the user provided one, validate it exists in the reference data. If not, identify the most appropriate category and test.
   - Look up the WSTG ID in `references/compliance/ens-mapping.md` to identify affected ENS controls. Include these in the finding record under "Compliance Refs" and in the "Compliance Impact" section.
3. Assign severity using this rubric:
   - **Critical:** Remote code execution, authentication bypass with full access, mass data exposure
   - **High:** Privilege escalation, significant data leak, weak cryptography on sensitive data, auth bypass on specific flows
   - **Medium:** Information disclosure, weak session controls, limited IDOR, improper error handling exposing internals
   - **Low:** Missing security headers, verbose error messages without sensitive info, minor config hardening
   - **Informational:** Best practice deviations with no direct exploit path
4. Create or append to the current execution's findings report at `docs/wstg/executions/<DATE>-<TAG>-findings.md`, using `assets/templates/findings-report.md`.
5. Include: WSTG ID, title, severity, affected component, description, evidence (file:line or command output), reproduction steps, impact, recommendation.
6. If the project uses an issue tracker, draft the issue content and offer to create it via the tracker's MCP if available, or print the text for manual creation.
7. Link the issue ID back into the findings report and the test register row.

### 4. `fix` — Implement a fix with full WSTG protocol

**Trigger phrases:** "fix DEV-XX", "fix the WSTG finding", "resolve this vulnerability following the protocol"

**Workflow:**
1. Locate the finding in the findings report and the register. Confirm the WSTG ID and issue link.
2. Read the affected files.
3. Propose the fix, explaining WHY it addresses the root cause (not just the symptom).
4. Implement the fix.
5. Add or update tests that prove the fix works. For security fixes, the test should demonstrate the vulnerability is no longer reachable (e.g., auth bypass test, injection test, etc.).
6. Run the tests and capture the output as evidence.
7. Update the findings report: change status to `Resuelto` / `Mitigado` / `Parcial`, add the commit hash and test evidence.
8. Update the test register: add a new row for a retest execution showing the test now passes.
9. Draft a security PR using `assets/templates/security-pr.md`. The PR body MUST include:
   - WSTG ID
   - Issue link
   - Problem description
   - Solution description
   - Validation evidence (test output, manual repro)
   - Status after the change

**Critical:** Do not mark a finding as `Resuelto` without test evidence. If tests can't be added (e.g., config change), document the manual validation steps explicitly.

### 5. `report` — Generate a compliance-ready findings report

**Trigger phrases:** "generate findings report", "create security report", "produce compliance evidence"

**Workflow:**
1. Ask which execution to report on (or the most recent by default).
2. Aggregate from `test-register.md` and the execution's findings file:
   - Executive summary (counts by status and severity)
   - Methodology (WSTG v4.2, categories covered, scope)
   - Findings table (ID, title, severity, status, WSTG ID, issue)
   - Detailed findings (full description for each)
   - Remediation status
3. Save as `docs/wstg/executions/<DATE>-<TAG>-report.md`.
4. If the user is preparing for a compliance audit, or requests an ENS-specific view:
   a. Ask for the system's ENS category (Basica / Media / Alta) to determine which controls apply.
   b. Load `references/compliance/ens-mapping.md`.
   c. Generate an "ENS Compliance Matrix" section in the report using the template from `assets/templates/ens-compliance-report.md`:
      - For each ENS control family (op.acc, op.exp, mp.com, mp.sw, mp.info, mp.s, etc.), list:
        - The ENS control ID and name
        - All WSTG tests that map to it
        - The status of each mapped test from this execution
        - A roll-up status: if any mapped test is ❌, the control is "Non-Compliant"; if any is ⚠️, it's "Partially Compliant"; if all are ✅/N/A, it's "Compliant"
      - Highlight ENS controls that have NO WSTG test coverage (physical, personnel, organizational) and note these require separate assessment
   d. Generate an "ENS Findings Summary" that groups findings by ENS control rather than by WSTG category — this is the view ENS auditors expect.
   e. If other compliance frameworks are requested and their mapping files exist in `references/compliance/`, repeat the same process for those frameworks.

## Reference data

The full WSTG v4.2 checklist lives in `references/wstg-v42/`, organized by category. Load the category file for the tests you are about to evaluate — do not load all categories at once.

| File | Category | Tests |
|---|---|---|
| `INFO.md` | Information Gathering | 10 |
| `CONF.md` | Configuration and Deployment Management | 11 |
| `IDNT.md` | Identity Management | 5 |
| `ATHN.md` | Authentication | 10 |
| `AUTHZ.md` | Authorization | 4 |
| `SESS.md` | Session Management | 9 |
| `INPV.md` | Input Validation | 20 |
| `ERRH.md` | Error Handling | 2 |
| `CRYP.md` | Cryptography | 4 |
| `BUSL.md` | Business Logic | 9 |
| `CLNT.md` | Client-Side | 14 |
| `APIT.md` | API Testing | 1 |

## Compliance mapping data

Cross-reference mappings from WSTG tests to compliance framework controls live in `references/compliance/`. Load the relevant mapping file when generating compliance reports or documenting findings.

| File | Framework | Controls |
|---|---|---|
| `ens-mapping.md` | ENS (RD 311/2022) | org, op.*, mp.* |

When a mapping file exists for a requested framework, compliance references are automatically included in findings, register rows, and reports. When no mapping file exists for a requested framework, inform the user and offer to document the mapping gap.

## Stack detection heuristics

Use these to decide which categories apply:

| If you see... | Stack | Affects |
|---|---|---|
| `package.json` with `react`/`next`/`vue`/`svelte` | Frontend SPA/SSR | `CLNT-*` applies fully |
| No frontend code, only API | Backend only | `CLNT-*` mostly N/A |
| GraphQL schema or resolver | GraphQL | `APIT-01` applies |
| `requirements.txt` + `fastapi`/`django`/`flask` | Python backend | Standard backend tests apply |
| `go.mod` | Go backend | Standard backend tests apply |
| OAuth / JWT in dependencies | Token auth | `SESS-*`, `ATHN-*` emphasis |
| File upload endpoints | Upload flows | `BUSL-08`, `BUSL-09` critical |
| Payment integration (Stripe, etc.) | Payment flows | `BUSL-10` applies |

## Templates

Templates live in `assets/templates/`:

- `test-register.md` — Cumulative register format
- `checklist.md` — Per-execution checklist format
- `findings-report.md` — Findings report format
- `security-pr.md` — Security PR body format
- `ens-compliance-report.md` — ENS compliance report format (used by operation 5 when ENS view is requested)

When initializing a project, copy these verbatim (substituting project-specific placeholders) into the project's `docs/wstg/` directory.

## Common pitfalls to avoid

- **Don't mark everything as OK to seem thorough.** Incomplete audits with honest `⬜ Pendiente` entries are more valuable than optimistic `✅ OK` entries without evidence.
- **Don't skip the register update.** The register is the audit trail. Code fixes without register updates lose compliance value.
- **Don't inline findings into the register.** The register is a summary table; detailed findings go in the findings report file.
- **Don't invent WSTG IDs.** Only use IDs that exist in the reference data. If a finding doesn't fit any test cleanly, pick the closest one and note the mapping decision.
- **Don't run `fix` without the finding being documented first.** The fix workflow assumes traceability already exists.
