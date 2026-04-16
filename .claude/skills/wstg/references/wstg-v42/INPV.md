# WSTG-v42-INPV — Input Validation

Tests in this category focus on how the application validates and handles user-controlled input. This is the largest WSTG category because injection is the root cause of many of the most dangerous vulnerabilities.

---

## WSTG-v42-INPV-01 — Testing for Reflected Cross Site Scripting

**Objective:** Verify user input reflected in responses is properly escaped.

**What to check:**
- All GET/POST parameters that appear in responses are HTML-escaped
- Framework template engines auto-escape by default (e.g., Jinja, React JSX, Vue templates)
- No use of `innerHTML`, `dangerouslySetInnerHTML`, `v-html` with user input
- Error messages don't echo unsanitized input
- Headers (Location, Content-Type) don't accept injected newlines
- Content Security Policy in place as defense in depth

**Pass criteria:** No reflected XSS achievable via standard payloads.

**Severity if failing:** High.

---

## WSTG-v42-INPV-02 — Testing for Stored Cross Site Scripting

**Objective:** Verify user input stored and later rendered is properly escaped.

**What to check:**
- User profile fields, comments, messages render user input safely
- File upload metadata (filename, description) is escaped when displayed
- Admin views of user data don't execute injected scripts
- Rich text editors use a safe sanitization library (DOMPurify, bleach)
- Markdown rendering disables raw HTML or sanitizes output
- Email templates don't render user input unescaped

**Pass criteria:** No stored XSS in any rendering context.

**Severity if failing:** High.

---

## WSTG-v42-INPV-03 — Testing for HTTP Verb Tampering

**Objective:** Verify authorization is consistent across HTTP verbs.

**What to check:**
- Authorization rules apply regardless of HTTP method
- Methods that bypass framework routing (if any) are not allowed
- `GET` cannot be used to perform state changes that require `POST`
- Custom verbs don't bypass verb-specific auth rules

**Pass criteria:** Authorization is verb-independent. Verb-specific exemptions are intentional and safe.

**Severity if failing:** Medium to High.

---

## WSTG-v42-INPV-04 — Testing for HTTP Parameter Pollution

**Objective:** Verify the application handles duplicate parameters predictably.

**What to check:**
- Backend consistently handles duplicate query/form parameters (first, last, all, error)
- Frontend and backend handle duplicates the same way
- Duplicated parameters cannot bypass validation (e.g., `?role=user&role=admin`)
- API gateways and backend agree on which value wins

**Pass criteria:** Duplicate parameters are handled consistently and cannot bypass security controls.

**Severity if failing:** Medium.

---

## WSTG-v42-INPV-05 — Testing for SQL Injection

**Objective:** Verify all database queries use parameterized queries or ORM methods, not string concatenation.

**What to check:**
- All queries use prepared statements / parameterized queries
- ORM queries don't use raw string interpolation with user input
- Stored procedures don't build dynamic SQL internally with user input
- Error-based SQLi is not possible (`'`, `"`, `--`)
- Time-based SQLi is not possible (`SLEEP(5)`, `WAITFOR DELAY`)
- Boolean-based blind SQLi is not possible
- Union-based SQLi is not possible
- Second-order SQLi (stored then queried) is not possible
- NoSQL injection is considered for MongoDB, etc.

**Pass criteria:** No SQLi vector works. All queries are parameterized.

**Severity if failing:** Critical.

---

## WSTG-v42-INPV-06 — Testing for LDAP Injection

**Objective:** Verify LDAP queries properly escape user input.

