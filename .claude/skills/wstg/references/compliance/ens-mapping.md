# ENS (RD 311/2022) — WSTG v4.2 Control Mapping

## About this mapping

The **Esquema Nacional de Seguridad** (ENS), regulated by Real Decreto 311/2022, is the Spanish national framework for information security in the public sector and its supply chain. It defines security controls organized in three frameworks: organizational (org), operational (op), and protective measures (mp).

This file maps each OWASP WSTG v4.2 test to the ENS controls it helps satisfy. The mapping enables:
- Auditors to trace from ENS control requirements to concrete test evidence
- Reports to show which ENS controls are impacted by a finding
- Gap analysis to identify ENS controls that require assessment beyond WSTG

**Important:** This mapping is interpretive. WSTG tests web application security; ENS covers a broader scope including physical, personnel, and organizational controls. A passing WSTG test contributes evidence toward an ENS control but may not fully satisfy it. The rationale column explains each mapping decision so auditors can challenge or validate it.

### ENS system categories

ENS applicability depends on the system's classification level. Some controls only apply at higher levels:

| Level | Applies to |
|---|---|
| **Basica** | All systems. Core security controls. |
| **Media** | Systems handling medium-impact data. Adds monitoring, incident response, access logging. |
| **Alta** | Systems handling high-impact data. Adds advanced crypto, continuous monitoring, formal audits. |

Controls marked with `[M]` apply from Media upward. Controls marked with `[A]` apply only at Alta. Unmarked controls apply at all levels.

## ENS Control Reference

### org — Organizational framework

| Control | Name | Description |
|---|---|---|
| org.1 | Security policy | Organization-wide security policy document |
| org.2 | Security regulations | Detailed security norms and procedures |
| org.3 | Security procedures | Operational security procedures |
| org.4 | Authorization process | Formal authorization for system use |

### op — Operational framework

| Control | Name | Description |
|---|---|---|
| op.pl.1 | Risk analysis | Identify and assess security risks |
| op.pl.2 | Security architecture | Design secure system architecture |
| op.pl.3 | Procurement | Security requirements in procurement |
| op.pl.4 | System dimensioning | Capacity planning and resource allocation |
| op.pl.5 | Component lifecycle | Manage component updates and EOL |
| op.acc.1 | Identification | Unique identification of users and processes |
| op.acc.2 | Access requirements | Define who can access what and under what conditions |
| op.acc.3 | Segregation of duties | Prevent conflicts of interest in access |
| op.acc.4 | Access rights management | Provisioning, review, and revocation of access |
| op.acc.5 | Authentication mechanism | Verify identity before granting access |
| op.acc.6 | Local access | Controls for local/physical access to systems |
| op.acc.7 | Remote access | Controls for remote access to systems |
| op.exp.1 | Activity inventory | Maintain inventory of systems and assets |
| op.exp.2 | Security configuration | Harden and configure systems securely |
| op.exp.3 | Configuration management | Track and control configuration changes |
| op.exp.4 | Maintenance | Secure maintenance processes |
| op.exp.5 | Change management | Controlled change process with security review |
| op.exp.6 | Protection against DoS | Prevent denial of service attacks |
| op.exp.7 | Incident management | Detect, respond to, and learn from incidents |
| op.exp.8 [M] | Incident logging | Record security events and incidents |
| op.exp.9 [M] | Security testing | Periodic security testing of systems |
| op.exp.10 [A] | Intrusion detection | Active detection of intrusion attempts |
| op.exp.11 [A] | Metrics collection | Collect and analyze security metrics |
| op.ext.1 | Outsourced services | Security requirements for external providers |
| op.ext.2 | External personnel | Security obligations for external staff |
| op.nub.1 | Cloud services | Security controls for cloud environments |
| op.cont.1 | Impact analysis | Analyze impact of service interruption |
| op.cont.2 | Continuity plan | Plan for service continuity |
| op.cont.3 | Periodic testing | Test continuity plans periodically |
| op.cont.4 [A] | Alternative means | Backup facilities and redundancy |
| op.mon.1 | Intrusion detection | Monitor for security events |
| op.mon.2 [M] | Metrics system | Systematic security metrics collection |
| op.mon.3 [A] | Surveillance | Continuous security surveillance |

### mp — Protective measures

