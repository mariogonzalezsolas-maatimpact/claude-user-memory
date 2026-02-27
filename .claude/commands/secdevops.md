---
name: secdevops
description: Quick command to invoke secdevops-engineer for SAST/DAST integration, secret scanning, container scanning, SBOM generation, and pipeline security hardening.
---

# /secdevops Command

Perform DevSecOps pipeline security using the secdevops-engineer agent.

## Usage

```
/secdevops [focus area]
```

## What This Does

1. Invokes `@secdevops-engineer` with your scope
2. Assesses current pipeline security posture
3. Integrates SAST/DAST scanners into CI
4. Configures secret detection (pre-commit + CI)
5. Sets up container image vulnerability scanning
6. Generates SBOM and configures artifact signing
7. Delivers Security Posture Report with score (0-100)

## Examples

```
/secdevops integrate Semgrep SAST into GitHub Actions
/secdevops secret scanning with Gitleaks
/secdevops container image scanning with Trivy
/secdevops SBOM generation and supply chain security
```

## Output

You'll receive a Security Posture Report including:
- Security Posture Score (0-100) with breakdown
- SAST/DAST scanner configurations
- Secret scanning setup
- Container scanning results
- SBOM generation config
- Pipeline hardening recommendations
- Compliance status (CIS benchmarks)

## Next Steps

After `/secdevops` completes:
1. Fix critical scanner findings
2. Use `/security-audit` for application code review
3. Use `/devops` for pipeline improvements
4. Use `@brahma-deployer` for secure deployment

## Time

Typical completion: **5-10 minutes**

---

**Executing command...**

Please invoke: `@secdevops-engineer {args}`
