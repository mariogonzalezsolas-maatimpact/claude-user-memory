# WSTG Execution Checklist — {{PROJECT_NAME}}

**Execution tag:** {{EXECUTION_TAG}}
**Date:** {{DATE}}
**Performed by:** {{PERFORMER}}
**Scope:** {{SCOPE}}
**Standard:** OWASP WSTG v4.2

This checklist is filled in during a single WSTG audit execution. The final state is copied into `test-register.md` as new rows tagged with this execution.

## Legend

| Symbol | Meaning |
|---|---|
| ✅ OK | Test executed, no finding |
| ⚠️ Parcial | Control exists but improvable |
| ❌ Fallo | Confirmed finding (link to issue) |
| ⬜ Pendiente | Requires additional validation |
| N/A | Not applicable |

## INFO — Information Gathering

| ID | Test | Compliance Refs | Status | Evidence / Notes |
|---|---|---|---|---|
| WSTG-v42-INFO-01 | Search Engine Discovery | op.pl.1, op.mon.1 | | |
| WSTG-v42-INFO-02 | Fingerprint Web Server | op.exp.2, op.mon.1 | | |
| WSTG-v42-INFO-03 | Review Webserver Metafiles | op.exp.2, mp.info.1 | | |
| WSTG-v42-INFO-04 | Enumerate Applications on Webserver | op.exp.1, op.exp.2 | | |
| WSTG-v42-INFO-05 | Review Webpage Content for Leakage | mp.info.1, op.exp.2 | | |
| WSTG-v42-INFO-06 | Identify Application Entry Points | op.pl.1, mp.s.1 | | |
| WSTG-v42-INFO-07 | Map Execution Paths | op.pl.1, mp.sw.2 | | |
| WSTG-v42-INFO-08 | Fingerprint Web Application Framework | op.exp.2, op.pl.5 | | |
| WSTG-v42-INFO-09 | Fingerprint Web Application | op.exp.2, op.pl.5 | | |
| WSTG-v42-INFO-10 | Map Application Architecture | op.pl.2, op.pl.1 | | |

## CONF — Configuration and Deployment Management

| ID | Test | Compliance Refs | Status | Evidence / Notes |
|---|---|---|---|---|
| WSTG-v42-CONF-01 | Network Infrastructure Configuration | op.exp.2, mp.com.1 | | |
| WSTG-v42-CONF-02 | Application Platform Configuration | op.exp.2, op.exp.3 | | |
| WSTG-v42-CONF-03 | File Extensions Handling | op.exp.2, mp.info.1 | | |
| WSTG-v42-CONF-04 | Old Backup and Unreferenced Files | op.exp.2, op.exp.3, mp.info.1 | | |
| WSTG-v42-CONF-05 | Admin Interfaces Enumeration | op.acc.2, op.exp.2 | | |
| WSTG-v42-CONF-06 | HTTP Methods | op.exp.2, mp.s.1 | | |
| WSTG-v42-CONF-07 | HTTP Strict Transport Security | mp.com.2, op.exp.2 | | |
| WSTG-v42-CONF-08 | RIA Cross Domain Policy | mp.com.2, mp.s.1 | | |
| WSTG-v42-CONF-09 | File Permission | op.exp.2, op.acc.2 | | |
| WSTG-v42-CONF-10 | Subdomain Takeover | op.exp.2, mp.com.1 | | |
| WSTG-v42-CONF-11 | Cloud Storage | op.nub.1, op.exp.2, mp.info.1 | | |

## IDNT — Identity Management

| ID | Test | Compliance Refs | Status | Evidence / Notes |
|---|---|---|---|---|
| WSTG-v42-IDNT-01 | Role Definitions | op.acc.2, op.acc.3 | | |
| WSTG-v42-IDNT-02 | User Registration Process | op.acc.1, op.acc.4 | | |
| WSTG-v42-IDNT-03 | Account Provisioning Process | op.acc.4, op.acc.2 | | |
| WSTG-v42-IDNT-04 | Account Enumeration | op.acc.1, op.acc.5, op.mon.1 | | |
| WSTG-v42-IDNT-05 | Weak Username Policy | op.acc.1, op.acc.5 | | |

## ATHN — Authentication