| Control | Name | Description |
|---|---|---|
| mp.if.1 | Separate areas | Physical zones with different security levels |
| mp.if.2 | Identification of persons | Identify people accessing facilities |
| mp.if.3 | Physical conditioning | Environmental controls (HVAC, fire, etc.) |
| mp.if.4 | Power supply | Uninterruptible power and electrical protection |
| mp.if.5 | Fire protection | Fire detection and suppression |
| mp.if.6 | Flood protection | Water damage prevention |
| mp.if.7 | Secure cabling | Protected physical infrastructure |
| mp.per.1 | Job characterization | Define security roles and responsibilities |
| mp.per.2 | Training | Security awareness and training |
| mp.per.3 | Workplace awareness | Encourage security-conscious behavior |
| mp.per.4 | Personnel departure | Revoke access when staff leave |
| mp.eq.1 | Clear desk | Protect information on desks/screens |
| mp.eq.2 | Device lockdown | Lock workstations when unattended |
| mp.eq.3 | Device protection | Protect devices from theft/damage |
| mp.eq.4 | Mobile devices | Security for laptops, phones, tablets |
| mp.com.1 | Perimeter usage | Control network perimeter (firewalls, DMZ) |
| mp.com.2 | Web browsing protection | Secure web communications (TLS, headers) |
| mp.com.3 | Communications protection | Encrypt and authenticate network communications |
| mp.com.4 [M] | Network segregation | Separate networks by security level |
| mp.si.1 | Marking | Label information media by classification |
| mp.si.2 | Cryptographic protection of media | Encrypt stored media |
| mp.si.3 | Media cleaning | Securely erase data from media |
| mp.si.4 | Media transport | Protect media during transport |
| mp.si.5 | Media destruction | Securely destroy media at end of life |
| mp.sw.1 | Application development | Secure development lifecycle |
| mp.sw.2 | Acceptance and commissioning | Test and validate before deployment |
| mp.info.1 | Data classification | Classify information by sensitivity |
| mp.info.2 | Information qualification | Validate data quality and integrity |
| mp.info.3 | Encryption of stored information | Encrypt data at rest |
| mp.info.4 | Electronic signature | Digital signatures for integrity/authenticity |
| mp.info.5 [M] | Timestamps | Reliable timestamping of records |
| mp.info.6 [A] | Information cleaning | Sanitize data before sharing or disposal |
| mp.s.1 | Electronic services protection | Protect web services and APIs |
| mp.s.2 | Web portal protection | Protect user-facing web portals |

---

## Forward Mapping: WSTG Test → ENS Controls

### INFO — Information Gathering

| WSTG ID | Test Name | ENS Controls | Rationale |
|---|---|---|---|
| WSTG-v42-INFO-01 | Search Engine Discovery Reconnaissance | op.pl.1, op.mon.1 | Search engine exposure reveals information an attacker can use (risk analysis); detecting such exposure is a monitoring concern |
| WSTG-v42-INFO-02 | Fingerprint Web Server | op.exp.2, op.mon.1 | Server fingerprinting exposes configuration weaknesses; hardened configuration should prevent version disclosure |
| WSTG-v42-INFO-03 | Review Webserver Metafiles for Information Leakage | op.exp.2, mp.info.1 | Metafile leakage is a configuration issue; exposed metadata may reveal classified information |
| WSTG-v42-INFO-04 | Enumerate Applications on Webserver | op.exp.1, op.exp.2 | Undocumented applications violate activity inventory; their exposure is a configuration failure |
| WSTG-v42-INFO-05 | Review Webpage Content for Information Leakage | mp.info.1, op.exp.2 | Content leaking internal data violates data classification; is also a configuration hardening gap |
| WSTG-v42-INFO-06 | Identify Application Entry Points | op.pl.1, mp.s.1 | Entry point mapping is essential for risk analysis; each entry point must be protected as part of service protection |
| WSTG-v42-INFO-07 | Map Execution Paths Through Application | op.pl.1, mp.sw.2 | Understanding execution paths is risk analysis; paths should be validated during acceptance testing |
| WSTG-v42-INFO-08 | Fingerprint Web Application Framework | op.exp.2, op.pl.5 | Framework fingerprinting is a configuration issue; known framework versions relate to component lifecycle management |
| WSTG-v42-INFO-09 | Fingerprint Web Application | op.exp.2, op.pl.5 | Application version disclosure is a configuration hardening gap; relates to component lifecycle |
| WSTG-v42-INFO-10 | Map Application Architecture | op.pl.2, op.pl.1 | Architecture mapping informs security architecture design and risk analysis |

### CONF — Configuration and Deployment Management

