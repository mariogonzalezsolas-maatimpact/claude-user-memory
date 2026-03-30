---
name: ui-ux-pro-max
description: Master UI/UX design methodology. Comprehensive design system architecture, layout patterns, component hierarchy, micro-interactions, design tokens, spacing systems, typography scales, color systems, motion design, form UX, and dashboard design. Claude invokes this when UI/UX design decisions are needed.
auto_invoke: true
tags: [ui, ux, design-system, layout, components, micro-interactions, design-tokens]
---

# UI/UX Pro MAX Skill

This skill provides an elite-level methodology for UI/UX design decisions. It covers the full spectrum of interface design — from atomic design tokens to complete design system architecture.

## When Claude Should Use This Skill

Claude will automatically invoke this skill when:
- `/do` involves UI component design, layout architecture, or design system work
- User explicitly requests UI/UX guidance or design decisions
- @ux-accessibility-reviewer, @responsive-reviewer, or @theme-reviewer need design context
- Task involves building new UI features, dashboards, or interactive components
- Design system creation or extension is needed

**Do NOT invoke when:**
- Task is backend-only with no UI impact
- Task is purely accessibility audit (use web-accessibility skill)
- Task is only about CSS theming (use theme-reviewer agent)

## Core Principles

1. **User intent first** — Every pixel serves a purpose. If it doesn't help the user accomplish their goal, remove it
2. **Progressive disclosure** — Show only what's needed now, reveal complexity on demand
3. **Consistency over novelty** — Reuse patterns before inventing new ones
4. **Accessible by default** — Design for the widest range of users from the start
5. **Performance is UX** — A beautiful interface that loads slowly is a bad interface

## Design System Architecture Protocol

### Step 1: Design Token Foundation (< 2 minutes)

**Establish the atomic layer**:

```
Design Tokens (Tier 1 - Primitive)
├── Colors: brand, neutral, semantic (success/warning/error/info)
├── Typography: font-family, font-size scale, font-weight, line-height
├── Spacing: 4px base unit → 4, 8, 12, 16, 20, 24, 32, 40, 48, 64, 80, 96
├── Border-radius: none, sm (4), md (8), lg (12), xl (16), full (9999)
├── Shadows: sm, md, lg, xl (elevation system)
├── Breakpoints: sm (640), md (768), lg (1024), xl (1280), 2xl (1536)
└── Motion: duration (fast 150ms, normal 200ms, slow 300ms), easing curves
```

**Semantic tokens (Tier 2 — Alias)**:
```
├── background-primary → neutral-50 (light) / neutral-900 (dark)
├── text-primary → neutral-900 (light) / neutral-50 (dark)
├── border-default → neutral-200 (light) / neutral-700 (dark)
├── interactive-primary → brand-600
├── interactive-hover → brand-700
├── interactive-active → brand-800
├── surface-elevated → white + shadow-md (light) / neutral-800 (dark)
└── focus-ring → brand-500 with 2px offset
```

### Step 2: Typography Scale

**Use a modular scale** (1.250 — Major Third recommended):

| Step | Size | Line-height | Use |
|------|------|-------------|-----|
| xs | 12px | 16px | Captions, badges |
| sm | 14px | 20px | Secondary text, labels |
| base | 16px | 24px | Body text (default) |
| lg | 18px | 28px | Lead paragraphs |
| xl | 20px | 28px | H4, card titles |
| 2xl | 24px | 32px | H3, section titles |
| 3xl | 30px | 36px | H2, page sections |
| 4xl | 36px | 40px | H1, page titles |
| 5xl | 48px | 48px | Hero, display |

**Rules**:
- Max 2 font families (one sans, one mono for code)
- Never use more than 3 font weights per page
- Body text: minimum 16px, line-height 1.5
- Headings: line-height 1.2-1.3

### Step 3: Component Hierarchy (Atomic Design)

```
Atoms → Molecules → Organisms → Templates → Pages

Atoms:       Button, Input, Badge, Avatar, Icon, Label, Spinner
Molecules:   SearchBar (Input + Button), FormField (Label + Input + Error),
             UserChip (Avatar + Name), StatCard (Icon + Value + Label)
Organisms:   Navbar, Sidebar, DataTable, Form, Card, Modal, CommandPalette
Templates:   DashboardLayout, AuthLayout, SettingsLayout, ListDetailLayout
Pages:       Dashboard, UserProfile, Settings, ProductList
```

### Step 4: Layout Patterns

**Container strategy**:
```css
/* Max-width container with responsive padding */
.container { max-width: 1280px; margin: 0 auto; padding: 0 16px; }
@media (min-width: 768px) { .container { padding: 0 24px; } }
@media (min-width: 1024px) { .container { padding: 0 32px; } }
```

