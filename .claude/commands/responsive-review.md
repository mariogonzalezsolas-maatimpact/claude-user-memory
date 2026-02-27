---
name: responsive-review
description: Quick command to invoke responsive-reviewer for mobile-first audits, breakpoint analysis, touch target validation, and cross-device layout review.
---

# /responsive-review Command

Perform a responsive design review using the responsive-reviewer agent.

## Usage

```
/responsive-review [component or focus area]
```

## What This Does

1. Invokes `@responsive-reviewer` with your scope
2. Audits breakpoint architecture and mobile-first patterns
3. Tests touch target sizing (44x44px minimum)
4. Reviews fluid typography and responsive images
5. Checks content reflow at 320px (WCAG 1.4.10)
6. Verifies cross-device layout consistency
7. Delivers Responsive Design Report with score (0-100)

## Examples

```
/responsive-review mobile layout for the product page
/responsive-review breakpoint strategy across the app
/responsive-review touch targets on the navigation menu
/responsive-review responsive images and fluid typography
```

## Output

You'll receive a Responsive Design Report including:
- Responsive Score (0-100) with breakdown
- Breakpoint inventory with gaps identified
- Mobile-first compliance status
- Touch target violations
- Fluid typography assessment
- Responsive image audit
- Prioritized fix recommendations

## Next Steps

After `/responsive-review` completes:
1. Fix critical mobile issues (touch targets, overflow)
2. Use `@code-implementer` for CSS/layout fixes
3. Run `/ux-review` for broader accessibility check
4. Run `/theme-review` for dark mode on mobile

## Time

Typical completion: **< 5 minutes**

---

**Executing command...**

Please invoke: `@responsive-reviewer {args}`
