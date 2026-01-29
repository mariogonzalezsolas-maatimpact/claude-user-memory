---
name: do
description: Intelligent command router. Analyzes your request and automatically selects the best command, agent, or workflow to execute. Just tell it what you want. Auto-gathers context on first use.
---

# /do Command

**The Universal Command** - Just say what you want, and I'll figure out how to do it.

## Usage

```bash
/do [anything you want]
```

## First Use in Session - Automatic Context Gathering

**On first `/do` of the session**, automatically gather project context:

### Step 0: Context Discovery (First Use Only)

**Execute these searches in parallel**:

1. **Find project CLAUDE.md**:
   ```
   Look for: ./CLAUDE.md, ./.claude/CLAUDE.md, ./docs/CLAUDE.md
   ```

2. **Find key documentation**:
   ```
   Glob: **/*.md (limit to first 20)
   Priority: README.md, CONTRIBUTING.md, ARCHITECTURE.md, docs/*.md
   ```

3. **Detect project type**:
   ```
   Look for: package.json, Cargo.toml, go.mod, requirements.txt, pom.xml
   Extract: project name, version, main dependencies
   ```

4. **Find existing context artifacts**:
   ```
   Look for: ResearchPack*.md, ImplementationPlan*.md, knowledge-core.md
   In: ./, ./.claude/, ./docs/
   ```

5. **Check circuit breaker state**:
   ```
   Read: ~/.claude/.circuit-breaker-state
   ```

**Report context summary**:
```
📍 Project Context Loaded
   Project: [name from package.json or directory]
   Type: [Node.js/Python/Rust/Go/etc]
   CLAUDE.md: [Found/Not found]
   Existing artifacts: [ResearchPack, Plan, etc. or None]
   Circuit breaker: [CLOSED/OPEN]

Ready to help. What do you need?
```

**Then proceed to intent classification.**

## Examples

```bash
/do add authentication to my API
/do why is this function slow?
/do research how to use Redis
/do check if my context is getting too large
/do deploy to production
/do fix the bug in login.js
/do explain this codebase
```

## How It Works

I analyze your request and automatically route to the best approach:

| Your Intent | I Execute |
|-------------|-----------|
| Build/Add/Create feature | `/workflow` (full automation) |
| Research/Learn/Understand | `/research` + summary |
| Plan/Design/Architect | `/plan` (create blueprint) |
| Implement/Code/Fix (with plan) | `/implement` |
| Debug/Investigate/Why | `@brahma-investigator` |
| Deploy/Release | `@brahma-deployer` |
| Optimize/Performance | `@brahma-optimizer` |
| Monitor/Observe | `@brahma-monitor` |
| Analyze code/patterns | `@brahma-analyzer` |
| Context/Memory issues | `/context analyze` |
| Complex multi-domain | `@chief-architect` |
| Simple question | Direct answer |

## Decision Logic

**Executing command...**

Analyze the user's request using this decision tree:

### Step 1: Classify Intent

**Keywords indicating WORKFLOW** (full automation):
- "add", "create", "build", "implement", "make", "develop"
- "feature", "functionality", "system", "module"
- "with", "using", "that does"
- Example: "add Redis caching to the API"

**Keywords indicating RESEARCH only**:
- "research", "learn", "understand", "how does", "what is"
- "documentation", "docs", "API reference"
- "best practices", "patterns"
- Example: "research JWT authentication best practices"

**Keywords indicating PLAN only**:
- "plan", "design", "architect", "structure"
- "how should I", "what's the best way"
- "strategy", "approach"
- Example: "plan the database migration strategy"

**Keywords indicating IMPLEMENT only**:
- "implement the plan", "execute", "code this"
- "finish", "complete the implementation"
- Example: "implement the plan we just made"

**Keywords indicating DEBUG/INVESTIGATE**:
- "why", "debug", "investigate", "fix", "broken"
- "error", "bug", "issue", "problem", "failing"
- "not working", "crashed"
- Example: "why is the login failing?"

**Keywords indicating DEPLOY**:
- "deploy", "release", "ship", "push to production"
- "rollout", "launch"
- Example: "deploy v2.0 to production"

