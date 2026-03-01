---
description: Comprehensive codebase onboarding for full-stack development expertise
---
# Onboarding Protocol

Execute phases systematically. Use parallel tool calls. Skip non-existent files.

## Phases
```json
{
  "1_context": {
    "docs": ["CLAUDE.md","README.md","package.json","docs/*.md","BRAINSTORM.md"],
    "structure": "ls -la; find {src,app,lib,pages,api,components} -type f \\( -name '*.ts*' -o -name '*.js*' -o -name '*.py' \\) | head -15",
    "stack": "package.json|requirements.txt|go.mod → frameworks, libs, testing, build tools"
  },
  "2_git": {
    "branches": "git branch -a; git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)|%(committerdate:relative)|%(subject)' | head -10",
    "commits": "git log --oneline --stat -20; git shortlog -sn --all | head -10",
    "status": "git status; git log --name-only --pretty=format: -10 | sort | uniq -c | sort -rn | head -20"
  },
  "3_architecture": {
    "app_structure": "Read main entry (layout.tsx|_app.tsx|App.vue|app.module.ts|index.js|main.py|server.ts)",
    "components": "List key modules/components + purposes",
    "libs": "Review utils, API clients, types, constants, configs",
    "configs": "tsconfig.json, *config.js|ts, .eslintrc*, .prettierrc, *test.config.*, .env.example"
  },
  "4_data": {
    "db": "Identify DB type, schema/migrations, ORM, models",
    "state": "Global state (Redux|Zustand|Context), local patterns, API state (React Query|SWR)",
    "api": "REST/GraphQL endpoints, auth patterns, error handling"
  },
  "5_quality": {
    "testing": "Unit/integration/e2e examples, coverage requirements",
    "tools": "Linting rules, formatting, pre-commit hooks, CI/CD"
  },
  "6_deploy": {
    "platform": "Vercel|Netlify|AWS|etc, build scripts, env vars",
    "cicd": "GitHub Actions, automation, pipelines"
  }
}
```

## Output
```yaml
Executive:
  project: "[Name] - [Purpose]"
  type: "Web app|API|Mobile|etc"
  stack: "[Key techs + versions]"
  phase: "[Status + recent progress]"

Map:
  structure: "Key dirs + files (tree format)"

Architecture:
  type: "SPA|SSR|API|monolith|microservices"
  frontend: "Components, routing, state"
  backend: "API, DB, auth"
  patterns: "[Consistent patterns used]"

Context:
  commits: "[Last 10 summary]"
  branches: "[Active streams]"
  velocity: "[Frequency + patterns]"

Stack:
  frontend: "[Frameworks, UI, styling]"
  backend: "[Server, DB, ORM]"
  devops: "[CI/CD, hosting]"
  testing: "[Frameworks, coverage]"

Patterns:
  naming: "[Convention]"
  components: "[Structure]"
  state: "[Management approach]"
  api: "[Call patterns]"
  errors: "[Handling approach]"

Priorities:
  current: "[What's being worked on]"
  next: "[What's planned]"

Readiness: "✅ Navigate codebase|Understand architecture|Implement features|Debug issues|Follow standards|Continue development"

Gaps: "[Unclear areas needing clarification]"

Recommendations: "[Doc improvements|Organization|Tests|Tech debt]"
```