**What to check:**
- LDAP filters use escaped user input
- `(`, `)`, `*`, `\`, NUL, `/` are properly escaped
- Authentication via LDAP cannot be bypassed by injecting filter modifiers
- DN components use proper escaping

**Pass criteria:** No LDAP injection possible. (N/A if LDAP isn't used.)

**Severity if failing:** High.

---

## WSTG-v42-INPV-07 — Testing for XML Injection

**Objective:** Verify XML input is safely parsed and cannot be manipulated to inject malicious content.

**What to check:**
- XML parser disables DTD processing (XXE prevention)
- XML parser disables external entity resolution
- XML parser disables parameter entities
- Libraries used are configured with `DISALLOW_DOCTYPE_DECL` or equivalent
- XSLT transformations don't execute user-supplied stylesheets

**Pass criteria:** No XXE possible. XML parsers configured securely. (N/A if XML isn't used.)

**Severity if failing:** Critical (XXE can lead to file read, SSRF, RCE).

---

## WSTG-v42-INPV-08 — Testing for SSI Injection

**Objective:** Verify Server-Side Includes are not processed on user input.

**What to check:**
- SSI is disabled unless specifically needed
- `.shtml`, `.stm`, `.shtm` files are not served with SSI enabled
- User input is never written to SSI-parsed files
- Directives like `<!--#exec -->` are not processed from user input

**Pass criteria:** SSI not enabled, or user input cannot reach SSI-processed files.

**Severity if failing:** High to Critical if exec directive is enabled.

---

## WSTG-v42-INPV-09 — Testing for XPath Injection

**Objective:** Verify XPath queries built from user input properly escape or parameterize input.

**What to check:**
- XPath queries use parameterized APIs (e.g., `XPath.compile` with variables)
- User input is escaped for XPath context
- Boolean-based blind XPath injection is not possible
- Authentication via XPath cannot be bypassed

