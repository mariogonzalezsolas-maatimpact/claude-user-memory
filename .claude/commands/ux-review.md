---
name: ux-review
description: Quick command to invoke ux-accessibility-reviewer for WCAG 2.2 compliance audits, usability heuristic evaluation, and inclusive design validation.
---

# /ux-review Command

Perform a UX and accessibility review using the ux-accessibility-reviewer agent.

## Usage

```
/ux-review [component or focus area]
```

## What This Does

1. Invokes `@ux-accessibility-reviewer` with your scope
2. Evaluates against Nielsen's 10 usability heuristics
3. Audits WCAG 2.2 compliance (Level A, AA, AAA)
4. Tests keyboard navigation and screen reader patterns
5. Analyzes color contrast and visual accessibility
6. Reviews interactive component accessibility
7. Delivers UX & Accessibility Report with score (0-100)

## Examples

```
/ux-review WCAG 2.2 compliance for our signup form
/ux-review usability of the dashboard navigation
/ux-review keyboard accessibility for modal dialogs
/ux-review color contrast and visual hierarchy
```

## Output

You'll receive a UX & Accessibility Report including:
- Combined score (UX 0-50 + Accessibility 0-50 = 0-100)
- Nielsen heuristic violations with severity
- WCAG 2.2 failures by level (A, AA, AAA)
- Keyboard navigation issues
- Screen reader compatibility findings
- Color contrast violations
- Prioritized fix recommendations with ARIA examples

## Next Steps

After `/ux-review` completes:
1. Review critical accessibility failures (Level A)
2. Use `@implementation-planner` to plan fixes
3. Use `@code-implementer` for ARIA, keyboard nav, contrast fixes
4. Use `@seo-strategist` to validate SEO impact of a11y improvements

## Time

Typical completion: **< 5 minutes**

---

**Executing command...**

Please invoke: `@ux-accessibility-reviewer {args}`
