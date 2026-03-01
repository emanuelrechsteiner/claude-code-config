# Workflow & Git Rules

> Git conventions, branch management, PR process, and context hygiene.

## Branch Management

- **One Issue = One Branch = One PR** — Never combine issues
- Branch from `main` (or `development` if project uses it)
- Branch naming: `<type>/issue-<number>-<kebab-description>`
  - Example: `feat/issue-42-jwt-token-refresh`
- Types: `feat`, `fix`, `refactor`, `test`, `docs`, `style`, `chore`, `perf`

## Commit Format

```
<type>(<area>): <description> - closes #<issue-number>

<body>

Co-Authored-By: Claude <noreply@anthropic.com>
```

- **Types:** feat, fix, refactor, test, docs, style, chore, perf
- **Areas:** auth, api, ui, db, config, test, core, infra, status, architecture, conventions
- Every code commit references an issue number (docs-only may omit)
- **Separation of concerns:** Never mix code changes and doc changes in same commit
- Commit every 60 minutes during active development

## Pre-Commit Checklist

Before every commit:
- [ ] Type checker passes (`tsc --noEmit` / `mypy`)
- [ ] Tests pass (`npm test` / `pytest`)
- [ ] Linter passes (`eslint` / `ruff`)
- [ ] Build succeeds (`npm run build`)
- [ ] No debug statements (`console.log`, `print()`, `debugger`)
- [ ] No stray characters at EOF
- [ ] Commit message follows format
- [ ] Issue number referenced

## Pull Requests

- PR title: Clear description of what and why
- PR body includes:
  - Linked issue reference
  - Summary of changes
  - Testing checklist
  - Acceptance criteria verification
- PRs always target `main` or `development` (never other feature branches)
- Self-review before requesting review

## Context Hygiene

**MANDATORY: Run `/clear` between issues.**

Symptoms of context contamination:
- "Based on the authentication work we did earlier..."
- "Using the same pattern as before..."
- Reusing variable names from a different issue

Signs of good context hygiene:
- Reading the issue fresh every time
- Checking what actually exists in the codebase
- Validating assumptions rather than carrying them over

## Forbidden Actions

- Direct commits to main/master/development
- Skipping `/clear` between issues
- Implementing beyond the issue's scope
- Skipping PR creation
- PRs without linked issues
- Skipping tests
- Committing secrets
- Merging without review
- Force pushing to shared branches
