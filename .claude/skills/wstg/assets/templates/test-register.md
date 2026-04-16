# WSTG Test Register — {{PROJECT_NAME}}

**Standard:** OWASP Web Security Testing Guide v4.2
**Project:** {{PROJECT_NAME}}
**Scope:** {{SCOPE_DESCRIPTION}}

This is the cumulative register of all WSTG tests executed against this project. **Rows are never deleted** — each audit execution adds new rows so the full history is preserved.

## Legend

| Symbol | Meaning |
|---|---|
| ✅ OK | Test executed, no finding |
| ⚠️ Parcial / Partial | Control exists but is improvable |
| ❌ Fallo / Fail | Confirmed finding (linked to an issue) |
| ⬜ Pendiente / Pending | Requires additional validation or manual review |
| N/A | Not applicable to this architecture |

## Summary (latest execution)

| Status | Count |
|---|---|
| ✅ OK | 0 |
| ⚠️ Parcial | 0 |
| ❌ Fallo | 0 |
| ⬜ Pendiente | 0 |
| N/A | 0 |
| **Total** | **0** |

## Executions

| Execution Tag | Date | Scope | Performed By |
|---|---|---|---|
| _(first execution will appear here)_ | | | |

## Test Results

| WSTG ID | Test Name | Category | Compliance Refs | Latest Status | Execution | Evidence | Finding ID |
|---|---|---|---|---|---|---|---|
| WSTG-v42-INFO-01 | Conduct Search Engine Discovery Reconnaissance | INFO | op.pl.1, op.mon.1 | | | | |
| WSTG-v42-INFO-02 | Fingerprint Web Server | INFO | op.exp.2, op.mon.1 | | | | |
| WSTG-v42-INFO-03 | Review Webserver Metafiles for Information Leakage | INFO | op.exp.2, mp.info.1 | | | | |
| WSTG-v42-INFO-04 | Enumerate Applications on Webserver | INFO | op.exp.1, op.exp.2 | | | | |
| WSTG-v42-INFO-05 | Review Webpage Content for Information Leakage | INFO | mp.info.1, op.exp.2 | | | | |
| WSTG-v42-INFO-06 | Identify Application Entry Points | INFO | op.pl.1, mp.s.1 | | | | |
| WSTG-v42-INFO-07 | Map Execution Paths Through Application | INFO | op.pl.1, mp.sw.2 | | | | |
| WSTG-v42-INFO-08 | Fingerprint Web Application Framework | INFO | op.exp.2, op.pl.5 | | | | |
| WSTG-v42-INFO-09 | Fingerprint Web Application | INFO | op.exp.2, op.pl.5 | | | | |
| WSTG-v42-INFO-10 | Map Application Architecture | INFO | op.pl.2, op.pl.1 | | | | |
| WSTG-v42-CONF-01 | Test Network Infrastructure Configuration | CONF | op.exp.2, mp.com.1 | | | | |
| WSTG-v42-CONF-02 | Test Application Platform Configuration | CONF | op.exp.2, op.exp.3 | | | | |
| WSTG-v42-CONF-03 | Test File Extensions Handling for Sensitive Information | CONF | op.exp.2, mp.info.1 | | | | |
| WSTG-v42-CONF-04 | Review Old Backup and Unreferenced Files | CONF | op.exp.2, op.exp.3, mp.info.1 | | | | |
| WSTG-v42-CONF-05 | Enumerate Infrastructure and Application Admin Interfaces | CONF | op.acc.2, op.exp.2 | | | | |
| WSTG-v42-CONF-06 | Test HTTP Methods | CONF | op.exp.2, mp.s.1 | | | | |
| WSTG-v42-CONF-07 | Test HTTP Strict Transport Security | CONF | mp.com.2, op.exp.2 | | | | |
| WSTG-v42-CONF-08 | Test RIA Cross Domain Policy | CONF | mp.com.2, mp.s.1 | | | | |
| WSTG-v42-CONF-09 | Test File Permission | CONF | op.exp.2, op.acc.2 | | | | |
| WSTG-v42-CONF-10 | Test for Subdomain Takeover | CONF | op.exp.2, mp.com.1 | | | | |
| WSTG-v42-CONF-11 | Test Cloud Storage | CONF | op.nub.1, op.exp.2, mp.info.1 | | | | |
| WSTG-v42-IDNT-01 | Test Role Definitions | IDNT | op.acc.2, op.acc.3 | | | | |
| WSTG-v42-IDNT-02 | Test User Registration Process | IDNT | op.acc.1, op.acc.4 | | | | |
| WSTG-v42-IDNT-03 | Test Account Provisioning Process | IDNT | op.acc.4, op.acc.2 | | | | |
| WSTG-v42-IDNT-04 | Testing for Account Enumeration and Guessable User Account | IDNT | op.acc.1, op.acc.5, op.mon.1 | | | | |
| WSTG-v42-IDNT-05 | Testing for Weak or Unenforced Username Policy | IDNT | op.acc.1, op.acc.5 | | | | |
| WSTG-v42-ATHN-01 | Testing for Credentials Transported over an Encrypted Channel | ATHN | op.acc.5, mp.com.3 | | | | |
| WSTG-v42-ATHN-02 | Testing for Default Credentials | ATHN | op.acc.5, op.exp.2 | | | | |
| WSTG-v42-ATHN-03 | Testing for Weak Lock Out Mechanism | ATHN | op.acc.5, op.mon.1 | | | | |
| WSTG-v42-ATHN-04 | Testing for Bypassing Authentication Schema | ATHN | op.acc.5, op.acc.2 | | | | |
| WSTG-v42-ATHN-05 | Testing for Vulnerable Remember Password | ATHN | op.acc.5, mp.info.3 | | | | |
| WSTG-v42-ATHN-06 | Testing for Browser Cache Weaknesses | ATHN | op.acc.5, mp.com.2 | | | | |
| WSTG-v42-ATHN-07 | Testing for Weak Password Policy | ATHN | op.acc.5 | | | | |
| WSTG-v42-ATHN-08 | Testing for Weak Security Question Answer | ATHN | op.acc.5 | | | | |
| WSTG-v42-ATHN-09 | Testing for Weak Password Change or Reset Functionalities | ATHN | op.acc.5, op.acc.4 | | | | |
| WSTG-v42-ATHN-10 | Testing for Weaker Authentication in Alternative Channel | ATHN | op.acc.5, op.acc.6, op.acc.7 | | | | |
| WSTG-v42-AUTHZ-01 | Testing Directory Traversal File Include | AUTHZ | op.acc.2, op.acc.7, mp.info.1 | | | | |
| WSTG-v42-AUTHZ-02 | Testing for Bypassing Authorization Schema | AUTHZ | op.acc.2, op.acc.3 | | | | |
| WSTG-v42-AUTHZ-03 | Testing for Privilege Escalation | AUTHZ | op.acc.2, op.acc.3, op.acc.4 | | | | |
| WSTG-v42-AUTHZ-04 | Testing for Insecure Direct Object References | AUTHZ | op.acc.2, mp.info.1 | | | | |
| WSTG-v42-SESS-01 | Testing for Session Management Schema | SESS | op.acc.5, mp.s.1 | | | | |
| WSTG-v42-SESS-02 | Testing for Cookies Attributes | SESS | mp.com.2, op.acc.5 | | | | |
| WSTG-v42-SESS-03 | Testing for Session Fixation | SESS | op.acc.5, mp.s.1 | | | | |
| WSTG-v42-SESS-04 | Testing for Exposed Session Variables | SESS | op.acc.5, mp.info.1 | | | | |
| WSTG-v42-SESS-05 | Testing for Cross Site Request Forgery | SESS | mp.s.1, mp.com.2 | | | | |
| WSTG-v42-SESS-06 | Testing for Logout Functionality | SESS | op.acc.5, op.acc.4 | | | | |
| WSTG-v42-SESS-07 | Testing Session Timeout | SESS | op.acc.5, mp.s.1 | | | | |
| WSTG-v42-SESS-08 | Testing for Session Puzzling | SESS | op.acc.5, mp.s.1 | | | | |
| WSTG-v42-SESS-09 | Testing for Session Hijacking | SESS | op.acc.5, mp.com.3, mp.s.1 | | | | |
| WSTG-v42-INPV-01 | Testing for Reflected Cross Site Scripting | INPV | mp.sw.2, mp.s.1, mp.com.2 | | | | |
| WSTG-v42-INPV-02 | Testing for Stored Cross Site Scripting | INPV | mp.sw.2, mp.s.1, mp.info.2 | | | | |
| WSTG-v42-INPV-03 | Testing for HTTP Verb Tampering | INPV | mp.sw.2, op.exp.2 | | | | |
| WSTG-v42-INPV-04 | Testing for HTTP Parameter Pollution | INPV | mp.sw.2, mp.s.1 | | | | |
| WSTG-v42-INPV-05 | Testing for SQL Injection | INPV | mp.sw.2, mp.s.1, mp.info.1 | | | | |
| WSTG-v42-INPV-06 | Testing for LDAP Injection | INPV | mp.sw.2, op.acc.5 | | | | |
| WSTG-v42-INPV-07 | Testing for XML Injection | INPV | mp.sw.2, mp.s.1 | | | | |
| WSTG-v42-INPV-08 | Testing for SSI Injection | INPV | mp.sw.2, mp.s.1 | | | | |
| WSTG-v42-INPV-09 | Testing for XPath Injection | INPV | mp.sw.2, mp.s.1 | | | | |
| WSTG-v42-INPV-10 | Testing for IMAP/SMTP Injection | INPV | mp.sw.2, mp.s.1 | | | | |
| WSTG-v42-INPV-11 | Testing for Code Injection | INPV | mp.sw.2, mp.s.1 | | | | |
| WSTG-v42-INPV-12 | Testing for Command Injection | INPV | mp.sw.2, mp.s.1 | | | | |
| WSTG-v42-INPV-13 | Testing for Format String Injection | INPV | mp.sw.2, mp.s.1 | | | | |
| WSTG-v42-INPV-14 | Testing for Incubated Vulnerability | INPV | mp.sw.2, op.exp.7 | | | | |
| WSTG-v42-INPV-15 | Testing for HTTP Splitting Smuggling | INPV | mp.sw.2, mp.com.2, mp.s.1 | | | | |
| WSTG-v42-INPV-16 | Testing for HTTP Incoming Requests | INPV | mp.sw.2, op.exp.2 | | | | |
| WSTG-v42-INPV-17 | Testing for Host Header Injection | INPV | mp.sw.2, op.exp.2 | | | | |
| WSTG-v42-INPV-18 | Testing for Server-Side Template Injection | INPV | mp.sw.2, mp.s.1 | | | | |
| WSTG-v42-INPV-19 | Testing for Server-Side Request Forgery | INPV | mp.sw.2, mp.com.1, mp.s.1 | | | | |
| WSTG-v42-INPV-20 | Testing for Mass Assignment | INPV | mp.sw.2, op.acc.2 | | | | |
| WSTG-v42-ERRH-01 | Testing for Improper Error Handling | ERRH | op.exp.2, mp.info.1, mp.s.1 | | | | |
| WSTG-v42-ERRH-02 | Testing for Stack Traces | ERRH | op.exp.2, mp.info.1 | | | | |
| WSTG-v42-CRYP-01 | Testing for Weak Transport Layer Security | CRYP | mp.com.2, mp.com.3 | | | | |
| WSTG-v42-CRYP-02 | Testing for Padding Oracle | CRYP | mp.com.3, mp.info.3 | | | | |
| WSTG-v42-CRYP-03 | Testing for Sensitive Information Sent via Unencrypted Channels | CRYP | mp.com.3, mp.info.1 | | | | |
| WSTG-v42-CRYP-04 | Testing for Weak Encryption | CRYP | mp.com.3, mp.info.3, mp.info.4 | | | | |
| WSTG-v42-BUSL-01 | Test Business Logic Data Validation | BUSL | mp.sw.2, mp.info.2 | | | | |
| WSTG-v42-BUSL-02 | Test Ability to Forge Requests | BUSL | mp.sw.2, mp.s.1 | | | | |
| WSTG-v42-BUSL-03 | Test Integrity Checks | BUSL | mp.sw.2, mp.info.2 | | | | |
| WSTG-v42-BUSL-04 | Test for Process Timing | BUSL | mp.sw.2, mp.s.1 | | | | |
| WSTG-v42-BUSL-05 | Test Number of Times a Function Can Be Used | BUSL | mp.sw.2, op.exp.6 | | | | |
| WSTG-v42-BUSL-06 | Testing for the Circumvention of Work Flows | BUSL | mp.sw.2, op.acc.3 | | | | |
| WSTG-v42-BUSL-07 | Test Defenses Against Application Misuse | BUSL | mp.sw.2, op.exp.7, op.mon.1 | | | | |
| WSTG-v42-BUSL-08 | Test Upload of Unexpected File Types | BUSL | mp.sw.2, mp.s.1, mp.info.2 | | | | |
| WSTG-v42-BUSL-09 | Test Upload of Malicious Files | BUSL | mp.sw.2, mp.s.1, op.exp.7 | | | | |
| WSTG-v42-CLNT-01 | Testing for DOM-Based Cross Site Scripting | CLNT | mp.sw.2, mp.com.2, mp.s.1 | | | | |
| WSTG-v42-CLNT-02 | Testing for JavaScript Execution | CLNT | mp.sw.2, mp.com.2 | | | | |
| WSTG-v42-CLNT-03 | Testing for HTML Injection | CLNT | mp.sw.2, mp.com.2, mp.s.1 | | | | |
| WSTG-v42-CLNT-04 | Testing for Client-side URL Redirect | CLNT | mp.sw.2, mp.com.2 | | | | |
| WSTG-v42-CLNT-05 | Testing for CSS Injection | CLNT | mp.sw.2, mp.com.2 | | | | |
| WSTG-v42-CLNT-06 | Testing for Client-side Resource Manipulation | CLNT | mp.sw.2, mp.s.1 | | | | |
| WSTG-v42-CLNT-07 | Testing Cross Origin Resource Sharing | CLNT | mp.sw.2, mp.com.2, mp.s.1 | | | | |
| WSTG-v42-CLNT-08 | Testing for Cross Site Flashing | CLNT | mp.sw.2, mp.com.2 | | | | |
| WSTG-v42-CLNT-09 | Testing for Clickjacking | CLNT | mp.sw.2, mp.com.2, mp.s.1 | | | | |
| WSTG-v42-CLNT-10 | Testing WebSockets | CLNT | mp.sw.2, mp.com.3, mp.s.1 | | | | |
| WSTG-v42-CLNT-11 | Testing Web Messaging | CLNT | mp.sw.2, mp.com.2 | | | | |
| WSTG-v42-CLNT-12 | Testing Browser Storage | CLNT | mp.sw.2, mp.info.1, mp.info.3 | | | | |
| WSTG-v42-CLNT-13 | Testing for Cross Site Script Inclusion | CLNT | mp.sw.2, mp.com.2, mp.s.1 | | | | |
| WSTG-v42-CLNT-14 | Testing for Reverse Tabnabbing | CLNT | mp.sw.2, mp.com.2 | | | | |
| WSTG-v42-APIT-01 | Testing GraphQL | APIT | mp.sw.2, mp.s.1, op.acc.2 | | | | |

## History

Each execution appends a section here with the date, scope, performer, and a copy of the status snapshot at the time of execution. Do not rewrite history.

### {{EXECUTION_TAG}} — {{DATE}}

- **Scope:** {{SCOPE}}
- **Performed by:** {{PERFORMER}}
- **Checklist file:** `executions/{{DATE}}-{{TAG}}-checklist.md`
- **Findings file:** `executions/{{DATE}}-{{TAG}}-findings.md`
- **Summary:** _(counts by status)_
