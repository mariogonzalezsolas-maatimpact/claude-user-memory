# WSTG-v42-INFO — Information Gathering

Tests in this category focus on discovering information about the application that could be used by an attacker to plan further attacks. Most of these tests are performed externally (search engines, HTTP responses, public pages) and apply to any web-exposed application.

---

## WSTG-v42-INFO-01 — Conduct Search Engine Discovery Reconnaissance for Information Leakage

**Objective:** Identify what sensitive information about the application is available through search engines.

**What to check:**
- Search engines (Google, Bing, DuckDuckGo) for site:<domain> results exposing admin panels, internal docs, logs, backups
- Cached versions of pages that should not be public
- `.git`, `.env`, `backup`, `old`, `test` paths indexed publicly
- Sensitive API endpoints referenced in search results

**Pass criteria:** No sensitive content (credentials, internal endpoints, PII, backups) appears in external search engine results.

**Severity if failing:** Medium to High depending on what's exposed.

---

## WSTG-v42-INFO-02 — Fingerprint Web Server

**Objective:** Determine the type and version of the web server so attacks targeting known vulnerabilities can be planned.

**What to check:**
- `Server` HTTP response header
- `X-Powered-By` header
- Default error pages that reveal server type/version
- TLS handshake metadata
- Response to non-standard HTTP methods

**Pass criteria:** Server headers are minimized or removed. No version numbers disclosed in headers or default error pages.

**Severity if failing:** Low (information disclosure) but contributes to easier exploitation of other findings.

---

## WSTG-v42-INFO-03 — Review Webserver Metafiles for Information Leakage

**Objective:** Check common metafiles that may disclose sensitive paths or information.

**What to check:**
- `robots.txt` for disallowed paths that reveal internal structure
- `sitemap.xml` for hidden endpoints
- `.well-known/` directory contents
- `security.txt` presence and correctness
- `humans.txt` leaking contributor info

**Pass criteria:** Metafiles don't disclose sensitive paths. `robots.txt` should not be used as a security control.

**Severity if failing:** Low to Medium.

---

## WSTG-v42-INFO-04 — Enumerate Applications on Webserver

**Objective:** Identify all applications hosted on the same server that could expand the attack surface.

**What to check:**
- Virtual hosts on the same IP
- Subdomains
- Non-standard ports
- Different applications mounted at subpaths (/admin, /api, /legacy)

**Pass criteria:** Only intended applications are exposed. Legacy or unused applications are decommissioned or protected.

**Severity if failing:** Medium. Legacy apps often contain older, unpatched vulnerabilities.

---

## WSTG-v42-INFO-05 — Review Webpage Content for Information Leakage

**Objective:** Identify sensitive information accidentally exposed in page source.

**What to check:**
- HTML comments containing credentials, internal notes, TODO items with sensitive info
- JavaScript files containing API keys, tokens, internal endpoints, debug flags
- Source maps (`.js.map`) exposed in production
- Hidden form fields with sensitive default values
- Base64-encoded strings that decode to sensitive data

**Pass criteria:** No credentials, keys, internal URLs, or debug info in public page source.

**Severity if failing:** High if credentials/keys are exposed. Medium otherwise.

---

## WSTG-v42-INFO-06 — Identify Application Entry Points

**Objective:** Enumerate all entry points (forms, endpoints, parameters) that the application exposes.

**What to check:**
- All GET/POST parameters across all endpoints
- HTTP headers the application reads (custom headers, User-Agent, Referer)
- Upload endpoints
- WebSocket endpoints
- File parsing entry points

**Pass criteria:** Not a pass/fail test — this is a mapping exercise whose output feeds other tests (INPV, AUTHZ).

**Severity if failing:** N/A (input for other tests).

---

## WSTG-v42-INFO-07 — Map Execution Paths Through Application

**Objective:** Understand the flow of data and control through the application to identify where security controls should exist.

**What to check:**
- Data flow from input to output (taint analysis)
- Trust boundaries between components
- Which layers perform validation
- Which paths reach the database, filesystem, external APIs

**Pass criteria:** Not a pass/fail — this is mapping for subsequent tests.

**Severity if failing:** N/A.

---

## WSTG-v42-INFO-08 — Fingerprint Web Application Framework

**Objective:** Identify the framework (Django, Express, Laravel, Rails, etc.) so framework-specific vulnerabilities can be considered.

**What to check:**
- Framework-specific cookies (e.g., `laravel_session`, `connect.sid`, `csrftoken`)
- Default URLs (`/admin/` for Django, `/wp-admin/` for WordPress)
- Error page styles
- Response headers (`X-Powered-By`, `X-AspNet-Version`)
- JavaScript bundle signatures

**Pass criteria:** Framework fingerprints are minimized in external responses.

**Severity if failing:** Low (information disclosure).

---

## WSTG-v42-INFO-09 — Fingerprint Web Application

**Objective:** Identify the specific web application (WordPress, Joomla, custom) and its version.

**What to check:**
- Known file paths (`/wp-login.php`, `/administrator/`)
- Meta generator tags
- README / CHANGELOG files in web root
- Specific JS/CSS file hashes

**Pass criteria:** Application identity and version are not disclosed to unauthenticated users.

**Severity if failing:** Low to Medium depending on whether the version has known CVEs.

---

## WSTG-v42-INFO-10 — Map Application Architecture

**Objective:** Understand the overall architecture (monolith, microservices, reverse proxies, CDN, WAF) to identify security boundaries.

**What to check:**
- Reverse proxy / load balancer presence (via headers, response timing)
- CDN usage (via DNS, `Via`, `X-Cache` headers)
- WAF presence (via response to probe payloads)
- Microservice boundaries (via URL structure and response headers)
- Database and storage tiers (inferred from application behavior)

**Pass criteria:** Not a pass/fail — this is architectural mapping for subsequent test planning.

**Severity if failing:** N/A.
