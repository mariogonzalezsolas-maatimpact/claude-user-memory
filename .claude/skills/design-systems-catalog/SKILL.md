---
name: design-systems-catalog
description: >
  Curated catalog of 160+ production design systems (Material Design, IBM Carbon,
  Shopify Polaris, Atlassian Design, Fluent UI, Ant Design, Chakra UI, shadcn/ui,
  Pinterest Gestalt, GitHub Primer, AWS Cloudscape, GOV.UK, U.S. Web Design Standards,
  and many more). Each entry tags Components / Voice & Tone / Designers Kit / Source
  code availability. Auto-invoke when the user is choosing a design system, comparing
  component libraries, looking for a Figma/Sketch kit, researching voice & tone guides,
  benchmarking how a specific company solved a UI problem, or mentions any of these
  triggers: "design system", "UI library", "pattern library", "style guide",
  "component library", "design tokens reference", or a specific system name
  (Material, Carbon, Polaris, Fluent, Primer, Gestalt, Cloudscape, etc.).
  Source: alexpate/awesome-design-systems (Unlicense / public domain).
---

# Design Systems Catalog

You have access to a curated, navigable index of 160+ public design systems used by
companies, governments, and open-source projects worldwide. Use it whenever the user
needs concrete real-world examples rather than abstract design theory.

## When to invoke

Use this skill when the user:

- Asks "which design system should I use for X?"
- Wants to see how a specific company solves a UI pattern (modal, table, form, etc.)
- Needs a Figma / Sketch / design kit from a public source
- Is researching voice & tone guides (Mailchimp, Monzo, Duolingo, etc.)
- Mentions a specific named system (Material, Carbon, Polaris, Fluent, Gestalt, Primer, etc.)
- Is benchmarking component libraries or looking for OSS alternatives
- Asks for government / accessibility-first design systems (GOV.UK, USWDS, France, Italy, Estonia, Singapore, etc.)
- Wants component libraries with explicit license / source code links

Do NOT invoke when the user asks for general UI/UX design theory (use `ui-ux-pro-max`,
`web-design-guidelines`, `frontend-design` instead) or accessibility methodology
(use `web-accessibility`).

## How to use this catalog

The full reference is in `reference/awesome-design-systems.md` (verbatim copy of the
upstream README, ~160 systems in a single table). For faster lookup by category,
use `reference/by-category.md`.

### Lookup workflow

1. **Identify the user's axis**: are they looking by company, by tag (Components / Voice
   & Tone / Kit / Source), by domain (government, finance, healthcare, e-commerce), or
   by stack (React, Vue, Web Components)?
2. **Open the matching reference file**:
   - Direct system lookup or full table -> `reference/awesome-design-systems.md`
   - Categorized browse (government, OSS-with-source, voice-and-tone) -> `reference/by-category.md`
3. **Return 3-5 best matches** with: name, homepage URL, source repo (if any), and one
   sentence on why it fits. Do NOT dump the whole table.
4. **If user wants to compare**, build a small table (system | components | kit | source).

### Examples

User: "What design systems do governments use?"
-> Open `reference/by-category.md` -> Government section. Return: GOV.UK, USWDS,
   French Government DSFR, Italy, Estonia, Singapore SGDS, Korea KRDS, NHS.UK,
   Ontario, NY State, Aurora (Canada), CMS.gov. One line each.

User: "I'm building a React app, need a design system with Figma kit and OSS"
-> Filter for: Components + Designers Kit + Source. Return top React-stack matches:
   Adobe Spectrum, Chakra UI, Mantine, MUI / Material, Fluent UI, Polaris,
   Atlassian, Primer, Carbon, Gestalt, Untitled UI, Reshaped.

User: "Show me voice & tone guides"
-> Filter by Voice & Tone tag. Return: Mailchimp, Monzo, Duolingo, Shopify Polaris,
   Atlassian, GitLab Pajamas, Salesforce Lightning, IBM Carbon, plus any others.

## Caveats

- The upstream list is community-maintained; some links may rot. Always verify the URL
  works before recommending heavily.
- "Open source" badges do NOT guarantee a usable license. Check each repo's LICENSE.
- The Tags column reflects what the upstream maintainer observed, not a guarantee that
  the system currently still ships all those artifacts.
- This catalog is a starting point, not a substitute for evaluating the system against
  the user's actual requirements (a11y, framework support, design token format, etc.).

## Source and attribution

- Upstream: https://github.com/alexpate/awesome-design-systems
- License: Unlicense (public domain). See `ATTRIBUTION.md`.
- Snapshot date: 2026-05-21.
- To refresh: re-clone the upstream repo and replace `reference/awesome-design-systems.md`.