**Common layout patterns**:

| Pattern | When to use | Structure |
|---------|------------|-----------|
| **Stack** | Vertical content flow | Flex column, gap-based spacing |
| **Cluster** | Horizontal wrapping items | Flex row wrap, gap-based |
| **Sidebar** | Fixed + fluid columns | Grid with minmax() |
| **Switcher** | Responsive column/row | Flexbox with wrap threshold |
| **Cover** | Vertically centered hero | Grid with min-height |
| **Center** | Horizontally centered block | Max-width + auto margins |
| **Holy Grail** | Header + sidebar + main + footer | CSS Grid areas |

### Step 5: Interaction Design

**State management for interactive elements**:

```
Default → Hover → Focus → Active → Disabled → Loading → Error → Success

Visual cues per state:
- Hover: subtle background change, cursor pointer
- Focus: visible focus ring (2px brand-500, 2px offset)
- Active: slight scale(0.98) or darker background
- Disabled: opacity 0.5, cursor not-allowed, no pointer events
- Loading: spinner or skeleton, preserve layout dimensions
- Error: red border, error icon, descriptive message below
- Success: green check, brief confirmation, auto-dismiss
```

**Micro-interactions** (use sparingly):
- Button press: scale(0.97) for 100ms
- Toggle: slide animation 200ms ease-out
- Accordion: height auto with 200ms ease
- Toast notifications: slide in from top-right, auto-dismiss 5s
- Page transitions: fade 150ms or slide 200ms
- Skeleton loading: pulse animation on neutral-200

### Step 6: Form UX

**Rules for excellent forms**:

1. **Labels always visible** — No placeholder-only labels
2. **Single-column layout** — Multi-column forms reduce completion rates by 47%
3. **Inline validation** — Validate on blur, not on every keystroke
4. **Clear error messages** — "Email format: name@example.com" not "Invalid input"
5. **Smart defaults** — Pre-fill what you can (country from locale, etc.)
6. **Progressive disclosure** — Optional fields behind "Show more" when possible
7. **Primary action right/bottom** — Consistent CTA placement
8. **Destructive actions require confirmation** — Delete needs double-confirm or undo

**Field ordering**: Most important / required fields first. Group related fields with fieldset.

### Step 7: Dashboard & Data Display

**Dashboard composition**:
```
┌─────────────────────────────────────────────┐
│  KPI Row (3-4 stat cards, equal width)       │
├─────────────────────┬───────────────────────┤
│  Primary Chart       │  Secondary Chart      │
│  (2/3 width)         │  (1/3 width)          │
├─────────────────────┴───────────────────────┤
│  Data Table (full width, sortable, filterable│
│  paginated, with bulk actions)               │
└─────────────────────────────────────────────┘
```

**Data table essentials**:
- Sticky header on scroll
- Sortable columns (click header)
- Row selection with checkbox
- Bulk actions toolbar (appears on selection)
- Pagination or virtual scroll for 100+ rows
- Empty state with illustration + CTA
- Loading skeleton preserving column widths

### Step 8: Responsive Strategy

**Mobile-first breakpoint system**:

```
Base (0-639px):     Single column, stacked layout, hamburger nav
sm (640px+):        Minor adjustments, wider cards
md (768px+):        Two-column layouts, sidebar appears
lg (1024px+):       Full layout, expanded navigation
xl (1280px+):       Max-width container, larger spacing
2xl (1536px+):      Wide layouts, multi-panel views
```

**Touch targets**: Minimum 44x44px (WCAG), recommended 48x48px.

## Industry Design Reference

When designing for a specific product type, use this reference to select appropriate styles, colors, and typography.

### Style Guide by Industry

