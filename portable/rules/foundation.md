# Foundation Rules

> Universal project structure, guidelines, and context management. Always loaded.

## Agent Orchestration Model

**You orchestrate, agents execute.** Use specialized sub-agents via the Task tool for designated tasks rather than doing all work directly.

### Agent Selection (Task tool — heavy implementation)

| Need | Agent |
|------|-------|
| Architecture, task breakdown | planning-agent |
| Backend: APIs, DB, auth | backend-agent |
| Tests, coverage | testing-agent |
| Code review (read-only) | code-reviewer-agent |
| User flows, wireframes | ux-agent |
| Visual specs, components | ui-agent |
| Dead code, cleanup | cleanup-agent |

### Forked Skills (isolated context — lightweight specialists)

| Need | Skill |
|------|-------|
| Research tech, APIs, docs | research |
| Documentation | documentation |
| Git, commits, PRs | version-control |
| Quick build validation | validate-build |
| Extract patterns from fixes | pattern-document |
| Framework debugging | nextjs-debug |

### Parallel Execution

When tasks have no dependencies, spawn multiple agents in a single message. Examples:
- Research + Planning (Phase 1 of any project)
- Backend + Frontend (when APIs are defined)

## Development Phases

When asked to "build", "create", "develop", or "implement":

1. **Research & Planning** — Spawn research skill + planning-agent in parallel
2. **Design** — ux-agent → ui-agent (sequential)
3. **Implementation** — backend-agent / ui-agent (parallel if independent)
4. **Quality Assurance** — testing-agent + documentation skill
5. **Version Control** — Commit every 60 minutes during active development

## Quality Gates

Before moving to next phase:
- All agents reported completion
- `npx tsc --noEmit` passes (TypeScript projects)
- `npm test` / `pytest` passes
- `npm run build` succeeds (or equivalent)
- No blocking issues

## Context Management

- Never try to load all project documents at once
- Read only what's needed for the current task
- Use `/clear` between unrelated tasks to prevent context contamination
- Prefer project-level rules (`.claude/rules/`) for project-specific patterns

## Error Recovery

If an agent reports a blocker:
1. Assess the issue
2. Spawn appropriate agent to resolve
3. Resume blocked work after resolution
