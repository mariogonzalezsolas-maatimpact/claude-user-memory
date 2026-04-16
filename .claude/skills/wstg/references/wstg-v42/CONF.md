# WSTG-v42-CONF — Configuration and Deployment Management

Tests in this category focus on how the application is configured, deployed, and operated. Misconfigurations are one of the most common sources of real-world breaches.

---

## WSTG-v42-CONF-01 — Test Network Infrastructure Configuration

**Objective:** Verify the network infrastructure (firewalls, load balancers, reverse proxies) is correctly configured to protect the application.

**What to check:**
- Only required ports are exposed publicly
- Admin interfaces (SSH, database consoles, monitoring) are not publicly reachable
- Reverse proxy correctly terminates TLS and forwards to backend
- IP allowlists are enforced where required

**Pass criteria:** Only application ports (typically 443) are reachable from the internet. Administrative access is gated by VPN or IP allowlist.

**Severity if failing:** High to Critical.

---

## WSTG-v42-CONF-02 — Test Application Platform Configuration

**Objective:** Verify the application platform (runtime, framework, libraries) is configured securely in production.

**What to check:**
- Debug mode is OFF in production
- Development tools (Swagger UI, GraphQL playground, Django admin when not needed) are disabled or protected
- Default accounts and sample content are removed
- Verbose logging is restricted to necessary information
- `NODE_ENV=production`, `DEBUG=False`, `APP_ENV=production`, etc.
- Framework-specific production hardening applied

**Pass criteria:** Production environment has no development-only features exposed.

**Severity if failing:** High. This is a very common source of real breaches.

---

## WSTG-v42-CONF-03 — Test File Extensions Handling for Sensitive Information

**Objective:** Verify that sensitive file extensions (`.bak`, `.old`, `.sql`, `.log`, `.config`, `.env`) are not served by the web server.

**What to check:**
- Requests for `.env`, `.git/config`, `backup.sql`, `config.old` return 404 or 403
- Web server blocklist covers common backup extensions
- Source files (`.php.bak`, `.py.swp`) are not served

**Pass criteria:** Web server refuses to serve sensitive file extensions regardless of existence.

**Severity if failing:** High to Critical if secrets are exposed.

---

## WSTG-v42-CONF-04 — Review Old Backup and Unreferenced Files for Sensitive Information

**Objective:** Look for files left behind from development, backups, or old deployments.

**What to check:**
- `/backup/`, `/old/`, `/test/`, `/dev/` paths
- `index.html.old`, `login.php.bak`
- Archives (`.zip`, `.tar.gz`) in web root
- Version control metadata (`.git/`, `.svn/`, `.hg/`) accessible via HTTP
- IDE files (`.idea/`, `.vscode/`) accessible

**Pass criteria:** No backup, development, or VCS files accessible via HTTP.

**Severity if failing:** High if they contain secrets or source code.

---

## WSTG-v42-CONF-05 — Enumerate Infrastructure and Application Admin Interfaces

**Objective:** Find all administrative interfaces exposed by the application or infrastructure.

**What to check:**
- Standard admin paths (`/admin`, `/manage`, `/dashboard`, `/phpmyadmin`)
- Framework admin panels (Django `/admin/`, Rails `/rails/info/`)
- Database web consoles
- Monitoring dashboards (Grafana, Kibana, Prometheus)
- CI/CD interfaces
- Custom test endpoints (`/test`, `/debug`, `/internal`)

**Pass criteria:** All admin interfaces are authenticated, authorized, and ideally not reachable from the public internet.

**Severity if failing:** Critical if unauthenticated, High if authenticated but publicly reachable.

---

## WSTG-v42-CONF-06 — Test HTTP Methods

**Objective:** Verify the application only accepts HTTP methods it needs.

**What to check:**
- `OPTIONS` responses reveal allowed methods
- `PUT`, `DELETE`, `TRACE`, `CONNECT` are rejected unless required
- `TRACE` is disabled (risk of XST)
- Method override headers (`X-HTTP-Method-Override`) do not bypass authorization
- Custom methods are handled correctly

**Pass criteria:** Only required methods are accepted. `TRACE` is disabled.

**Severity if failing:** Medium.

---

## WSTG-v42-CONF-07 — Test HTTP Strict Transport Security

**Objective:** Verify HSTS is correctly configured to prevent protocol downgrade attacks.

**What to check:**
- `Strict-Transport-Security` header is present on HTTPS responses
- `max-age` is at least 1 year (31536000 seconds)
- `includeSubDomains` is set if all subdomains support HTTPS
- `preload` directive if submitted to the HSTS preload list
- HTTP requests are redirected to HTTPS

**Pass criteria:** HSTS header present with max-age ≥ 31536000, and HTTP is redirected to HTTPS.

**Severity if failing:** Medium. High for applications handling sensitive data.

---

## WSTG-v42-CONF-08 — Test RIA Cross Domain Policy

**Objective:** Verify cross-domain policies for Rich Internet Applications (Flash, Silverlight) are restrictive. Largely legacy but check if present.

**What to check:**
- `crossdomain.xml` (Flash) is absent or restrictive
- `clientaccesspolicy.xml` (Silverlight) is absent or restrictive
- No wildcard (`*`) allow-from directives

**Pass criteria:** No overly permissive cross-domain policies.

**Severity if failing:** Medium, though Flash/Silverlight usage is essentially extinct.

---

## WSTG-v42-CONF-09 — Test File Permission

**Objective:** Verify filesystem permissions on the server don't allow unauthorized access.

**What to check:**
- Configuration files readable only by the application user
- Log files not world-readable
- Uploaded files stored outside the web root
- Executable permissions only where necessary
- Temporary files cleaned up

**Pass criteria:** Principle of least privilege applied to filesystem permissions.

**Severity if failing:** High if secrets become readable by unprivileged users.

---

## WSTG-v42-CONF-10 — Test for Subdomain Takeover

**Objective:** Verify that DNS records for decommissioned services don't allow attackers to claim the subdomain on the original provider.

**What to check:**
- CNAME records pointing to services no longer active (AWS S3, Heroku, GitHub Pages, etc.)
- `dig`/`nslookup` all subdomains and check if targets respond
- Use tools like subjack, subover to identify takeover candidates
- Dangling DNS records for expired cloud resources

**Pass criteria:** All DNS records point to live, controlled resources.

**Severity if failing:** High. Allows attacker to host malicious content under a trusted domain.

---

## WSTG-v42-CONF-11 — Test Cloud Storage

**Objective:** Verify cloud storage buckets (S3, GCS, Azure Blob) are correctly permissioned.

**What to check:**
- Bucket ACLs are not public unless intentionally so
- Bucket policies don't allow wildcard access
- Versioned objects are not publicly accessible
- Signed URLs have appropriate expiration
- IAM roles follow least privilege
- Buckets enforce encryption at rest

**Pass criteria:** No sensitive data in publicly-readable buckets. Least privilege enforced.

**Severity if failing:** Critical if sensitive data is exposed.