| Industry | Recommended Styles | Color Mood | Typography Mood | Anti-Patterns |
|----------|-------------------|------------|-----------------|---------------|
| **SaaS / B2B** | Glassmorphism + Flat Design | Trust blue + Accent contrast | Professional + Clean hierarchy | Heavy skeuomorphism, clip art icons |
| **Micro SaaS** | Minimalism + Flat Design | Indigo primary + Emerald CTA | Modern + Friendly | Overdesigned, complex layouts |
| **E-commerce** | Vibrant + Block-based | Success green + Urgency orange | Clear + Scannable | Low contrast CTAs, hidden prices |
| **E-commerce Luxury** | Liquid Glass + Glassmorphism | Premium dark + Gold accent | Serif elegant + Minimal | Vibrant/cheap aesthetics, cluttered layouts |
| **Fintech / Crypto** | Dark Mode + Glassmorphism | Gold trust + Purple tech | Monospace data + Sans UI | Playful fonts, bright pastels |
| **Financial Dashboard** | Minimalism + Accessible | Dark bg + Green/Red indicators | Tabular + High density | Decorative elements, low data density |
| **Healthcare** | Neumorphism + Accessible | Calm cyan + Health green | Rounded + Calm + Readable | Neon colors, motion-heavy animations |
| **Mental Health** | Soft UI + Organic | Warm pastels + Nature tones | Gentle serif + Rounded sans | Clinical/cold aesthetics, harsh contrasts |
| **Gaming** | 3D + Retro-Futurism | Vibrant neon + Immersive dark | Bold display + Impact | Corporate blues, minimal/flat |
| **Creative Agency** | Neubrutalism + Bold | High contrast + Saturated | Display + Expressive | Conservative, template-looking |
| **Portfolio** | Minimalism + Motion-Driven | Monochrome + Single accent | Swiss + Clean | Cluttered, over-animated |
| **Restaurant / Food** | Organic + Warm | Warm earth tones + Appetite colors | Elegant serif + Friendly sans | Cold/clinical, blue tones |
| **Hotel / Booking** | Glassmorphism + Elegant | Warm neutral + Gold accent | Refined serif + Light sans | Cheap-looking, cluttered |
| **Education** | Accessible + Friendly | Trustworthy blue + Warm accent | Readable + Clear hierarchy | Complex layouts, tiny text |
| **AI / Chatbot** | AI-Native UI + Glassmorphism | Indigo/Purple AI + Subtle gradients | Modern geometric sans | Skeuomorphic, retro |
| **Government** | Accessible + Minimalism | Professional blue + High contrast | System fonts + Maximum readability | Low contrast, decorative effects |
| **NFT / Web3** | Cyberpunk + Gradient Mesh | Neon + Dark + Chromatic | Bold futuristic + Mono | Corporate/traditional |
| **Kids / Education** | Playful + Claymorphism | Bright primary colors + Rounded | Rounded + Large + Friendly | Small text, dark themes, complex nav |

### UI Style Quick Reference

| Style | Key CSS | Best For | Avoid For |
|-------|---------|----------|-----------|
| **Glassmorphism** | `backdrop-filter: blur(15px); background: rgba(255,255,255,0.15); border: 1px solid rgba(255,255,255,0.2)` | Modern SaaS, fintech, modals | Low-perf devices, accessibility-critical |
| **Neumorphism** | `box-shadow: -5px -5px 15px rgba(0,0,0,0.1), 5px 5px 15px rgba(255,255,255,0.8)` | Wellness, meditation, fitness | Data-heavy, high contrast needs |
| **Neubrutalism** | `border: 3px solid black; box-shadow: 5px 5px 0px black; border-radius: 0` | Gen Z brands, startups, creative | Finance, healthcare, luxury |
| **Minimalism** | No decoration, grid 12-16 cols, single accent color, generous whitespace | Enterprise, dashboards, docs | Entertainment, gaming, kids |
| **Dark Mode (OLED)** | `background: #000; color: #E5E5E5; --accent: high-saturation` | Dev tools, gaming, fintech | Healthcare, education (primary) |
| **Liquid Glass** | Chromatic aberration, fluid animations 400-600ms, translucent layers | Luxury, premium apps | Performance-sensitive, accessibility |
| **Bento Box Grid** | CSS Grid with varied cell sizes, rounded corners, self-contained cards | Feature showcases, portfolios | Text-heavy, data tables |
| **Cyberpunk** | Neon glows, scanline effects, mono fonts, dark bg | Gaming, NFT, entertainment | Professional services, healthcare |

### Color Palette Reference

For each product type, use these as starting points (compatible with shadcn/ui CSS variables):

| Product Type | Primary | Accent | Background | Card | Destructive |
|-------------|---------|--------|------------|------|-------------|
| SaaS | `#2563EB` | `#EA580C` | `#F8FAFC` | `#FFFFFF` | `#DC2626` |
| Micro SaaS | `#6366F1` | `#059669` | `#F5F3FF` | `#FFFFFF` | `#DC2626` |
| E-commerce | `#059669` | `#EA580C` | `#ECFDF5` | `#FFFFFF` | `#DC2626` |
| Luxury | `#1C1917` | `#A16207` | `#FAFAF9` | `#FFFFFF` | `#991B1B` |
| B2B Service | `#0F172A` | `#0369A1` | `#F8FAFC` | `#FFFFFF` | `#DC2626` |
| Financial | `#0F172A` | `#22C55E` | `#020617` | `#0F172A` | `#EF4444` |
| Healthcare | `#0891B2` | `#059669` | `#ECFEFF` | `#FFFFFF` | `#DC2626` |
| Gaming | `#7C3AED` | `#F43F5E` | `#0F0F23` | `#1A1A2E` | `#F43F5E` |
| Fintech | `#F59E0B` | `#8B5CF6` | `#0F172A` | `#1E293B` | `#EF4444` |
| AI Platform | `#6366F1` | `#8B5CF6` | `#F5F3FF` | `#FFFFFF` | `#DC2626` |
| Restaurant | `#92400E` | `#DC2626` | `#FFFBEB` | `#FFFFFF` | `#DC2626` |
| Portfolio | `#0F172A` | `#2563EB` | `#FFFFFF` | `#F8FAFC` | `#DC2626` |

