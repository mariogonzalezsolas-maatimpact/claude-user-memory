# Security Checklist
# @linked .claude/rules/code-quality.md

## Mandatory Pre-Commit Checks
- [ ] No hardcoded secrets (API keys, passwords, tokens)
- [ ] All user inputs validated and sanitized
- [ ] SQL injection prevention (parameterized queries only)
- [ ] XSS prevention (sanitized HTML output)
- [ ] CSRF protection enabled on state-changing endpoints
- [ ] Authentication/authorization verified on all protected routes
- [ ] Rate limiting on public endpoints
- [ ] Error messages don't leak sensitive data (stack traces, DB details)

## Secret Management
- NEVER hardcode secrets in source code
- Use environment variables or a secret manager
- Validate required secrets are present at startup
- Rotate any secrets that may have been exposed

## Security Response Protocol
If a security issue is found:
1. STOP all other work immediately
2. Use `@security-auditor` agent for assessment
3. Fix CRITICAL issues before any other work
4. Rotate exposed secrets
5. Search entire codebase for similar vulnerabilities

Adapted from affaan-m/everything-claude-code security rules.
