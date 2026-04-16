# ENS Compliance Report — {{PROJECT_NAME}}

**Framework:** Esquema Nacional de Seguridad (RD 311/2022)
**Based on:** WSTG v4.2 audit execution `{{EXECUTION_TAG}}`
**Date:** {{DATE}}
**Performed by:** {{PERFORMER}}
**System category:** {{Basica / Media / Alta}}

This report maps the results of a WSTG v4.2 audit to ENS controls, providing the traceability required for ENS compliance evidence. It is generated from `references/compliance/ens-mapping.md` and the execution results in `test-register.md`.

## Compliance Summary

| ENS Family | Total Controls | Compliant | Partial | Non-Compliant | Not Assessed | Out of Scope |
|---|---|---|---|---|---|---|
| op.acc — Access control | | | | | | |
| op.exp — Operations | | | | | | |
| op.mon — Monitoring | | | | | | |
| op.nub — Cloud | | | | | | |
| mp.com — Communications | | | | | | |
| mp.sw — Software | | | | | | |
| mp.info — Information | | | | | | |
| mp.s — Services | | | | | | |
| **WSTG-assessable totals** | | | | | | |

**Roll-up logic:**
- **Compliant:** All mapped WSTG tests are ✅ OK or N/A
- **Partial:** At least one mapped WSTG test is ⚠️ Parcial, none are ❌ Fallo
- **Non-Compliant:** At least one mapped WSTG test is ❌ Fallo
- **Not Assessed:** All mapped WSTG tests are ⬜ Pendiente
- **Out of Scope:** ENS control has no WSTG mapping (requires separate assessment)

## Detailed Control Assessment

### op.acc — Access Control

| ENS Control | Name | WSTG Tests | Result | Findings | Notes |
|---|---|---|---|---|---|
| op.acc.1 | Identification | IDNT-02, IDNT-04, IDNT-05 | | | |
| op.acc.2 | Access requirements | IDNT-01, IDNT-03, AUTHZ-01 to AUTHZ-04, CONF-05, CONF-09, INPV-20, APIT-01 | | | |
| op.acc.3 | Segregation of duties | IDNT-01, AUTHZ-02, AUTHZ-03, BUSL-06 | | | |
| op.acc.4 | Access rights management | IDNT-02, IDNT-03, ATHN-09, SESS-06, AUTHZ-03 | | | |
| op.acc.5 | Authentication mechanism | IDNT-04, IDNT-05, ATHN-01 to ATHN-10, SESS-01 to SESS-04, SESS-06 to SESS-09, INPV-06 | | | |
| op.acc.6 | Local access | ATHN-10 | | | |
| op.acc.7 | Remote access | ATHN-10, AUTHZ-01 | | | |

### op.exp — Operations

| ENS Control | Name | WSTG Tests | Result | Findings | Notes |
|---|---|---|---|---|---|
| op.exp.1 | Activity inventory | INFO-04 | | | Partial — inventory is broader than web discovery |
| op.exp.2 | Security configuration | INFO-02, INFO-03, INFO-05, INFO-08, INFO-09, CONF-01 to CONF-11, ERRH-01, ERRH-02, ATHN-02, INPV-03, INPV-16, INPV-17 | | | |
| op.exp.3 | Configuration management | CONF-02, CONF-04 | | | Partial — full change tracking is broader |
| op.exp.6 | Protection against DoS | BUSL-05 | | | Partial — infrastructure DoS not tested |
| op.exp.7 | Incident management | INPV-14, BUSL-07, BUSL-09 | | | Partial — process aspects not tested |
| op.exp.9 [M] | Security testing | _(all WSTG tests)_ | | | Running this audit satisfies op.exp.9 |

### op.nub — Cloud Services

| ENS Control | Name | WSTG Tests | Result | Findings | Notes |
|---|---|---|---|---|---|
| op.nub.1 | Cloud services | CONF-11 | | | Partial — cloud security is broader |

### op.mon — Monitoring

| ENS Control | Name | WSTG Tests | Result | Findings | Notes |
|---|---|---|---|---|---|
| op.mon.1 | Intrusion detection | INFO-01, IDNT-04, ATHN-03, BUSL-07 | | | Partial — monitoring infra not tested |

### mp.com — Communications

| ENS Control | Name | WSTG Tests | Result | Findings | Notes |
|---|---|---|---|---|---|
| mp.com.1 | Perimeter usage | CONF-01, CONF-10, INPV-19 | | | Partial — perimeter is primarily infra |
| mp.com.2 | Web browsing protection | CONF-07, CONF-08, SESS-02, SESS-05, INPV-01, INPV-15, CRYP-01, CLNT-01 to CLNT-05, CLNT-07 to CLNT-09, CLNT-11, CLNT-13, CLNT-14 | | | Strong coverage |
| mp.com.3 | Communications protection | ATHN-01, CRYP-01 to CRYP-04, SESS-09, CLNT-10 | | | |

