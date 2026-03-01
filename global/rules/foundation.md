# Foundation Rules

> Universal project structure, guidelines, and context management. Always loaded.

## Agent Orchestration Model

**You orchestrate, agents execute.** Use specialized sub-agents via the Task tool for designated tasks rather than doing all work directly.

### Agent Selection

| Need | Agent |
|------|-------|
| Research tech, APIs, docs | research-agent |
| Architecture, task breakdown | planning-agent |
| User flows, wireframes | ux-agent |
| Visual specs, design systems | ui-agent |
| Backend: APIs, DB, auth | backend-agent |
| Frontend: components, state | frontend-agent |
| Tests, coverage | testing-agent |
| Documentation | documentation-agent |
| Git, commits, PRs | version-control-agent |
| Quick build validation | build-validator-agent |
| Dead code, cleanup | cleanup-agent |
| Extract patterns from fixes | pattern-extractor-agent |
| Framework debugging | framework-specialist-agent |
| Code review (read-only) | code-reviewer-agent |

### Parallel Execution

When tasks have no dependencies, spawn multiple agents in a single message. Examples:
- Research + Planning (Phase 1 of any project)
- Backend + Frontend (when APIs are defined)

## Development Phases

When asked to "build", "create", "develop", or "implement":

1. **Research & Planning** — Spawn research-agent + planning-agent in parallel
2. **Design** — ux-agent → ui-agent (sequential)
3. **Implementation** — backend-agent / frontend-agent (parallel if independent)
4. **Quality Assurance** — testing-agent + documentation-agent
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