| WSTG ID | Test Name | ENS Controls | Rationale |
|---|---|---|---|
| WSTG-v42-CONF-01 | Test Network Infrastructure Configuration | op.exp.2, mp.com.1 | Network misconfiguration is a hardening failure; perimeter controls must be properly configured |
| WSTG-v42-CONF-02 | Test Application Platform Configuration | op.exp.2, op.exp.3 | Platform configuration must be hardened and tracked in configuration management |
| WSTG-v42-CONF-03 | Test File Extensions Handling for Sensitive Information | op.exp.2, mp.info.1 | Improper file handling exposes sensitive data; configuration must prevent disclosure |
| WSTG-v42-CONF-04 | Review Old Backup and Unreferenced Files | op.exp.2, op.exp.3, mp.info.1 | Leftover files are a configuration management failure; may expose classified data |
| WSTG-v42-CONF-05 | Enumerate Infrastructure and Application Admin Interfaces | op.acc.2, op.exp.2 | Admin interfaces must have restricted access requirements; their exposure is a configuration failure |
| WSTG-v42-CONF-06 | Test HTTP Methods | op.exp.2, mp.s.1 | Unrestricted HTTP methods are a configuration hardening gap; affects service protection |
| WSTG-v42-CONF-07 | Test HTTP Strict Transport Security | mp.com.2, op.exp.2 | HSTS is a web browsing protection control; its absence is a configuration gap |
| WSTG-v42-CONF-08 | Test RIA Cross Domain Policy | mp.com.2, mp.s.1 | Cross-domain policies affect web browsing protection and service security |
| WSTG-v42-CONF-09 | Test File Permission | op.exp.2, op.acc.2 | File permissions are a configuration hardening and access control requirement |
| WSTG-v42-CONF-10 | Test for Subdomain Takeover | op.exp.2, mp.com.1 | Subdomain takeover is a configuration failure affecting perimeter integrity |
| WSTG-v42-CONF-11 | Test Cloud Storage | op.nub.1, op.exp.2, mp.info.1 | Cloud storage misconfiguration violates cloud security controls; may expose classified data |

### IDNT — Identity Management

| WSTG ID | Test Name | ENS Controls | Rationale |
|---|---|---|---|
| WSTG-v42-IDNT-01 | Test Role Definitions | op.acc.2, op.acc.3 | Role definitions implement access requirements and segregation of duties |
| WSTG-v42-IDNT-02 | Test User Registration Process | op.acc.1, op.acc.4 | Registration is part of identification and access rights management |
| WSTG-v42-IDNT-03 | Test Account Provisioning Process | op.acc.4, op.acc.2 | Provisioning implements access rights management under defined access requirements |
| WSTG-v42-IDNT-04 | Testing for Account Enumeration | op.acc.1, op.acc.5, op.mon.1 | Enumeration undermines identification; indicates weak authentication; should be detected by monitoring |
| WSTG-v42-IDNT-05 | Testing for Weak Username Policy | op.acc.1, op.acc.5 | Weak usernames undermine identification uniqueness and authentication security |

### ATHN — Authentication

| WSTG ID | Test Name | ENS Controls | Rationale |
|---|---|---|---|
| WSTG-v42-ATHN-01 | Credentials Transported over Encrypted Channel | op.acc.5, mp.com.3 | Credential transmission must use authenticated encryption; ENS requires encrypted communications |
| WSTG-v42-ATHN-02 | Default Credentials | op.acc.5, op.exp.2 | Default credentials are an authentication failure and a configuration hardening gap |
| WSTG-v42-ATHN-03 | Weak Lock Out Mechanism | op.acc.5, op.mon.1 | Lockout is part of authentication mechanism; brute force attempts should be monitored |
| WSTG-v42-ATHN-04 | Bypassing Authentication Schema | op.acc.5, op.acc.2 | Auth bypass violates the authentication mechanism and access requirements |
| WSTG-v42-ATHN-05 | Vulnerable Remember Password | op.acc.5, mp.info.3 | Insecure credential storage on client affects authentication and stored data encryption |
| WSTG-v42-ATHN-06 | Browser Cache Weaknesses | op.acc.5, mp.com.2 | Cached credentials are an authentication risk; web browsing protection must prevent this |
| WSTG-v42-ATHN-07 | Weak Password Policy | op.acc.5 | Password policy is a core component of the authentication mechanism |
| WSTG-v42-ATHN-08 | Weak Security Question Answer | op.acc.5 | Security questions are an authentication mechanism; weak ones undermine identity verification |
| WSTG-v42-ATHN-09 | Weak Password Change or Reset | op.acc.5, op.acc.4 | Password reset is part of authentication mechanism and access rights management lifecycle |
| WSTG-v42-ATHN-10 | Weaker Authentication in Alternative Channel | op.acc.5, op.acc.6, op.acc.7 | Alternative channels must meet the same authentication standard; covers local and remote access |

