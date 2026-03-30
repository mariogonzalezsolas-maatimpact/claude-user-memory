---
name: git-worktrees
description: "Systematic workspace isolation using git worktrees. Creates isolated branches with project setup auto-detection, baseline test verification, and safe directory management. Works on Unix and Windows."
auto_invoke: false
tags: [git, worktree, isolation, workspace, branching]
---

# Git Worktrees Skill

Provides systematic workspace isolation using git worktrees. Each feature gets its own working directory with a dedicated branch, ensuring clean separation between concurrent work streams.

## When Claude Should Use This Skill

Use this skill when:
- User requests workspace isolation: "use worktree", "isolate workspace"
- Working on multiple features concurrently
- Code-coordinator needs isolated environment for risky changes
- User explicitly invokes worktree setup

**Do NOT invoke when:**
- Simple single-file changes
- User is already in a worktree
- Repository is in detached HEAD state
- User opts out: "no worktree", "same branch"

## Core Protocol

### Step 1: Directory Selection

Priority order:

1. **User-specified** -- If user provides a path, use it
2. **Project convention** -- Check CLAUDE.md for preferred worktree location
3. **Existing directory** -- Check for `.worktrees/` or `worktrees/` in project root
4. **Default** -- `../<repo-name>-worktrees/<feature-name>`
5. **Ask user** -- If none of the above apply

### Step 2: Safety Verification

Before creating a worktree in a project-local directory:

```bash
# Check if the target directory would be git-ignored
git check-ignore -q "<target-path>" 2>/dev/null
if [ $? -ne 0 ]; then
    # Not ignored -- add to .gitignore first
    echo "<target-path>" >> .gitignore
    git add .gitignore
    git commit -m "chore: add worktree directory to .gitignore"
fi
```

**Why critical**: Prevents accidentally committing worktree contents to repository.

### Step 3: Worktree Creation

```bash
# Detect project name
PROJECT_NAME=$(basename "$(git rev-parse --show-toplevel)")

# Create branch name from feature description
BRANCH_NAME="feature/<feature-slug>"

# Create the worktree
git worktree add "<target-path>" -b "$BRANCH_NAME"
```

### Step 4: Project Setup Auto-Detection

| Detector File | Setup Command |
|--------------|---------------|
| `package.json` + `package-lock.json` | `npm ci` |
| `package.json` + `yarn.lock` | `yarn install --frozen-lockfile` |
| `package.json` + `pnpm-lock.yaml` | `pnpm install --frozen-lockfile` |
| `Cargo.toml` | `cargo build` |
| `requirements.txt` | `pip install -r requirements.txt` |
| `pyproject.toml` | `pip install -e .` or `poetry install` |
| `go.mod` | `go mod download` |
| `Gemfile` | `bundle install` |
| `composer.json` | `composer install` |

### Step 5: Baseline Test Verification

```bash
cd "<target-path>"
# Auto-detect and run test suite
```

If tests fail on a clean worktree: **STOP and report** -- the main branch has broken tests.

### Step 6: Report

```
Worktree created:
  Location: <target-path>
  Branch: <branch-name>
  Base: <parent-branch> @ <short-hash>
  Setup: <command> -- [PASS/FAIL]
  Tests: [N] passing, [N] failing

Ready for development. Cleanup when done:
  git worktree remove <target-path>
  git branch -d <branch-name>
```

## Cleanup Protocol

When feature work is complete:

```bash
# From the main working directory (not the worktree)
git worktree remove "<target-path>"
git branch -d "<branch-name>"  # Only if merged
```

## Quick Reference

| Situation | Action |
|-----------|--------|
| `.worktrees/` exists | Use it (verify ignored) |
| `worktrees/` exists | Use it (verify ignored) |
| Both exist | Use `.worktrees/` |
| Neither exists | Check CLAUDE.md -> default -> ask |
| Directory not ignored | Add to .gitignore, commit, proceed |
| Tests fail on baseline | STOP, report failures, ask user |
| No test runner detected | Skip test verification, warn user |

## Quality Checklist

- [ ] Directory is git-ignored (if project-local)
- [ ] Worktree created with dedicated branch
- [ ] Project dependencies installed
- [ ] Baseline tests pass (clean slate)
- [ ] Location reported to user
- [ ] Cleanup instructions provided