### mp.sw — Software

| ENS Control | Name | WSTG Tests | Result | Findings | Notes |
|---|---|---|---|---|---|
| mp.sw.2 | Acceptance and commissioning | INFO-07, INPV-01 to INPV-20, BUSL-01 to BUSL-09, CLNT-01 to CLNT-14, APIT-01, ERRH-01 | | | Very strong coverage |

### mp.info — Information Protection

| ENS Control | Name | WSTG Tests | Result | Findings | Notes |
|---|---|---|---|---|---|
| mp.info.1 | Data classification | INFO-03, INFO-05, CONF-03, CONF-04, CONF-11, AUTHZ-01, AUTHZ-04, SESS-04, INPV-05, ERRH-01, ERRH-02, CRYP-03, CLNT-12 | | | |
| mp.info.2 | Information qualification | INPV-02, BUSL-01, BUSL-03, BUSL-08 | | | |
| mp.info.3 | Encryption of stored information | ATHN-05, CRYP-02, CRYP-04, CLNT-12 | | | |
| mp.info.4 | Electronic signature | CRYP-04 | | | Partial — signature validation is broader |

### mp.s — Services

| ENS Control | Name | WSTG Tests | Result | Findings | Notes |
|---|---|---|---|---|---|
| mp.s.1 | Electronic services protection | INFO-06, CONF-06, CONF-08, SESS-01, SESS-03, SESS-05, SESS-07 to SESS-09, INPV-01, INPV-02, INPV-04 to INPV-13, INPV-15, INPV-18, INPV-19, BUSL-02, BUSL-04, BUSL-05, BUSL-08, BUSL-09, CLNT-01, CLNT-03, CLNT-06, CLNT-07, CLNT-09, CLNT-10, CLNT-13, APIT-01, ERRH-01 | | | Very strong coverage |

## ENS Controls Requiring Separate Assessment

The following ENS controls are **outside WSTG scope** and require separate assessment. A WSTG audit does NOT provide evidence for these.

| ENS Family | Controls | Assessment Method |
|---|---|---|
| org (Organizational) | org.1 to org.4 | Policy review, management interview |
| op.pl (Planning) | op.pl.3, op.pl.4 | Procurement and capacity review |
| op.exp (Operations) | op.exp.4, op.exp.5, op.exp.8, op.exp.10, op.exp.11 | Process review, log analysis, IDS audit |
| op.ext (External) | op.ext.1, op.ext.2 | Contract review, SLA validation |
| op.cont (Continuity) | op.cont.1 to op.cont.4 | BCP/DR plan review and testing |
| op.mon (Monitoring) | op.mon.2, op.mon.3 | SIEM/SOC review |
| mp.if (Physical) | mp.if.1 to mp.if.7 | Physical security inspection |
| mp.per (Personnel) | mp.per.1 to mp.per.4 | HR process review |
| mp.eq (Equipment) | mp.eq.1 to mp.eq.4 | Endpoint security audit |
| mp.com (Communications) | mp.com.4 | Network architecture review |
| mp.si (Information media) | mp.si.1 to mp.si.5 | Media handling process review |
| mp.sw (Software) | mp.sw.1 | SDLC process review |
| mp.info (Information) | mp.info.5, mp.info.6 | Timestamping and sanitization review |

## ENS Findings Summary (by control)

_(Group findings by ENS control rather than WSTG category. For each affected ENS control, list:)_

### {{ENS_CONTROL_ID}} — {{ENS_CONTROL_NAME}}

**Status:** Non-Compliant / Partial / Compliant
**Mapped WSTG tests with findings:**

| WSTG ID | Test | Status | Severity | Finding # | Issue |
|---|---|---|---|---|---|
| | | | | | |

**Impact on ENS compliance:** _(Describe how this finding affects the ENS control requirement)_

---

## Traceability Matrix

| WSTG ID | Test | ENS Controls | Status | Finding # | Issue | Fix PR | Evidence |
|---|---|---|---|---|---|---|---|
| | | | | | | | |

---

## Disclaimers

1. **Scope limitation:** This report covers web application security testing (WSTG v4.2) only. ENS compliance requires additional assessments for organizational, physical, personnel, and infrastructure controls.
2. **Point-in-time assessment:** Results reflect the system state at the time of testing. Code changes after this date require retesting.
3. **Mapping interpretation:** The WSTG-to-ENS mapping is based on professional interpretation of both standards. Auditors may adjust individual mappings based on the specific system context.
4. **System category applicability:** Controls marked [M] or [A] only apply at Media or Alta classification. Verify the system category before determining compliance obligations.