### AUTHZ — Authorization

| WSTG ID | Test Name | ENS Controls | Rationale |
|---|---|---|---|
| WSTG-v42-AUTHZ-01 | Directory Traversal / File Include | op.acc.2, op.acc.7, mp.info.1 | Path traversal bypasses access requirements; may expose classified data; relates to remote access controls |
| WSTG-v42-AUTHZ-02 | Bypassing Authorization Schema | op.acc.2, op.acc.3 | Authorization bypass violates access requirements and may break segregation of duties |
| WSTG-v42-AUTHZ-03 | Privilege Escalation | op.acc.2, op.acc.3, op.acc.4 | Escalation violates access requirements, segregation of duties, and access rights management |
| WSTG-v42-AUTHZ-04 | Insecure Direct Object References | op.acc.2, mp.info.1 | IDOR bypasses access requirements; may expose data beyond the user's classification level |

### SESS — Session Management

| WSTG ID | Test Name | ENS Controls | Rationale |
|---|---|---|---|
| WSTG-v42-SESS-01 | Session Management Schema | op.acc.5, mp.s.1 | Session management extends the authentication mechanism; protects service integrity |
| WSTG-v42-SESS-02 | Cookies Attributes | mp.com.2, op.acc.5 | Cookie security is web browsing protection; insecure cookies undermine authentication |
| WSTG-v42-SESS-03 | Session Fixation | op.acc.5, mp.s.1 | Session fixation is an authentication bypass; compromises service protection |
| WSTG-v42-SESS-04 | Exposed Session Variables | op.acc.5, mp.info.1 | Exposed session data is an authentication risk; may leak classified information |
| WSTG-v42-SESS-05 | Cross Site Request Forgery | mp.s.1, mp.com.2 | CSRF attacks compromise service integrity and web browsing protection |
| WSTG-v42-SESS-06 | Logout Functionality | op.acc.5, op.acc.4 | Proper logout is part of authentication mechanism and access lifecycle management |
| WSTG-v42-SESS-07 | Session Timeout | op.acc.5, mp.s.1 | Session timeout is part of authentication mechanism and service protection |
| WSTG-v42-SESS-08 | Session Puzzling | op.acc.5, mp.s.1 | Session confusion undermines authentication integrity and service protection |
| WSTG-v42-SESS-09 | Session Hijacking | op.acc.5, mp.com.3, mp.s.1 | Session hijacking bypasses authentication; encrypted communications prevent interception |

### INPV — Input Validation

| WSTG ID | Test Name | ENS Controls | Rationale |
|---|---|---|---|
| WSTG-v42-INPV-01 | Reflected Cross Site Scripting | mp.sw.2, mp.s.1, mp.com.2 | XSS is an application security defect (acceptance testing); compromises service and browsing protection |
| WSTG-v42-INPV-02 | Stored Cross Site Scripting | mp.sw.2, mp.s.1, mp.info.2 | Stored XSS persists malicious data (information qualification); application security defect |
| WSTG-v42-INPV-03 | HTTP Verb Tampering | mp.sw.2, op.exp.2 | Verb tampering is an application defect and configuration hardening gap |
| WSTG-v42-INPV-04 | HTTP Parameter Pollution | mp.sw.2, mp.s.1 | Parameter pollution is an application security defect affecting service protection |
| WSTG-v42-INPV-05 | SQL Injection | mp.sw.2, mp.s.1, mp.info.1 | SQLi is a critical application defect; may expose classified data; compromises service |
| WSTG-v42-INPV-06 | LDAP Injection | mp.sw.2, op.acc.5 | LDAP injection is an application defect that may bypass authentication |
| WSTG-v42-INPV-07 | XML Injection | mp.sw.2, mp.s.1 | XML injection is an application security defect affecting service integrity |
| WSTG-v42-INPV-08 | SSI Injection | mp.sw.2, mp.s.1 | SSI injection is an application defect enabling server-side code execution |
| WSTG-v42-INPV-09 | XPath Injection | mp.sw.2, mp.s.1 | XPath injection is an application defect affecting data query integrity |
| WSTG-v42-INPV-10 | IMAP/SMTP Injection | mp.sw.2, mp.s.1 | Mail injection is an application defect that can abuse messaging services |
| WSTG-v42-INPV-11 | Code Injection | mp.sw.2, mp.s.1 | Code injection is a critical application defect enabling arbitrary execution |
| WSTG-v42-INPV-12 | Command Injection | mp.sw.2, mp.s.1 | Command injection is a critical application defect enabling OS-level access |
| WSTG-v42-INPV-13 | Format String Injection | mp.sw.2, mp.s.1 | Format string is an application defect that can leak memory or crash services |
| WSTG-v42-INPV-14 | Incubated Vulnerability | mp.sw.2, op.exp.7 | Stored payloads that trigger later are application defects; relate to incident management |
| WSTG-v42-INPV-15 | HTTP Splitting / Smuggling | mp.sw.2, mp.com.2, mp.s.1 | HTTP smuggling is an application defect affecting communications and service protection |
| WSTG-v42-INPV-16 | HTTP Incoming Requests | mp.sw.2, op.exp.2 | Validating incoming requests is an application security and configuration concern |
| WSTG-v42-INPV-17 | Host Header Injection | mp.sw.2, op.exp.2 | Host header manipulation is an application defect and configuration hardening issue |
| WSTG-v42-INPV-18 | Server-Side Template Injection | mp.sw.2, mp.s.1 | SSTI enables code execution; critical application security defect |
| WSTG-v42-INPV-19 | Server-Side Request Forgery | mp.sw.2, mp.com.1, mp.s.1 | SSRF breaches perimeter controls from within; application defect with network impact |
| WSTG-v42-INPV-20 | Mass Assignment | mp.sw.2, op.acc.2 | Mass assignment bypasses intended access requirements; application security defect |

