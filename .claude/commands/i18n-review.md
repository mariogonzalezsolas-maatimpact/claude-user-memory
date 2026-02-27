---
name: i18n-review
description: Quick command to invoke i18n-reviewer for internationalization audits, hardcoded string detection, RTL support, pluralization, and locale management review.
---

# /i18n-review Command

Perform an internationalization review using the i18n-reviewer agent.

## Usage

```
/i18n-review [component or focus area]
```

## What This Does

1. Invokes `@i18n-reviewer` with your scope
2. Scans for hardcoded user-facing strings
3. Audits translation file structure and coverage
4. Verifies pluralization implementation (ICU/CLDR)
5. Checks date/number/currency formatting (Intl API)
6. Reviews RTL layout support
7. Delivers i18n Readiness Report with score (0-100)

## Examples

```
/i18n-review hardcoded strings in the checkout flow
/i18n-review translation coverage for Spanish locale
/i18n-review RTL support for Arabic layout
/i18n-review date and currency formatting
```

## Output

You'll receive an i18n Readiness Report including:
- i18n Score (0-100) with breakdown
- Hardcoded strings list with suggested keys
- Translation coverage per locale
- Pluralization compliance
- Date/number formatting audit
- RTL support status
- hreflang SEO check
- Prioritized fix recommendations

## Next Steps

After `/i18n-review` completes:
1. Extract hardcoded strings to translation files
2. Use `@code-implementer` for i18n implementation
3. Run `/seo-audit` for hreflang and multi-language SEO
4. Set up translation management (Crowdin, Lokalise)

## Time

Typical completion: **< 5 minutes**

---

**Executing command...**

Please invoke: `@i18n-reviewer {args}`
