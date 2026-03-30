# Research Before Code

## Phase 0: Mandatory Research

Before writing ANY new implementation:

1. **Search existing code first**: Look in the current codebase for existing implementations, patterns, and utilities that solve the same problem
2. **Check package registries**: Search npm, PyPI, crates.io, etc. before writing utility code. Prefer battle-tested libraries over hand-rolled solutions
3. **Read official docs**: Confirm API behavior, version-specific details from official documentation
4. **Search for adaptable implementations**: Look for open-source projects solving 80%+ of the problem

## Key Principle
Prefer adopting or porting a proven approach over writing net-new code when it meets the requirement. The best code is code you don't write.

## Anti-Pattern
Writing new utility functions, helpers, or implementations without first checking if:
- The codebase already has something similar
- A well-maintained package exists
- An open-source implementation can be adapted

**Integration**: For external library/API research, use `@docs-researcher` or `/research` command rather than ad-hoc web searches. This ensures version-accurate documentation with quality scoring.

Adapted from affaan-m/everything-claude-code development-workflow rules.
