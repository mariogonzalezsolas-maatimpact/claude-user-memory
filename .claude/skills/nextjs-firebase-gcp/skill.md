---
name: nextjs-firebase-gcp
description: "Full-stack patterns for Next.js + PostgreSQL + Firebase + Google Cloud projects. Covers Server Components, Prisma ORM, Firebase Auth/Firestore, GCP deployment, and integration patterns. Auto-invoked when working on projects with this stack."
auto_invoke: true
tags: [nextjs, react, firebase, postgresql, prisma, gcp, google-cloud, fullstack]
---

# Next.js + Firebase + GCP Stack Skill

Full-stack patterns for the Node.js / React / Next.js / PostgreSQL / Firebase / Google Cloud stack.

## When Claude Should Use This Skill

Claude will automatically invoke this skill when:
- Project has `next.config.*` + `prisma/schema.prisma` + Firebase dependencies
- Working on Next.js App Router with database operations
- Integrating Firebase Auth with PostgreSQL user records
- Deploying to Google Cloud (Cloud Run, App Engine, Cloud Functions)

**Do NOT invoke when:**
- Project doesn't use Next.js (plain React, Remix, etc.)
- Project uses MongoDB instead of PostgreSQL
- Project uses AWS/Azure instead of GCP

## Architecture Pattern

```
┌─────────────────────────────────────────────┐
│  Next.js App (Vercel or GCP Cloud Run)       │
│  ┌──────────────┐  ┌──────────────────────┐ │
│  │ Server       │  │ Client Components    │ │
│  │ Components   │  │ ('use client')       │ │
│  │ + Actions    │  │ React hooks, forms   │ │
│  │ Prisma ORM   │  │ Firebase JS SDK      │ │
│  └──────┬───────┘  └──────────┬───────────┘ │
│         │                     │              │
│  ┌──────▼───────┐  ┌─────────▼───────────┐ │
│  │ PostgreSQL   │  │ Firebase             │ │
│  │ (Prisma)     │  │ Auth + Firestore     │ │
│  │ Main data    │  │ Sessions + Realtime  │ │
│  └──────────────┘  └─────────────────────┘ │
└─────────────────────────────────────────────┘
         │                     │
         ▼                     ▼
┌──────────────┐    ┌───────────────────┐
│ Cloud SQL    │    │ Firebase Console  │
│ (PostgreSQL) │    │ Auth, Firestore   │
└──────────────┘    └───────────────────┘
```

## Firebase Auth + PostgreSQL Integration

### Pattern: Firebase Auth for authentication, PostgreSQL for user data

```typescript
// lib/auth.ts
import { getAuth } from 'firebase-admin/auth'
import { prisma } from '@/lib/db'

export async function getOrCreateUser(firebaseToken: string) {
  const decoded = await getAuth().verifyIdToken(firebaseToken)

  const user = await prisma.user.upsert({
    where: { firebaseUid: decoded.uid },
    update: { lastLoginAt: new Date() },
    create: {
      firebaseUid: decoded.uid,
      email: decoded.email!,
      name: decoded.name || '',
    },
  })

  return user
}
```

### Pattern: Middleware for auth

```typescript
// middleware.ts
import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'

export function middleware(request: NextRequest) {
  const session = request.cookies.get('session')

  if (!session && request.nextUrl.pathname.startsWith('/dashboard')) {
    return NextResponse.redirect(new URL('/login', request.url))
  }

  return NextResponse.next()
}

export const config = {
  matcher: ['/dashboard/:path*', '/api/:path*']
}
```

### Firebase Admin (server-side only)

```typescript
// lib/firebase-admin.ts
import { initializeApp, cert, getApps } from 'firebase-admin/app'

if (!getApps().length) {
  initializeApp({
    credential: cert({
      projectId: process.env.FIREBASE_PROJECT_ID,
      clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
      privateKey: process.env.FIREBASE_PRIVATE_KEY?.replace(/\\n/g, '\n'),
    }),
  })
}

export { getAuth } from 'firebase-admin/auth'
export { getFirestore } from 'firebase-admin/firestore'
```

**Never import firebase-admin in client components.** Use `server-only` package.

## Database + Prisma Patterns

### Prisma Client Singleton

```typescript
// lib/db.ts
import { PrismaClient } from '@prisma/client'

const globalForPrisma = globalThis as unknown as { prisma: PrismaClient }

export const prisma = globalForPrisma.prisma || new PrismaClient()

if (process.env.NODE_ENV !== 'production') globalForPrisma.prisma = prisma
```

### Server Action with Validation

```typescript
// app/actions/items.ts
'use server'

import { z } from 'zod'
import { prisma } from '@/lib/db'
import { revalidatePath } from 'next/cache'

const CreateItemSchema = z.object({
  name: z.string().min(1).max(200),
  description: z.string().optional(),
})

export async function createItem(formData: FormData) {
  const parsed = CreateItemSchema.safeParse(Object.fromEntries(formData))

  if (!parsed.success) {
    return { error: parsed.error.flatten().fieldErrors }
  }

  await prisma.item.create({ data: parsed.data })
  revalidatePath('/items')
  return { success: true }
}
```

## Google Cloud Deployment

### Cloud Run (recommended for Next.js)

```dockerfile
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npx prisma generate
RUN npm run build

FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public
EXPOSE 3000
CMD ["node", "server.js"]
```

### Cloud SQL Connection
- Use Cloud SQL Auth Proxy in production
- Connection: `DATABASE_URL="postgresql://user:pass@/dbname?host=/cloudsql/PROJECT:REGION:INSTANCE"`
- Enable `output: 'standalone'` in `next.config.js` for Cloud Run

### Environment Variables
- Use Google Secret Manager for production secrets
- Use `.env.local` for development (gitignored)
- Required vars: `DATABASE_URL`, `FIREBASE_PROJECT_ID`, `FIREBASE_CLIENT_EMAIL`, `FIREBASE_PRIVATE_KEY`

## Testing Patterns

### E2E: Playwright
```typescript
import { test, expect } from '@playwright/test'

test('user can create item', async ({ page }) => {
  await page.goto('/items/new')
  await page.fill('[name="name"]', 'Test Item')
  await page.click('button[type="submit"]')
  await expect(page.locator('text=Test Item')).toBeVisible()
})
```

### Integration: Vitest + Prisma
```typescript
import { describe, it, expect, beforeEach } from 'vitest'
import { prisma } from '@/lib/db'

beforeEach(async () => {
  await prisma.item.deleteMany()
})

describe('createItem', () => {
  it('creates item in database', async () => {
    // test with real database
  })
})
```

## Quality Checklist

Before completing any work on this stack:
- [ ] Server Components used by default (no unnecessary 'use client')
- [ ] Data fetching in Server Components or Server Actions (not useEffect)
- [ ] Prisma queries use `select` or `include` (not `findMany()` without limits)
- [ ] Firebase Admin only on server side (`server-only` package)
- [ ] Environment variables validated with Zod
- [ ] Mutations use Server Actions with Zod validation
- [ ] `revalidatePath`/`revalidateTag` after mutations
- [ ] Images use `next/image`, fonts use `next/font`
- [ ] PostgreSQL queries paginated (no unbounded `findMany`)
