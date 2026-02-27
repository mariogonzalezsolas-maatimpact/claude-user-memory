---
name: devops
description: Quick command to invoke devops-engineer for CI/CD pipeline design, Docker configuration, Kubernetes manifests, Terraform modules, and infrastructure automation.
---

# /devops Command

Perform DevOps design or implementation using the devops-engineer agent.

## Usage

```
/devops [infrastructure or focus area]
```

## What This Does

1. Invokes `@devops-engineer` with your scope
2. Assesses current infrastructure and pipelines
3. Designs CI/CD pipeline stages (build, test, scan, deploy)
4. Writes Dockerfiles with best practices
5. Creates Kubernetes manifests or Terraform modules
6. Configures environment management
7. Delivers DevOps Report

## Examples

```
/devops design GitHub Actions pipeline for Node.js
/devops optimize Docker build for production
/devops Kubernetes deployment with HPA
/devops Terraform module for AWS VPC
```

## Output

You'll receive a DevOps Report including:
- Pipeline configuration files
- Dockerfile with multi-stage build
- Infrastructure as Code modules
- Environment configuration
- Caching and optimization strategy
- Rollback procedures
- Cost estimates (if applicable)

## Next Steps

After `/devops` completes:
1. Review pipeline configuration
2. Use `/secdevops` for pipeline security hardening
3. Use `@brahma-deployer` for production deployment
4. Use `@brahma-monitor` for observability setup

## Time

Typical completion: **5-10 minutes**

---

**Executing command...**

Please invoke: `@devops-engineer {args}`