### ERRH — Error Handling

| WSTG ID | Test Name | ENS Controls | Rationale |
|---|---|---|---|
| WSTG-v42-ERRH-01 | Improper Error Handling | op.exp.2, mp.info.1, mp.s.1 | Error handling is a configuration concern; verbose errors may leak classified data; affects service protection |
| WSTG-v42-ERRH-02 | Stack Traces | op.exp.2, mp.info.1 | Stack trace exposure is a configuration hardening gap; leaks potentially classified internal information |

### CRYP — Cryptography

| WSTG ID | Test Name | ENS Controls | Rationale |
|---|---|---|---|
| WSTG-v42-CRYP-01 | Weak Transport Layer Security | mp.com.2, mp.com.3 | TLS is the primary web browsing and communications protection mechanism |
| WSTG-v42-CRYP-02 | Padding Oracle | mp.com.3, mp.info.3 | Padding oracle attacks compromise communications encryption and stored data encryption |
| WSTG-v42-CRYP-03 | Sensitive Information Sent via Unencrypted Channels | mp.com.3, mp.info.1 | Unencrypted transmission of sensitive data violates communications protection and data classification |
| WSTG-v42-CRYP-04 | Weak Encryption | mp.com.3, mp.info.3, mp.info.4 | Weak algorithms undermine communications protection, stored data encryption, and digital signatures |

### BUSL — Business Logic

| WSTG ID | Test Name | ENS Controls | Rationale |
|---|---|---|---|
| WSTG-v42-BUSL-01 | Business Logic Data Validation | mp.sw.2, mp.info.2 | Business data validation is an acceptance testing requirement; relates to information qualification |
| WSTG-v42-BUSL-02 | Ability to Forge Requests | mp.sw.2, mp.s.1 | Request forgery is an application defect that compromises service integrity |
| WSTG-v42-BUSL-03 | Integrity Checks | mp.sw.2, mp.info.2 | Integrity checking is part of acceptance testing and information qualification |
| WSTG-v42-BUSL-04 | Process Timing | mp.sw.2, mp.s.1 | Timing attacks are application defects affecting service reliability |
| WSTG-v42-BUSL-05 | Number of Times a Function Can Be Used | mp.sw.2, op.exp.6 | Rate limiting prevents abuse; relates to DoS protection |
| WSTG-v42-BUSL-06 | Circumvention of Work Flows | mp.sw.2, op.acc.3 | Workflow bypass may violate segregation of duties; application security defect |
| WSTG-v42-BUSL-07 | Defenses Against Application Misuse | mp.sw.2, op.exp.7, op.mon.1 | Misuse defense relates to acceptance testing, incident management, and monitoring |
| WSTG-v42-BUSL-08 | Upload of Unexpected File Types | mp.sw.2, mp.s.1, mp.info.2 | File upload validation is acceptance testing; affects service and information integrity |
| WSTG-v42-BUSL-09 | Upload of Malicious Files | mp.sw.2, mp.s.1, op.exp.7 | Malicious upload is a critical application defect; relates to incident management |

