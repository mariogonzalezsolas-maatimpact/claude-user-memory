# Skills Overview

5 auto-invoked skills that enhance agent capabilities:

| Skill | Triggers When | Key Function |
|-------|--------------|--------------|
| research-methodology | Library/API implementation needed | Fetches version-accurate docs, assembles ResearchPack (<2 min) |
| planning-methodology | Research -> plan transformation | Minimal-change blueprints with rollback procedures |
| quality-validation | ResearchPack or Plan completed | Scores and gates: Research 80+, Plan 85+ |
| pattern-recognition | After successful implementation | Captures patterns to knowledge-core.md |
| context-engineering | Session start, every 50 msgs, task switch | Context rot prevention (39% improvement, 84% token reduction) |

## How They Work Together

```
User: "Add Redis caching"
  1. research-methodology -> ResearchPack
  2. quality-validation -> Score >= 80? Proceed
  3. planning-methodology -> Implementation Plan
  4. quality-validation -> Score >= 85? Proceed
  5. [code-implementer executes with TDD]
  6. pattern-recognition -> Captures to knowledge-core.md
  7. context-engineering -> Archives completed, loads next task
```

## Commands

- `/context analyze` - Show context health
- `/context optimize` - Prune stale context
- `/context reset` - Fresh start

---

**Updated**: 2026-02-20 | **Version**: 5.4.0
