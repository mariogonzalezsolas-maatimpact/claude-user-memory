---
name: seo-audit
description: SEO audit with 12 sub-commands including GEO (AI search readiness), schema deprecations, programmatic SEO, and industry-specific strategies.
---

# /seo-audit Command

Perform a comprehensive SEO audit using the seo-strategist agent.

## Usage

```
/seo-audit [website or focus area]
```

## Sub-Commands

| Sub-Command | Example | Description |
|---|---|---|
| `audit` (default) | `/seo-audit` | Full SEO audit (all phases) |
| `page [url]` | `/seo-audit page https://example.com` | Single page deep-dive |
| `technical` | `/seo-audit technical` | Crawlability, speed, indexing |
| `content` | `/seo-audit content` | Content quality + E-E-A-T |
| `schema` | `/seo-audit schema` | Structured data audit |
| `geo` | `/seo-audit geo` | AI search readiness (GEO) |
| `plan [keyword]` | `/seo-audit plan "best crm"` | Content plan for keyword |
| `programmatic` | `/seo-audit programmatic` | Programmatic SEO quality gates |
| `images` | `/seo-audit images` | Image SEO audit |
| `sitemap` | `/seo-audit sitemap` | XML sitemap audit |
| `hreflang` | `/seo-audit hreflang` | International SEO audit |
| `competitor-pages [urls]` | `/seo-audit competitor-pages url1 url2` | Head-to-head comparison |

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
- SEO score (0-100) with 7-category breakdown
- Technical SEO findings (crawlability, indexing, site speed)
- On-page optimization recommendations
- Schema markup plan (JSON-LD) with deprecation warnings
- Content quality and E-E-A-T assessment
- Core Web Vitals analysis with fix priorities
- AI Search Readiness (GEO) score
- Industry-specific recommendations

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