### CLNT — Client-Side

| WSTG ID | Test Name | ENS Controls | Rationale |
|---|---|---|---|
| WSTG-v42-CLNT-01 | DOM-Based Cross Site Scripting | mp.sw.2, mp.com.2, mp.s.1 | DOM XSS is an application defect affecting web browsing and service protection |
| WSTG-v42-CLNT-02 | JavaScript Execution | mp.sw.2, mp.com.2 | Unintended JS execution is an application defect affecting web browsing protection |
| WSTG-v42-CLNT-03 | HTML Injection | mp.sw.2, mp.com.2, mp.s.1 | HTML injection is an application defect affecting browsing and service protection |
| WSTG-v42-CLNT-04 | Client-side URL Redirect | mp.sw.2, mp.com.2 | Open redirects are application defects that abuse web browsing trust |
| WSTG-v42-CLNT-05 | CSS Injection | mp.sw.2, mp.com.2 | CSS injection is an application defect affecting web browsing protection |
| WSTG-v42-CLNT-06 | Client-side Resource Manipulation | mp.sw.2, mp.s.1 | Resource manipulation is an application defect compromising service integrity |
| WSTG-v42-CLNT-07 | Cross Origin Resource Sharing | mp.sw.2, mp.com.2, mp.s.1 | CORS misconfiguration is an application defect affecting browsing and service protection |
| WSTG-v42-CLNT-08 | Cross Site Flashing | mp.sw.2, mp.com.2 | Flash-based attacks are application defects affecting web browsing protection |
| WSTG-v42-CLNT-09 | Clickjacking | mp.sw.2, mp.com.2, mp.s.1 | Clickjacking is an application defect affecting browsing and service protection |
| WSTG-v42-CLNT-10 | WebSockets | mp.sw.2, mp.com.3, mp.s.1 | WebSocket security is an application concern; relates to communications and service protection |
| WSTG-v42-CLNT-11 | Web Messaging | mp.sw.2, mp.com.2 | Web messaging security is an application defect affecting browsing protection |
| WSTG-v42-CLNT-12 | Browser Storage | mp.sw.2, mp.info.1, mp.info.3 | Browser storage may hold classified data; relates to data classification and stored encryption |
| WSTG-v42-CLNT-13 | Cross Site Script Inclusion | mp.sw.2, mp.com.2, mp.s.1 | XSSI is an application defect affecting browsing and service protection |
| WSTG-v42-CLNT-14 | Reverse Tabnabbing | mp.sw.2, mp.com.2 | Tabnabbing is an application defect abusing web browsing trust |

### APIT — API Testing

| WSTG ID | Test Name | ENS Controls | Rationale |
|---|---|---|---|
| WSTG-v42-APIT-01 | Testing GraphQL | mp.sw.2, mp.s.1, op.acc.2 | GraphQL security is an application concern (acceptance testing); affects service protection and access requirements |

---

## Reverse Mapping: ENS Control → WSTG Tests

This table shows which WSTG tests provide evidence for each ENS control that has web application testing coverage. Controls not listed here are outside WSTG scope (see next section).

### op.pl — Planning

| ENS Control | Name | WSTG Tests | Coverage Notes |
|---|---|---|---|
| op.pl.1 | Risk analysis | INFO-01, INFO-06, INFO-07, INFO-10 | WSTG information gathering informs risk analysis. Partial coverage — risk analysis also requires threat modeling and asset valuation beyond WSTG scope |
| op.pl.2 | Security architecture | INFO-10 | Architecture mapping contributes to security architecture assessment. Partial — architecture design is broader than testing |
| op.pl.5 | Component lifecycle | INFO-08, INFO-09 | Framework/application fingerprinting identifies outdated components. Partial — full lifecycle management includes patching and EOL tracking |

### op.acc — Access Control