| ID | Test | Compliance Refs | Status | Evidence / Notes |
|---|---|---|---|---|
| WSTG-v42-ATHN-01 | Credentials over Encrypted Channel | op.acc.5, mp.com.3 | | |
| WSTG-v42-ATHN-02 | Default Credentials | op.acc.5, op.exp.2 | | |
| WSTG-v42-ATHN-03 | Weak Lock Out Mechanism | op.acc.5, op.mon.1 | | |
| WSTG-v42-ATHN-04 | Bypassing Authentication Schema | op.acc.5, op.acc.2 | | |
| WSTG-v42-ATHN-05 | Vulnerable Remember Password | op.acc.5, mp.info.3 | | |
| WSTG-v42-ATHN-06 | Browser Cache Weaknesses | op.acc.5, mp.com.2 | | |
| WSTG-v42-ATHN-07 | Weak Password Policy | op.acc.5 | | |
| WSTG-v42-ATHN-08 | Weak Security Question Answer | op.acc.5 | | |
| WSTG-v42-ATHN-09 | Weak Password Change / Reset | op.acc.5, op.acc.4 | | |
| WSTG-v42-ATHN-10 | Weaker Auth in Alternative Channel | op.acc.5, op.acc.6, op.acc.7 | | |

## AUTHZ — Authorization

| ID | Test | Compliance Refs | Status | Evidence / Notes |
|---|---|---|---|---|
| WSTG-v42-AUTHZ-01 | Directory Traversal / File Include | op.acc.2, op.acc.7, mp.info.1 | | |
| WSTG-v42-AUTHZ-02 | Bypassing Authorization Schema | op.acc.2, op.acc.3 | | |
| WSTG-v42-AUTHZ-03 | Privilege Escalation | op.acc.2, op.acc.3, op.acc.4 | | |
| WSTG-v42-AUTHZ-04 | Insecure Direct Object References | op.acc.2, mp.info.1 | | |

## SESS — Session Management

| ID | Test | Compliance Refs | Status | Evidence / Notes |
|---|---|---|---|---|
| WSTG-v42-SESS-01 | Session Management Schema | op.acc.5, mp.s.1 | | |
| WSTG-v42-SESS-02 | Cookies Attributes | mp.com.2, op.acc.5 | | |
| WSTG-v42-SESS-03 | Session Fixation | op.acc.5, mp.s.1 | | |
| WSTG-v42-SESS-04 | Exposed Session Variables | op.acc.5, mp.info.1 | | |
| WSTG-v42-SESS-05 | Cross Site Request Forgery | mp.s.1, mp.com.2 | | |
| WSTG-v42-SESS-06 | Logout Functionality | op.acc.5, op.acc.4 | | |
| WSTG-v42-SESS-07 | Session Timeout | op.acc.5, mp.s.1 | | |
| WSTG-v42-SESS-08 | Session Puzzling | op.acc.5, mp.s.1 | | |
| WSTG-v42-SESS-09 | Session Hijacking | op.acc.5, mp.com.3, mp.s.1 | | |

## INPV — Input Validation

| ID | Test | Compliance Refs | Status | Evidence / Notes |
|---|---|---|---|---|
| WSTG-v42-INPV-01 | Reflected XSS | mp.sw.2, mp.s.1, mp.com.2 | | |
| WSTG-v42-INPV-02 | Stored XSS | mp.sw.2, mp.s.1, mp.info.2 | | |
| WSTG-v42-INPV-03 | HTTP Verb Tampering | mp.sw.2, op.exp.2 | | |
| WSTG-v42-INPV-04 | HTTP Parameter Pollution | mp.sw.2, mp.s.1 | | |
| WSTG-v42-INPV-05 | SQL Injection | mp.sw.2, mp.s.1, mp.info.1 | | |
| WSTG-v42-INPV-06 | LDAP Injection | mp.sw.2, op.acc.5 | | |
| WSTG-v42-INPV-07 | XML Injection | mp.sw.2, mp.s.1 | | |
| WSTG-v42-INPV-08 | SSI Injection | mp.sw.2, mp.s.1 | | |
| WSTG-v42-INPV-09 | XPath Injection | mp.sw.2, mp.s.1 | | |
| WSTG-v42-INPV-10 | IMAP/SMTP Injection | mp.sw.2, mp.s.1 | | |
| WSTG-v42-INPV-11 | Code Injection | mp.sw.2, mp.s.1 | | |
| WSTG-v42-INPV-12 | Command Injection | mp.sw.2, mp.s.1 | | |
| WSTG-v42-INPV-13 | Format String Injection | mp.sw.2, mp.s.1 | | |
| WSTG-v42-INPV-14 | Incubated Vulnerability | mp.sw.2, op.exp.7 | | |
| WSTG-v42-INPV-15 | HTTP Splitting / Smuggling | mp.sw.2, mp.com.2, mp.s.1 | | |
| WSTG-v42-INPV-16 | HTTP Incoming Requests | mp.sw.2, op.exp.2 | | |
| WSTG-v42-INPV-17 | Host Header Injection | mp.sw.2, op.exp.2 | | |
| WSTG-v42-INPV-18 | Server-Side Template Injection | mp.sw.2, mp.s.1 | | |
| WSTG-v42-INPV-19 | Server-Side Request Forgery | mp.sw.2, mp.com.1, mp.s.1 | | |
| WSTG-v42-INPV-20 | Mass Assignment | mp.sw.2, op.acc.2 | | |