**Keywords indicating OPTIMIZE**:
- "optimize", "performance", "slow", "faster"
- "speed up", "improve", "scale"
- Example: "optimize the database queries"

**Keywords indicating MONITOR**:
- "monitor", "observe", "metrics", "logs"
- "alert", "dashboard", "health"
- Example: "set up monitoring for the API"

**Keywords indicating ANALYZE**:
- "analyze", "review", "check", "validate"
- "consistency", "patterns in code"
- Example: "analyze the authentication patterns in codebase"

**Keywords indicating CONTEXT issues**:
- "context", "memory", "tokens", "too long"
- "optimize context", "reduce", "clean up"
- Example: "my context is getting too large"

**Keywords indicating COMPLEX orchestration**:
- "complete", "full", "entire", "end-to-end"
- Multiple domains mentioned (frontend + backend + database)
- "everything needed for"
- Example: "build complete e-commerce checkout system"

### Step 2: Execute Decision

Based on classification, announce what you're doing:

```
🎯 Intent detected: [CATEGORY]
📋 Executing: [COMMAND/AGENT]
💡 Reason: [WHY THIS CHOICE]

---
[Execute the chosen command/agent]
```

### Step 3: Fallback Logic

If intent is unclear:
1. Ask ONE clarifying question with options
2. Default to `/workflow` for feature requests
3. Default to `@brahma-investigator` for problems/issues
4. Default to `/research` for questions

### Step 4: Smart Enhancements

**Auto-detect complexity**:
- Simple task (1-2 files) → Direct implementation
- Medium task (3-5 files) → `/workflow`
- Complex task (6+ files, multiple domains) → `@chief-architect`

**Auto-detect urgency**:
- "urgent", "asap", "quick" → Skip extensive research, focus on solution
- "careful", "safe", "production" → Full workflow with all quality gates

**Auto-detect existing context**:
- ResearchPack exists → Skip to `/plan`
- Plan exists → Skip to `/implement`
- Nothing exists → Start with `/research` or `/workflow`

## Examples with Routing

**User**: `/do add user authentication`
```
🎯 Intent: BUILD FEATURE
📋 Executing: /workflow add user authentication
💡 Reason: "add" + "authentication" = new feature requiring research, planning, and implementation
```

**User**: `/do why is my API slow?`
```
🎯 Intent: DEBUG/INVESTIGATE
📋 Executing: @brahma-investigator analyze API performance issue
💡 Reason: "why" + "slow" = performance investigation needed
```

**User**: `/do learn about WebSockets`
```
🎯 Intent: RESEARCH
📋 Executing: /research WebSockets
💡 Reason: "learn about" = research request, no implementation needed
```

**User**: `/do my context is huge`
```
🎯 Intent: CONTEXT MANAGEMENT
📋 Executing: /context analyze
💡 Reason: "context" + size concern = context optimization needed
```

**User**: `/do deploy the new version`
```
🎯 Intent: DEPLOYMENT
📋 Executing: @brahma-deployer
💡 Reason: "deploy" = production deployment workflow
```

## Context Awareness Throughout Session

### Continuous Context Monitoring

Every `/do` command checks:
- **Existing ResearchPack** → Can skip research phase
- **Existing Plan** → Can skip planning phase
- **Recent errors** → May need investigation first
- **Circuit breaker state** → May be blocked
- **Session history** → What we already discussed

### Smart Continuation

If you say `/do continue` or `/do next`:
- Looks at what was done before
- Continues from where we left off
- Example: Research done → Proceeds to Plan

### Context Commands

```bash
/do what's the context?     → Shows current project state
/do clean up context        → Runs /context optimize
/do start fresh             → Runs /context reset
/do what did we do?         → Summarizes session actions
```

## Benefits

- **No need to memorize commands** - Just say what you want
- **Intelligent routing** - I pick the best tool for the job
- **Context aware** - I check what's already done
- **Auto-discovery** - Finds CLAUDE.md, docs, and artifacts
- **Complexity detection** - Simple tasks stay simple
- **Session memory** - Remembers what we've done
- **One entry point** - `/do` handles everything
