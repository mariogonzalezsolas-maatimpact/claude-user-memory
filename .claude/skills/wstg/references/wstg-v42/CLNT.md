# WSTG-v42-CLNT — Client-Side

Tests in this category focus on client-side vulnerabilities: JavaScript, browser APIs, and how the application's frontend handles input and state. Most of these are N/A for pure backend APIs.

---

## WSTG-v42-CLNT-01 — Testing for DOM-Based Cross Site Scripting

**Objective:** Verify JavaScript code doesn't write user-controlled data to dangerous sinks.

**What to check:**
- No `document.write`, `innerHTML`, `outerHTML`, `insertAdjacentHTML` with user input
- `location.hash`, `location.search`, `postMessage` data are sanitized before use
- jQuery `.html()`, React `dangerouslySetInnerHTML`, Vue `v-html`, Angular `[innerHTML]` don't receive user input
- `eval()`, `Function()`, `setTimeout(string)` are never called with user input
- `window.name`, `document.referrer` are treated as untrusted

**Pass criteria:** No DOM XSS sinks receive unsanitized user input.

**Severity if failing:** High.

---

## WSTG-v42-CLNT-02 — Testing for JavaScript Execution

**Objective:** Verify user input never results in arbitrary JavaScript execution.

**What to check:**
- Event handlers (onclick, onerror, onload) are not built from user input
- JavaScript URIs (`javascript:...`) are blocked in links
- Dynamic script loading doesn't use user-controlled URLs
- Third-party script loading is restricted (Subresource Integrity)
- Content Security Policy limits script execution

**Pass criteria:** No user input can lead to JavaScript execution.

**Severity if failing:** High.

---

## WSTG-v42-CLNT-03 — Testing for HTML Injection

**Objective:** Verify user input is not rendered as HTML when it shouldn't be.

**What to check:**
- User input in tooltips, status messages, previews is escaped
- Rich text editors use a sanitization library
- Markdown rendering is scoped and safe
- Template bindings are escaped by default

**Pass criteria:** No HTML injection possible. (Closely related to INPV-01, INPV-02.)

**Severity if failing:** Medium to High.

---

## WSTG-v42-CLNT-04 — Testing for Client-side URL Redirect

**Objective:** Verify the application doesn't redirect to attacker-controlled URLs.

**What to check:**
- Redirect parameters are validated against an allowlist
- `location.href = userInput` is not present
- Login redirects (`?next=...`) only allow relative URLs or allowlisted hosts
- OAuth redirect URIs are validated exactly (not prefix matching)

**Pass criteria:** No open redirects. Redirect destinations are validated server-side and client-side.

**Severity if failing:** Medium. Enables phishing.

---

## WSTG-v42-CLNT-05 — Testing for CSS Injection

**Objective:** Verify user-controlled CSS cannot exfiltrate data or alter layout maliciously.

**What to check:**
- No `style` attributes built from user input
- No user-controlled CSS files loaded
- Theme customization sanitizes CSS
- No CSS-based keylogger vectors (attribute selectors leaking input)

**Pass criteria:** No user input reaches CSS rendering.

**Severity if failing:** Medium.

---

## WSTG-v42-CLNT-06 — Testing for Client-side Resource Manipulation

**Objective:** Verify client-side resource URLs cannot be manipulated by user input.

**What to check:**
- Image URLs, video URLs, iframe URLs are not user-controlled without validation
- `src`/`href` attributes from user input are validated
- Preloading / prefetching doesn't leak user data
- WebWorker URLs are not user-controlled

**Pass criteria:** No user input reaches resource URLs without validation.

**Severity if failing:** Medium to High.

---

## WSTG-v42-CLNT-07 — Testing Cross Origin Resource Sharing

**Objective:** Verify CORS policy is correctly configured.

**What to check:**
- `Access-Control-Allow-Origin` is not wildcard (`*`) for credentialed endpoints
- `Access-Control-Allow-Credentials` is only set where necessary
- `Access-Control-Allow-Origin` reflects only allowlisted origins
- Origin validation matches exactly (not substring, not prefix)
- Preflight responses are correct for sensitive endpoints
- `null` origin is not allowed