| ENS Control | Name | WSTG Tests | Coverage Notes |
|---|---|---|---|
| op.acc.1 | Identification | IDNT-02, IDNT-04, IDNT-05 | Tests verify identification mechanisms work correctly |
| op.acc.2 | Access requirements | IDNT-01, IDNT-03, AUTHZ-01, AUTHZ-02, AUTHZ-03, AUTHZ-04, CONF-05, CONF-09, INPV-20, APIT-01 | Broad coverage through authorization, identity, and access tests |
| op.acc.3 | Segregation of duties | IDNT-01, AUTHZ-02, AUTHZ-03, BUSL-06 | Tests verify role separation and workflow enforcement |
| op.acc.4 | Access rights management | IDNT-02, IDNT-03, ATHN-09, SESS-06, AUTHZ-03 | Tests cover provisioning, password reset lifecycle, and logout |
| op.acc.5 | Authentication mechanism | IDNT-04, IDNT-05, ATHN-01 to ATHN-10, SESS-01 to SESS-04, SESS-06 to SESS-09, INPV-06 | Comprehensive coverage of authentication and session security |
| op.acc.6 | Local access | ATHN-10 | Tests for weaker auth in alternative channels, including local |
| op.acc.7 | Remote access | ATHN-10, AUTHZ-01 | Alternative channel auth and path traversal tests relate to remote access security |

### op.exp — Operations

| ENS Control | Name | WSTG Tests | Coverage Notes |
|---|---|---|---|
| op.exp.1 | Activity inventory | INFO-04 | Application enumeration reveals undocumented assets. Partial — inventory is broader than web discovery |
| op.exp.2 | Security configuration | INFO-02, INFO-03, INFO-05, INFO-08, INFO-09, CONF-01 to CONF-11, ERRH-01, ERRH-02, ATHN-02, INPV-03, INPV-16, INPV-17 | Strong coverage through configuration and deployment testing |
| op.exp.3 | Configuration management | CONF-02, CONF-04 | Platform config and backup file tests. Partial — full change tracking is an operational process |
| op.exp.5 | Change management | — | No direct WSTG coverage. Change management is an operational process, not a web test |
| op.exp.6 | Protection against DoS | BUSL-05 | Rate limiting test. Partial — DoS protection also requires infrastructure controls |
| op.exp.7 | Incident management | INPV-14, BUSL-07, BUSL-09 | Tests that detect delayed/stored attacks and application misuse. Partial — incident response process is broader |
| op.exp.9 [M] | Security testing | All WSTG tests | Running a WSTG audit directly satisfies the periodic security testing requirement |

### op.nub — Cloud Services

| ENS Control | Name | WSTG Tests | Coverage Notes |
|---|---|---|---|
| op.nub.1 | Cloud services | CONF-11 | Cloud storage test. Partial — cloud security is much broader than storage |

### op.mon — Monitoring

| ENS Control | Name | WSTG Tests | Coverage Notes |
|---|---|---|---|
| op.mon.1 | Intrusion detection | INFO-01, IDNT-04, ATHN-03, BUSL-07 | Tests that reveal whether attacks are detectable. Partial — monitoring infrastructure is beyond WSTG |

### mp.com — Communications

| ENS Control | Name | WSTG Tests | Coverage Notes |
|---|---|---|---|
| mp.com.1 | Perimeter usage | CONF-01, CONF-10, INPV-19 | Network config, subdomain takeover, and SSRF tests. Partial — perimeter control is primarily infrastructure |
| mp.com.2 | Web browsing protection | CONF-07, CONF-08, SESS-02, SESS-05, INPV-01, INPV-15, CRYP-01, CLNT-01 to CLNT-05, CLNT-07 to CLNT-09, CLNT-11, CLNT-13, CLNT-14 | Strong coverage through TLS, headers, and client-side tests |
| mp.com.3 | Communications protection | ATHN-01, CRYP-01 to CRYP-04, SESS-09, CLNT-10 | Coverage of encryption in transit and authentication of communications |

### mp.sw — Software

| ENS Control | Name | WSTG Tests | Coverage Notes |
|---|---|---|---|
| mp.sw.2 | Acceptance and commissioning | INFO-07, INPV-01 to INPV-20, BUSL-01 to BUSL-09, CLNT-01 to CLNT-14, APIT-01, ERRH-01 | Very strong coverage — virtually all input validation, business logic, and client tests map here |

### mp.info — Information Protection

| ENS Control | Name | WSTG Tests | Coverage Notes |
|---|---|---|---|
| mp.info.1 | Data classification | INFO-03, INFO-05, CONF-03, CONF-04, CONF-11, AUTHZ-01, AUTHZ-04, SESS-04, INPV-05, ERRH-01, ERRH-02, CRYP-03, CLNT-12 | Tests that detect data exposure contribute to classification enforcement |
| mp.info.2 | Information qualification | INPV-02, BUSL-01, BUSL-03, BUSL-08 | Tests that verify data integrity and validation |
| mp.info.3 | Encryption of stored information | ATHN-05, CRYP-02, CRYP-04, CLNT-12 | Tests verifying stored data encryption strength |
| mp.info.4 | Electronic signature | CRYP-04 | Weak encryption test covers algorithm strength for signatures. Partial — signature validation is broader |

