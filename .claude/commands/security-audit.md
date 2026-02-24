---
name: security-audit
description: Quick command to invoke security-auditor for OWASP Top 10 vulnerability assessment, code security review, and compliance validation.
---

# /security-audit Command

Perform a comprehensive security audit using the security-auditor agent.

## Usage

```
/security-audit [scope or focus area]
```

## What This Does

1. Invokes `@security-auditor` with your scope
2. Performs OWASP Top 10 vulnerability assessment
3. Reviews code security patterns (injection, XSS, auth flaws)
4. Scans dependencies for known vulnerabilities
5. Validates compliance posture (SOC 2, GDPR, HIPAA, PCI DSS)
6. Delivers Security Audit Report with score (0-100)

## Examples

```
/security-audit OWASP Top 10 before production deployment
/security-audit authentication and authorization flows
/security-audit dependency vulnerabilities
/security-audit GDPR compliance for user data handling
```

## Output

You'll receive a Security Audit Report including:
- Security score (0-100) with breakdown
- OWASP Top 10 findings with severity ratings
- Code security pattern violations
- Dependency vulnerability list
- Compliance gaps and remediation steps
- Prioritized fix recommendations with code examples

## Next Steps

After `/security-audit` completes:
1. Review critical and high-severity findings
2. Use `@code-implementer` to fix vulnerabilities
3. Re-run `/security-audit` to verify fixes
4. Proceed with deployment via `@brahma-deployer`

## Time

Typical completion: **< 5 minutes**

---

**Executing command...**

Please invoke: `@security-auditor {args}`
