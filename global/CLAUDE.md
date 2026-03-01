# Claude Code — Development Framework

> You orchestrate, agents execute. Use specialized agents for heavy implementation and forked skills for diagnostics/utilities.

## System Architecture

This environment includes 7 auto-loaded rules (`~/.claude/rules/`), 10 commands, 22 skills (6 forked, 5 background), 7 agents, and 5 hooks. Token optimization is active via `env` settings.

### Auto-Loaded Rules (always in context)

| Rule | Governs |
|------|---------|
| foundation | Agent orchestration, dev phases, quality gates |
| code-quality | TypeScript/Python standards, naming, imports |
| testing-quality | Testing cadence, coverage targets, validation |
| security | Input validation, secrets, auth, data protection |
| workflow-git | Branches, commits, PRs, context hygiene |
| documentation | Active/archived docs, JSDoc, README |
| mcp-tool-usage | MCP path conventions, parameter formats |

### Agent Selection (use Task tool — for heavy implementation work)

| Agent | Model | Use For |
|-------|-------|---------|
| planning-agent | opus | Architecture, task breakdown, implementation plans |
| backend-agent | sonnet | APIs, database, server logic, authentication |
| testing-agent | sonnet | Unit tests, integration tests, E2E tests |
| code-reviewer-agent | sonnet | Code review (READ-ONLY — cannot edit files) |
| cleanup-agent | haiku | Dead code detection, debug artifact removal |
| ux-agent | sonnet | User flows, wireframes, accessibility |
| ui-agent | sonnet | Visual design systems, component specs, component implementation |

### Forked Skills (replace former agents — run in isolated context)

| Skill | Model | Replaces |
|-------|-------|----------|
| validate-build | haiku | build-validator-agent |
| research | haiku | research-agent |
| version-control | haiku | version-control-agent |
| nextjs-debug | haiku | framework-specialist-agent |
| pattern-document | sonnet | pattern-extractor-agent |
| documentation | sonnet | documentation-agent |

### Torvaldsen Workflow (for managed projects)

For projects with a `.torvaldsen/` directory, use the Torvaldsen atomic development workflow:

| Command | Purpose |
|---------|---------|
| /brainstorm | Transform app idea → 9 product foundation docs |
| /decompose | Convert BRAINSTORM.md → GitHub issues + milestones |
| /issue \<#\> | Full 9-phase dev workflow for one issue |
| /review \<PR#\> | 10-phase code review with scope verification |
| /phase-gate \<N\> | Verify phase completion before unlocking next |
| /status-sync | Sync PROJECT-STATUS.md with GitHub reality |
| /handoff | Create context transfer document for next agent |
| /lessons | Extract reusable patterns from completed work |

Torvaldsen rules (commits, scope, workflow) are installed per-project by `/brainstorm`, not loaded globally.

### Key Skills (auto-triggered)

| Skill | Triggers On | Mode |
|-------|-------------|------|
| validate-build | "validate", "check build", "type check" | forked |
| research | "research", "best practices", "API docs" | forked |
| version-control | "git", "commit", "branch", "PR" | forked |
| nextjs-debug | "nextjs debug", "404 error", "hydration" | forked |
| pattern-document | "document pattern", "create rule" | forked |
| documentation | "document", "README", "API docs" | forked |
| scope-check | "scope check", "scope creep", "verify scope" | main |
| torvaldsen-onboard | "onboard", "get started", "what should I work on" | main |

### Background Skills (auto-trigger only, hidden from menu)

react-perf-check, tailwindcss-v4-styling, import-fixer, fix-review, orchestration

### Token Optimization

Context window efficiency — keep agent outputs small so they don't fill up the main context:

- Extended thinking capped at 10K tokens (`MAX_THINKING_TOKENS`) — prevents runaway reasoning
- Auto-compact at 90% context usage (`CLAUDE_AUTOCOMPACT_PCT_OVERRIDE`) — compacts before window fills

### Behavioral Directives

1. **Automatic development recognition**: When user says "build", "create", "develop" → follow the 5-phase workflow in `rules/foundation.md`
2. **Parallel agent execution**: Spawn independent agents in the same message for maximum throughput
3. **Commit discipline**: Commit every 60 minutes during active development
4. **Error recovery**: If an agent reports a blocker → assess → spawn resolution agent → resume
5. **Context hygiene**: Run `/clear` between unrelated tasks
