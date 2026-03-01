---
description: Explore the repo, audit+consolidate docs, and (optionally) bootstrap Claude assets (CLAUDE.md, subagents, hooks). Read-only by default; asks before writing.
argument-hint: [--docs-only | --bootstrap-only | --agents | --hooks | --yes] [notes]
model: claude-sonnet-4-20250514
allowed-tools: Read, Glob, Grep, LS, Bash(git status:*), Bash(git rev-parse:*), Bash(git branch:*), Bash(git log:*), Bash(pwd:*), Bash(echo:*)
---
# Repo Explorer & Docs Consolidator

Import @.claude/agents/project-bootstrap-agent.md

## Flags
Parse $ARGUMENTS: `--docs-only|--bootstrap-only|--agents|--hooks|--yes`

## Context (auto)
```bash
git rev-parse --show-toplevel  # Root
git branch --show-current      # Branch
git status -s                  # Status
git log --oneline -10          # Commits
```

## Principles
EXPLORE → PLAN → EXECUTE → SUMMARIZE. Read-first (Read, Glob, Grep, LS). Ask before Edit/Write/Bash. Redact secrets. Ignore: node_modules, .next, .turbo, dist, build, .venv, target, coverage, .git

## Explore (fast scan)
```json
{
  "detect": "Languages, frameworks, pkg mgrs, build/test tools, containers, CI, ORM, APIs, DBs, env",
  "skim": {
    "root": "README*, CONTRIBUTING*, CHANGELOG*, LICENSE, .editorconfig",
    "deps": "package.json, pnpm-workspace.yaml, pyproject.toml, requirements*.txt, go.mod, Gemfile, Cargo.toml",
    "runtime": "/apps, /packages, /services, /src, /server, /api, /db/migrations, /prisma",
    "config": "docker-compose*, Dockerfile*, vitest.config.*, jest.*, pytest.ini, playwright.*, eslint.*, prettier.*"
  },
  "docs_audit": "Search README.md, ARCHITECTURE*, API*, DATA*, SETUP*, SECURITY*, /docs/**, /adr/** → assess freshness + correctness"
}
```

## Plan (print first)
Output: Standard docs to create/update, existing docs (CONSOLIDATE|ARCHIVE), deletions, Claude assets if requested. Pause for approval (unless --yes).

## Execute (after approval)
```json
{
  "0_consolidate": "UP-TO-DATE → fold into targets, delete. OUTDATED → move to docs/history/YYYY-MM-DD/, fix links",
  "1_docs": "Create/update: overview.md, architecture.md, api.md, data-model.md, dev-setup.md, testing.md, security.md, code-map.md, decisions/0001-baseline.md (include Mermaid diagrams)",
  "2_bootstrap": "If --agents|--bootstrap-only: .claude/agents/. If --hooks|--bootstrap-only: .claude/settings.json + hooks/ (chmod +x)",
  "3_migrate": "Legacy content → new docs/CLAUDE.md, archive original to docs/history/"
}
```

## Summarize
Checklist: created/updated, archived+locations, deleted, TODOs, exact commands to run app+tests

## Permission
Show actions, wait for approval (unless --yes). Default: read-only.
