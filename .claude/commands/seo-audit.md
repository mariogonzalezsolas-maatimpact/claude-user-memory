---
name: seo-audit
description: Quick command to invoke seo-strategist for technical SEO audits, keyword strategy, schema markup, and Core Web Vitals analysis.
---

# /seo-audit Command

Perform a comprehensive SEO audit using the seo-strategist agent.

## Usage

```
/seo-audit [website or focus area]
```

## What This Does

1. Invokes `@seo-strategist` with your scope
2. Performs technical SEO assessment (crawlability, site structure)
3. Analyzes Core Web Vitals performance
4. Reviews meta tags and on-page optimization
5. Evaluates schema markup opportunities
6. Performs competitive SEO benchmarking
7. Delivers SEO Audit Report with score (0-100)

## Examples

```
/seo-audit technical health of our marketing site
/seo-audit keyword strategy for our SaaS product
/seo-audit Core Web Vitals optimization opportunities
/seo-audit schema markup for our e-commerce pages
```

## Output

You'll receive an SEO Audit Report including:
- SEO score (0-100) with breakdown
- Technical SEO findings (crawlability, indexing, site speed)
- On-page optimization recommendations
- Schema markup implementation plan (JSON-LD)
- Keyword opportunities and content gaps
- Core Web Vitals analysis with fix priorities

## Next Steps

After `/seo-audit` completes:
1. Review prioritized findings
2. Use `@content-strategist` for content optimization
3. Use `@code-implementer` for technical fixes (meta tags, schema)
4. Re-run `/seo-audit` to verify improvements

## Time

Typical completion: **< 5 minutes**

---

**Executing command...**

Please invoke: `@seo-strategist {args}`
