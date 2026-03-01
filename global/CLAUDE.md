# Claude Code — Development Framework

> You orchestrate, agents execute. Use specialized agents for their designated tasks rather than doing the work directly.

## System Architecture

This environment includes 7 auto-loaded rules (`~/.claude/rules/`), 19 commands, 26+ skills, 21 agents, and 5 hooks. All rules are loaded automatically — no imports needed.

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

### Agent Selection (use Task tool)

| Agent | Use For |
|-------|---------|
| research-agent | Technology research, API docs, best practices |
| planning-agent | Architecture, task breakdown, implementation plans |
| ux-agent | User flows, wireframes, accessibility |
| ui-agent | Visual design systems, component specs |
| backend-agent | APIs, database, server logic, authentication |
| frontend-agent | UI components, state management, styling |
| testing-agent | Unit tests, integration tests, E2E tests |
| documentation-agent | API docs, README, developer guides |
| build-validator-agent | TypeScript/ESLint quick validation |
| cleanup-agent | Dead code detection, debug artifact removal |
| version-control-agent | Git operations, commits, PRs |
| framework-specialist-agent | Next.js debugging, SSR/hydration issues |
| pattern-extractor-agent | Learning extraction from bug fixes |

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

| Skill | Triggers On |
|-------|-------------|
| validate-build | "validate", "check build", "type check" |
| fix-review | "review fix", "check fix", "did I miss anything" |
| scope-check | "scope check", "scope creep", "verify scope" |
| torvaldsen-onboard | "onboard", "get started", "what should I work on" |
| react-perf-check | "react performance", "slow render" |
| nextjs-debug | "nextjs debug", "404 error", "hydration" |
| tailwindcss-v4-styling | "TailwindCSS", "styling broken" |
| pattern-document | "document pattern", "create rule" |

### Behavioral Directives

1. **Automatic development recognition**: When user says "build", "create", "develop" → follow the 5-phase workflow in `rules/foundation.md`
2. **Parallel agent execution**: Spawn independent agents in the same message for maximum throughput
3. **Commit discipline**: Commit every 60 minutes during active development
4. **Error recovery**: If an agent reports a blocker → assess → spawn resolution agent → resume
5. **Context hygiene**: Run `/clear` between unrelated tasks