**Pass criteria:** CORS is restrictive and only allows known origins for credentialed requests.

**Severity if failing:** High if credentials are exposed to attacker origins.

---

## WSTG-v42-CLNT-08 — Testing for Cross Site Flashing

**Objective:** Verify Flash (if used) is not vulnerable to cross-site flashing attacks. Largely legacy.

**What to check:**
- Flash is not used (Flash is EOL since 2020)
- If Flash is used, SWF files don't accept user input in FlashVars
- `crossdomain.xml` is restrictive

**Pass criteria:** Flash is not used, or is used securely. In 2026 this should almost always be N/A.

**Severity if failing:** High if Flash is still in use.

---

## WSTG-v42-CLNT-09 — Testing for Clickjacking

**Objective:** Verify the application cannot be framed by another site to trick users into clicks.

**What to check:**
- `X-Frame-Options: DENY` or `SAMEORIGIN` set, OR
- `Content-Security-Policy: frame-ancestors 'none'` or `'self'`
- Sensitive actions (password change, payment, settings) use UI defenses (confirmation dialogs)
- Framebusting JavaScript as defense in depth (but CSP/XFO is primary)

**Pass criteria:** The application cannot be framed by third-party sites.

**Severity if failing:** Medium to High depending on what actions are exposed.

---

## WSTG-v42-CLNT-10 — Testing WebSockets

**Objective:** Verify WebSocket connections are secured and authenticated.

**What to check:**
- WebSockets use WSS (TLS), not WS
- Authentication is verified at connection and enforced per-message
- Origin header is validated (WebSockets don't enforce SOP)
- Input from WebSocket messages is validated and sanitized
- Rate limiting applied to WebSocket messages
- No sensitive data in WebSocket subprotocol header

**Pass criteria:** WebSocket connections are encrypted, authenticated, origin-validated, and rate-limited.

**Severity if failing:** High.

---

## WSTG-v42-CLNT-11 — Testing Web Messaging

**Objective:** Verify `postMessage` usage is secure.

**What to check:**
- `postMessage` targets specific origins, not `*`
- Message event handlers validate `event.origin`
- Message data is treated as untrusted and validated before use
- Sensitive operations via postMessage require origin checks

**Pass criteria:** postMessage exchanges validate origins and data.

**Severity if failing:** High.

---

## WSTG-v42-CLNT-12 — Testing Browser Storage

**Objective:** Verify sensitive data is not stored insecurely in the browser.

**What to check:**
- No auth tokens in localStorage (accessible via XSS)
- No PII in localStorage/sessionStorage
- IndexedDB doesn't hold sensitive unencrypted data
- Cookies used for auth have `HttpOnly` and `Secure` flags
- Service workers don't cache authenticated responses
- Clear storage on logout

**Pass criteria:** Sensitive data is not stored in browser-accessible storage. Auth tokens live in HttpOnly cookies.

**Severity if failing:** High.

---

## WSTG-v42-CLNT-13 — Testing for Cross Site Script Inclusion

**Objective:** Verify JSON/JS responses cannot be included by other sites to steal data.

**What to check:**
- JSON responses start with a prefix that breaks script execution (`)]}',\n`) or are POST-only
- Sensitive endpoints cannot be loaded via `<script>` tag from another origin
- JSONP endpoints are removed or scoped to authenticated callbacks
- CSRF tokens required for data-returning endpoints

**Pass criteria:** No cross-origin inclusion can extract sensitive data.

**Severity if failing:** High.

---

## WSTG-v42-CLNT-14 — Testing for Reverse Tabnabbing

**Objective:** Verify external links don't allow the opened page to navigate the opener.

**What to check:**
- `target="_blank"` links include `rel="noopener noreferrer"`
- Frameworks that auto-apply this (modern React/Next) are used correctly
- User-generated links have `noopener noreferrer` added

**Pass criteria:** No `target="_blank"` link is missing `rel="noopener"`.

**Severity if failing:** Low to Medium.