## ERRH — Error Handling

| ID | Test | Compliance Refs | Status | Evidence / Notes |
|---|---|---|---|---|
| WSTG-v42-ERRH-01 | Improper Error Handling | op.exp.2, mp.info.1, mp.s.1 | | |
| WSTG-v42-ERRH-02 | Stack Traces | op.exp.2, mp.info.1 | | |

## CRYP — Cryptography

| ID | Test | Compliance Refs | Status | Evidence / Notes |
|---|---|---|---|---|
| WSTG-v42-CRYP-01 | Weak Transport Layer Security | mp.com.2, mp.com.3 | | |
| WSTG-v42-CRYP-02 | Padding Oracle | mp.com.3, mp.info.3 | | |
| WSTG-v42-CRYP-03 | Sensitive Info over Unencrypted Channels | mp.com.3, mp.info.1 | | |
| WSTG-v42-CRYP-04 | Weak Encryption | mp.com.3, mp.info.3, mp.info.4 | | |

## BUSL — Business Logic

| ID | Test | Compliance Refs | Status | Evidence / Notes |
|---|---|---|---|---|
| WSTG-v42-BUSL-01 | Business Logic Data Validation | mp.sw.2, mp.info.2 | | |
| WSTG-v42-BUSL-02 | Ability to Forge Requests | mp.sw.2, mp.s.1 | | |
| WSTG-v42-BUSL-03 | Integrity Checks | mp.sw.2, mp.info.2 | | |
| WSTG-v42-BUSL-04 | Process Timing | mp.sw.2, mp.s.1 | | |
| WSTG-v42-BUSL-05 | Number of Times a Function Can Be Used | mp.sw.2, op.exp.6 | | |
| WSTG-v42-BUSL-06 | Circumvention of Work Flows | mp.sw.2, op.acc.3 | | |
| WSTG-v42-BUSL-07 | Defenses Against Application Misuse | mp.sw.2, op.exp.7, op.mon.1 | | |
| WSTG-v42-BUSL-08 | Upload of Unexpected File Types | mp.sw.2, mp.s.1, mp.info.2 | | |
| WSTG-v42-BUSL-09 | Upload of Malicious Files | mp.sw.2, mp.s.1, op.exp.7 | | |

## CLNT — Client-Side

| ID | Test | Compliance Refs | Status | Evidence / Notes |
|---|---|---|---|---|
| WSTG-v42-CLNT-01 | DOM-Based XSS | mp.sw.2, mp.com.2, mp.s.1 | | |
| WSTG-v42-CLNT-02 | JavaScript Execution | mp.sw.2, mp.com.2 | | |
| WSTG-v42-CLNT-03 | HTML Injection | mp.sw.2, mp.com.2, mp.s.1 | | |
| WSTG-v42-CLNT-04 | Client-side URL Redirect | mp.sw.2, mp.com.2 | | |
| WSTG-v42-CLNT-05 | CSS Injection | mp.sw.2, mp.com.2 | | |
| WSTG-v42-CLNT-06 | Client-side Resource Manipulation | mp.sw.2, mp.s.1 | | |
| WSTG-v42-CLNT-07 | CORS | mp.sw.2, mp.com.2, mp.s.1 | | |
| WSTG-v42-CLNT-08 | Cross Site Flashing | mp.sw.2, mp.com.2 | | |
| WSTG-v42-CLNT-09 | Clickjacking | mp.sw.2, mp.com.2, mp.s.1 | | |
| WSTG-v42-CLNT-10 | WebSockets | mp.sw.2, mp.com.3, mp.s.1 | | |
| WSTG-v42-CLNT-11 | Web Messaging | mp.sw.2, mp.com.2 | | |
| WSTG-v42-CLNT-12 | Browser Storage | mp.sw.2, mp.info.1, mp.info.3 | | |
| WSTG-v42-CLNT-13 | Cross Site Script Inclusion | mp.sw.2, mp.com.2, mp.s.1 | | |
| WSTG-v42-CLNT-14 | Reverse Tabnabbing | mp.sw.2, mp.com.2 | | |

## APIT — API Testing

| ID | Test | Compliance Refs | Status | Evidence / Notes |
|---|---|---|---|---|
| WSTG-v42-APIT-01 | GraphQL | mp.sw.2, mp.s.1, op.acc.2 | | |

## Summary

| Status | Count |
|---|---|
| ✅ OK | |
| ⚠️ Parcial | |
| ❌ Fallo | |
| ⬜ Pendiente | |
| N/A | |
| **Total** | |

## Notes

_(Free-form notes about scope decisions, tooling used, environment, and any deviations from the standard protocol.)_