### Font Pairing Reference

| Pairing | Heading | Body | Best For | Google Fonts Import |
|---------|---------|------|----------|-------------------|
| **Modern Professional** | Poppins | Open Sans | SaaS, business, professional | `@import url('fonts.googleapis.com/css2?family=Open+Sans&family=Poppins:wght@500;600;700')` |
| **Tech Startup** | Space Grotesk | DM Sans | Tech, startups, AI products | `@import url('fonts.googleapis.com/css2?family=DM+Sans&family=Space+Grotesk:wght@500;700')` |
| **Classic Elegant** | Playfair Display | Inter | Luxury, fashion, editorial | `@import url('fonts.googleapis.com/css2?family=Inter&family=Playfair+Display:wght@600;700')` |
| **Minimal Swiss** | Inter | Inter | Dashboards, admin, enterprise | `@import url('fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700')` |
| **Friendly SaaS** | Plus Jakarta Sans | Plus Jakarta Sans | Web apps, B2B, dashboards | `@import url('fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700')` |
| **Developer** | JetBrains Mono | IBM Plex Sans | Dev tools, docs, CLIs | `@import url('fonts.googleapis.com/css2?family=IBM+Plex+Sans&family=JetBrains+Mono')` |
| **Wellness** | Lora | Raleway | Health, meditation, spa | `@import url('fonts.googleapis.com/css2?family=Lora:wght@500;600&family=Raleway')` |
| **Bold Statement** | Bebas Neue | Source Sans 3 | Marketing, portfolios, sports | `@import url('fonts.googleapis.com/css2?family=Bebas+Neue&family=Source+Sans+3')` |
| **Playful** | Fredoka | Nunito | Kids, education, gaming | `@import url('fonts.googleapis.com/css2?family=Fredoka:wght@400;500;600&family=Nunito')` |
| **News Editorial** | Newsreader | Roboto | News, blogs, journalism | `@import url('fonts.googleapis.com/css2?family=Newsreader&family=Roboto')` |

### Design System Generation Protocol

When building a new project's design system:

1. **Identify product type** from the Industry table above
2. **Select primary style** from the recommended styles column
3. **Apply palette** from the Color Palette Reference (adjust brand colors as needed)
4. **Choose font pairing** that matches the typography mood
5. **Check anti-patterns** -- verify your design avoids the listed anti-patterns for that industry
6. **Apply style CSS** from the UI Style Quick Reference
7. **Validate UX rules**: SVG icons (no emojis), cursor-pointer on clickables, transitions 150-300ms, text contrast 4.5:1+, focus states visible, `prefers-reduced-motion` respected

Enriched with industry data from nextlevelbuilder/ui-ux-pro-max-skill (161 rules, 67 styles, 161 palettes, 73 font pairings).

## Quality Checklist

Before completing any UI/UX task, verify:

- [ ] Design tokens are consistent (no magic numbers)
- [ ] Typography scale followed (no arbitrary font sizes)
- [ ] Spacing uses the 4px grid system
- [ ] All interactive elements have hover, focus, active, disabled states
- [ ] Forms have visible labels, inline validation, clear errors
- [ ] Loading states exist (skeleton or spinner)
- [ ] Empty states exist (illustration + CTA)
- [ ] Error states exist (with recovery actions)
- [ ] Mobile layout works at 320px minimum width
- [ ] Touch targets are minimum 44x44px
- [ ] Color contrast meets WCAG AA (4.5:1 text, 3:1 UI)
- [ ] Focus order is logical (tab through the page)
- [ ] Animations respect prefers-reduced-motion

## Common Pitfalls

- **Inconsistent spacing** → Always use token values, never arbitrary px
- **Missing states** → Every component needs default, hover, focus, disabled, loading, error
- **Placeholder-only labels** → Labels must be visible, persistent
- **Tiny touch targets** → Minimum 44px, add padding not just visual size
- **No empty states** → Users will see empty lists, design for them
- **Overusing animation** → Motion is seasoning, not the main course

---

**This skill ensures all UI/UX decisions follow a systematic, token-based approach that produces consistent, accessible, and delightful interfaces.**