**Pass criteria:** No XPath injection possible. (N/A if XPath isn't used.)

**Severity if failing:** High.

---

## WSTG-v42-INPV-10 — Testing for IMAP/SMTP Injection

**Objective:** Verify mail-related functionality cannot be abused to inject headers or commands.

**What to check:**
- Email-sending features don't allow CRLF injection into headers
- `To`, `From`, `Subject` fields reject `\r\n`
- BCC injection is not possible
- Attachment uploads validate content
- IMAP commands from user input are sanitized

**Pass criteria:** No CRLF injection into mail headers.

**Severity if failing:** High (allows spam, phishing via trusted domain).

---

## WSTG-v42-INPV-11 — Testing for Code Injection

**Objective:** Verify user input is never evaluated as code.

**What to check:**
- No use of `eval()`, `exec()`, `Function()` with user input
- Template engines that allow code execution don't receive user input as template
- Deserialization of untrusted data uses safe libraries (not pickle, PHP unserialize, Java ObjectInputStream)
- Configuration file parsing doesn't execute code
- Regex patterns from user input are handled safely (ReDoS)

**Pass criteria:** No user input path reaches code evaluation.

**Severity if failing:** Critical. Code injection is RCE.

---

## WSTG-v42-INPV-12 — Testing for Command Injection

**Objective:** Verify the application never passes user input to shell commands.

**What to check:**
- No `system()`, `exec()`, `shell_exec()`, `os.system()`, `subprocess.shell=True` with user input
- Where shell invocation is required, user input is passed as argv, not concatenated
- Filenames from user input don't contain shell metacharacters
- Archive extraction doesn't trigger path traversal or zip bombs
- Image processing tools (ImageMagick, ffmpeg) handle user input safely

**Pass criteria:** No shell command is built from user input. Where OS calls are needed, arguments are passed safely.

**Severity if failing:** Critical.

---

## WSTG-v42-INPV-13 — Testing for Format String Injection

**Objective:** Verify user input is never passed as a format string.

**What to check:**
- No `printf(userInput)` or equivalents
- Logging frameworks use placeholders, not concatenation (`logger.info("User: %s", user)` not `logger.info(f"User: {user}")` for untrusted input in some cases)
- User input is never the first argument to format functions

**Pass criteria:** No format string vulnerabilities. (Mostly relevant to C/C++ but applies to certain logging patterns.)

**Severity if failing:** Medium to High.

---

## WSTG-v42-INPV-14 — Testing for Incubated Vulnerability

**Objective:** Verify that stored content cannot be used to attack other users later.

**What to check:**
- Stored XSS scenarios (already covered in INPV-02)
- Poisoned cache entries
- Malicious file uploads that affect later operations
- Stored data that changes behavior of scheduled jobs
- Poisoned configuration or database entries

**Pass criteria:** No stored input can alter behavior for other users in an exploitable way.

**Severity if failing:** Varies from Medium to Critical.

---

## WSTG-v42-INPV-15 — Testing for HTTP Splitting/Smuggling

**Objective:** Verify HTTP headers cannot be manipulated via CRLF injection.

**What to check:**
- User input in headers (`Location`, `Set-Cookie`) rejects `\r\n`
- Response splitting via redirect URLs is not possible
- Request smuggling via CL.TE or TE.CL disagreement between proxy and backend
- Proxy and backend agree on Content-Length and Transfer-Encoding handling

**Pass criteria:** No HTTP splitting or smuggling possible.

**Severity if failing:** High.

---

## WSTG-v42-INPV-16 — Testing for HTTP Incoming Requests

**Objective:** Verify incoming requests are parsed consistently and securely.

**What to check:**
- Oversized headers are rejected
- Body size limits enforced
- Malformed requests return errors, not crashes
- Slowloris / slow POST mitigated (timeouts, connection limits)
- Chunked encoding handled correctly

**Pass criteria:** Request parsing is robust against malformed or abusive inputs.

**Severity if failing:** Medium to High.

---

## WSTG-v42-INPV-17 — Testing for Host Header Injection

**Objective:** Verify the application doesn't trust the `Host` header for security-sensitive decisions.

**What to check:**
- Password reset links are built from a fixed config, not the `Host` header
- Email links are not derived from `Host`
- `X-Forwarded-Host` is not trusted unless from a trusted proxy
- Virtual host routing cannot be manipulated to access internal services
- Cache poisoning via Host header is not possible

**Pass criteria:** Host header is not used to build URLs, routes, or security decisions.

**Severity if failing:** High (enables password reset poisoning, cache poisoning).

---

## WSTG-v42-INPV-18 — Testing for Server-Side Template Injection

**Objective:** Verify user input is never used as a template.

**What to check:**
- Template engines (Jinja2, Twig, Freemarker, Velocity, Handlebars, ERB) never receive user input as the template itself
- User input goes into template variables, not template source
- Email templates don't compile user input
- Error templates don't render user-provided format strings
- Test with known SSTI payloads for each engine (`{{7*7}}`, `${7*7}`, `<%= 7*7 %>`)

**Pass criteria:** No user input reaches template compilation.

**Severity if failing:** Critical. Often leads to RCE.

---

## WSTG-v42-INPV-19 — Testing for Server-Side Request Forgery

**Objective:** Verify the application doesn't make requests to URLs controlled by user input without validation.

**What to check:**
- URL parameters (webhook targets, import URLs, image URLs) are validated against an allowlist
- Internal IP ranges (127.0.0.0/8, 10.0.0.0/8, 169.254.0.0/16, etc.) are blocked
- Redirects from allowed URLs are not followed (or followed carefully)
- DNS rebinding mitigated (resolve once and check, then use the resolved IP)
- Cloud metadata endpoints (169.254.169.254) are blocked
- URL parsing is done with the same library used for the actual request

**Pass criteria:** No SSRF possible. Allowlist used instead of blocklist where feasible.

**Severity if failing:** Critical in cloud environments.

---

## WSTG-v42-INPV-20 — Testing for Mass Assignment

**Objective:** Verify user input cannot set fields it shouldn't.

**What to check:**
- ORM models have explicit allowlists for user-settable fields (strong parameters, DTOs, Pydantic models)
- Cannot set `is_admin`, `role`, `created_at`, `user_id` via form submission
- API endpoints use explicit schema validation
- Framework-level protection enabled (Rails `strong_parameters`, Django `fields = [...]`)
- Nested object updates are scoped

**Pass criteria:** No field can be set via user input unless explicitly allowlisted.

**Severity if failing:** High. Common source of privilege escalation.