### mp.s — Services

| ENS Control | Name | WSTG Tests | Coverage Notes |
|---|---|---|---|
| mp.s.1 | Electronic services protection | INFO-06, CONF-06, CONF-08, SESS-01, SESS-03, SESS-05, SESS-07, SESS-08, SESS-09, INPV-01, INPV-02, INPV-04 to INPV-13, INPV-15, INPV-18, INPV-19, BUSL-02, BUSL-04, BUSL-05, BUSL-08, BUSL-09, CLNT-01, CLNT-03, CLNT-06, CLNT-07, CLNT-09, CLNT-10, CLNT-13, APIT-01, ERRH-01 | Very strong coverage — most injection, session, and service tests map here |
| mp.s.2 | Web portal protection | _(covered indirectly by mp.s.1 tests)_ | Portal protection overlaps with service protection tests. No distinct WSTG test targets portals specifically |

---

## ENS Controls Without WSTG Coverage

The following ENS control families are **outside WSTG scope** because they address physical, organizational, or personnel concerns that cannot be validated through web application testing. A WSTG audit does NOT provide evidence for these controls — they require separate assessment.

### Fully outside WSTG scope

| ENS Control | Family | Why not covered |
|---|---|---|
| org.1 — org.4 | Organizational framework | Governance, policy, and authorization processes — not testable through web app testing |
| op.pl.3 | Procurement | Procurement process — operational, not technical |
| op.pl.4 | System dimensioning | Capacity planning — infrastructure concern |
| op.exp.4 | Maintenance | Maintenance processes — operational |
| op.exp.5 | Change management | Change control processes — operational (though web tests may reveal gaps) |
| op.exp.8 [M] | Incident logging | Log infrastructure — monitoring concern, not web app test |
| op.exp.10 [A] | Intrusion detection (active) | IDS/IPS infrastructure — network security, not web app |
| op.exp.11 [A] | Metrics collection | Security metrics infrastructure — operational |
| op.ext.1 — op.ext.2 | External services/personnel | Supplier management — contractual, not technical |
| op.cont.1 — op.cont.4 | Service continuity | BCP/DR — infrastructure and process, not web app |
| op.mon.2 [M] | Metrics system | Metrics infrastructure — operational |
| op.mon.3 [A] | Surveillance | Continuous surveillance — SOC/SIEM, not web app |
| mp.if.1 — mp.if.7 | Physical facilities | Physical security — buildings, cabling, power, fire, flood |
| mp.per.1 — mp.per.4 | Personnel | HR security — roles, training, awareness, departure |
| mp.eq.1 — mp.eq.4 | Equipment | Endpoint security — workstations, mobile devices |
| mp.com.4 [M] | Network segregation | Network architecture — infrastructure, not web app |
| mp.si.1 — mp.si.5 | Information media | Physical media — labeling, transport, destruction |
| mp.sw.1 | Application development | SDLC process — WSTG tests the result, not the process |
| mp.info.5 [M] | Timestamps | Timestamping infrastructure — operational |
| mp.info.6 [A] | Information cleaning | Data sanitization — operational process |

### Partially covered (WSTG provides some evidence but not full coverage)

| ENS Control | WSTG Coverage | What's Missing |
|---|---|---|
| op.pl.1 (Risk analysis) | Information gathering tests inform risk | Formal risk assessment methodology, asset valuation, threat modeling |
| op.pl.2 (Security architecture) | Architecture mapping | Architecture design decisions, security patterns, defense-in-depth validation |
| op.pl.5 (Component lifecycle) | Framework fingerprinting | Patch management process, EOL tracking, upgrade planning |
| op.exp.1 (Activity inventory) | Application enumeration | Complete asset inventory, dependency tracking |
| op.exp.3 (Configuration management) | Config and backup tests | Full CMDB, change tracking, audit trail |
| op.exp.6 (DoS protection) | Rate limiting tests | Infrastructure DDoS protection, CDN, WAF |
| op.exp.7 (Incident management) | Tests that reveal attack vectors | Incident response plan, escalation, post-incident review |
| op.mon.1 (Intrusion detection) | Tests revealing detection gaps | Monitoring infrastructure, alerting, SIEM integration |
| op.nub.1 (Cloud services) | Cloud storage test | Full cloud security posture, IAM, network, logging |
