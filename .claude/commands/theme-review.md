---
name: theme-review
description: Quick command to invoke theme-reviewer for dark/light mode audits, design token analysis, contrast per theme, and FOUC prevention review.
---

# /theme-review Command

Perform a theme and color mode review using the theme-reviewer agent.

## Usage

```
/theme-review [component or focus area]
```

## What This Does

1. Invokes `@theme-reviewer` with your scope
2. Audits design token architecture (primitive/semantic/component)
3. Verifies dark mode and light mode completeness
4. Tests color contrast in ALL theme variants (WCAG AA)
5. Checks system preference detection (prefers-color-scheme)
6. Reviews theme persistence and FOUC prevention
7. Delivers Theme Report with score (0-100)

## Examples

```
/theme-review dark mode implementation for the dashboard
/theme-review design token system and hardcoded colors
/theme-review contrast ratios in dark theme
/theme-review theme transition and FOUC prevention
```

## Output

You'll receive a Theme Report including:
- Theme Score (0-100) with breakdown
- Token architecture assessment
- Hardcoded colors list with suggested tokens
- Contrast results per theme variant
- FOUC prevention status
- Shadow/image dark mode adaptations
- Prioritized fix recommendations

## Next Steps

After `/theme-review` completes:
1. Fix contrast failures in dark mode (critical)
2. Replace hardcoded colors with design tokens
3. Use `@code-implementer` for theme fixes
4. Run `/ux-review` for broader accessibility

## Time

Typical completion: **< 5 minutes**

---

**Executing command...**

Please invoke: `@theme-reviewer {args}`
