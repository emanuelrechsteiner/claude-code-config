# How to Use This System

> Practical guide to getting the most out of your Claude Code configuration.

---

## Mental Model

Think of this system in three layers:

```
You (human)
  │
  ▼
Claude Code (orchestrator) ← rules, skills, commands loaded automatically
  │
  ▼
Sub-agents (specialists) ← spawned on demand via Task tool
```

**You talk to Claude Code. Claude Code delegates to specialists.** You never need to manage agents directly — just describe what you want and the system routes work to the right place.

---

## The Three Execution Modes

### 1. Skills — Lightweight specialists (run inline or forked)

Skills are loaded into context automatically and trigger on keywords. You don't need to invoke them — just talk naturally.

| Say this... | Skill activates |
|-------------|----------------|
| "validate the build" | validate-build |
| "research Firebase auth patterns" | research |
| "fix the broken imports" | import-fixer |
| "check the scope" | scope-check |
| "debug this Next.js 404" | nextjs-debug |
| "document this pattern as a rule" | pattern-document |

**Forked skills** (marked in CLAUDE.md) run in an isolated context — they don't pollute your main conversation with large outputs. These replaced former lightweight agents.

**Background skills** trigger automatically without appearing in the `/skills` menu. You'll never invoke them directly — they activate when relevant patterns are detected (e.g., react-perf-check activates when React performance issues are discussed).

### 2. Agents — Heavy specialists (run as sub-processes)

Agents are for substantial implementation work. They run as sub-processes with their own context window and return results.

| Agent | When to use |
|-------|-------------|
| **planning-agent** (Opus) | Architecture decisions, task breakdown, implementation plans |
| **backend-agent** | APIs, database schemas, server logic, authentication |
| **ux-agent** | User flows, wireframes, accessibility specs |
| **ui-agent** | Visual design systems, component specs, component implementation |
| **testing-agent** | Unit tests, integration tests, E2E tests |
| **code-reviewer-agent** | Code review (read-only — cannot edit files) |
| **cleanup-agent** | Dead code detection, debug artifact removal |

**UX → UI Pipeline:** The ux-agent produces experience specs (UX-DESIGN.md) that the ui-agent consumes for visual design and implementation. When building UI features, spawn ux-agent first, then ui-agent.

You don't typically spawn agents yourself — Claude Code does it when you describe work that matches an agent's expertise. But you can be explicit: "use the backend-agent to implement the API endpoint."

### 3. Commands — Structured workflows (slash commands)

Commands are multi-step procedures you invoke explicitly with `/command-name`.

**General commands:**

| Command | Purpose |
|---------|---------|
| `/bootstrap` | Explore a new repo, audit docs, optionally set up Claude assets |
| `/meta` | Analyze and improve the development system itself |

**Torvaldsen commands** (for managed projects with `.torvaldsen/` directory):

| Command | Purpose |
|---------|---------|
| `/brainstorm` | Transform an app idea into 9 product foundation documents |
| `/decompose` | Convert BRAINSTORM.md into GitHub issues + milestones |
| `/issue <#>` | Full 9-phase development workflow for one issue |
| `/review <PR#>` | 10-phase code review with scope verification |
| `/phase-gate <N>` | Verify phase completion before unlocking next |
| `/status-sync` | Sync PROJECT-STATUS.md with GitHub |
| `/handoff` | Create context transfer document for next session |
| `/lessons` | Extract reusable patterns from completed work |

---

## Daily Workflows

### Starting a new session

Just describe what you want to do. The system will:
1. Read relevant rules automatically (code quality, security, git, etc.)
2. Activate matching skills based on your keywords
3. Spawn agents when implementation work is needed

```
You: "Add JWT refresh token support to the auth API"

System: Reads rules → activates backend-development skill →
        spawns backend-agent → implements → runs tests
```

### Exploring a new codebase

```
/bootstrap
```

This explores the repo structure, audits documentation, and optionally creates Claude assets (CLAUDE.md, agents, hooks). Use flags:
- `--docs-only` — Just audit and consolidate docs
- `--bootstrap-only` — Just create Claude assets
- `--yes` — Skip approval prompts

### Building something new (non-Torvaldsen)

Just say "build", "create", or "develop" — the system follows a 5-phase workflow automatically:

1. **Research & Planning** — research-agent + planning-agent (parallel)
2. **Design** — ux-agent → ui-agent (sequential)
3. **Implementation** — backend-agent + ui-agent (parallel when independent)
4. **Quality Assurance** — testing-agent + documentation skill
5. **Version Control** — commit, PR

### Building something new (Torvaldsen)

For serious projects (10+ issues), use the full Torvaldsen workflow:

```
/brainstorm "A recipe sharing app for home cooks who want to organize family recipes"
```

This generates 9 foundation documents. Then:

```
/decompose          # Creates GitHub issues + milestones
/issue 1            # Start working on issue #1
/review 1           # Review the PR for issue #1
/phase-gate 1       # Verify Phase 1 is complete
/lessons            # Extract patterns learned
```

### Ending a session

On Torvaldsen projects, always run `/handoff` before stopping. This captures your session state so the next agent (or your next session) can pick up seamlessly.

On non-Torvaldsen projects, the Stop hook will remind you to commit any uncommitted work.

---

## Rules You Should Know About

Seven rules are loaded into every conversation automatically. You don't need to memorize them — they guide Claude Code's behavior. But knowing they exist helps you understand why certain things happen:

| Rule | What it enforces |
|------|-----------------|
| **foundation** | 5-phase development workflow, agent selection, quality gates |
| **code-quality** | TypeScript strict mode, no `any`, ESM imports, naming conventions |
| **testing-quality** | Tests after every function, 80%+ coverage, validation gates |
| **security** | Input validation, no committed secrets, parameterized queries |
| **workflow-git** | One issue = one branch = one PR, commit format, pre-commit checks |
| **documentation** | Active vs archived docs, JSDoc/docstrings, no commented-out code |
| **mcp-tool-usage** | Relative paths for MCP tools, absolute paths for native tools |

---

## Token Optimization

Two settings keep context usage efficient:

| Setting | Value | Effect |
|---------|-------|--------|
| `MAX_THINKING_TOKENS` | 10,000 | Caps extended thinking to prevent runaway reasoning |
| `CLAUDE_AUTOCOMPACT_PCT_OVERRIDE` | 90 | Auto-compacts conversation when 90% of context is used |

**Practical impact:** You can have long sessions without hitting context limits. When compaction happens, earlier conversation is summarized — recent work stays intact.

**Tip:** Run `/clear` between unrelated tasks. This prevents context contamination (carrying assumptions from one task into another).

---

## Hooks (Automatic Guardrails)

Five hooks run automatically — you don't invoke them:

| Hook | When | What it does |
|------|------|-------------|
| **guard-unsafe.sh** | Before any Bash command | Blocks dangerous commands |
| **git-state-check.sh** | Before any Bash command | Validates git state |
| **file-protection.sh** | Before Write/Edit | Guards sensitive files |
| **auto-format.sh** | After Write/Edit | Formats modified files |
| **post-edit-validate.sh** | After Write/Edit | Validates edits |

On Torvaldsen projects, additional scope-guard hooks activate when you're on an issue branch.

---

## Customization

All customization happens in your project's `.claude/` directory. Changes are project-scoped and version-controlled.

### Adding a new agent

Create a file in `.claude/agents/your-agent.md` with YAML frontmatter:

```yaml
---
name: your-agent
description: "What this agent does. Use for: specific triggers."
model: sonnet  # or opus, haiku
tools:
  - Glob
  - Grep
  - Read
  - Write
  - Edit
---

# Your Agent Name

Instructions for the agent...
```

### Adding a new skill

Create `.claude/skills/your-skill/SKILL.md` with YAML frontmatter:

```yaml
---
name: your-skill
description: "What this skill does. Triggers on specific keywords."
---

# Your Skill

Instructions...
```

### Adding a new command

Create `.claude/commands/your-command.md`:

```yaml
---
description: "What /your-command does"
argument-hint: "[arguments]"
allowed-tools:
  - Read
  - Write
  - Bash(git:*)
---

# Your Command

Instructions for what happens when user runs /your-command...
```

### Modifying rules

Edit files in `.claude/rules/`. These are loaded into every conversation, so keep them concise. Since rules are project-level, different projects can have different rules — no more one-size-fits-all.

---

## Tips

**Let the system work for you.** Don't micromanage which agent or skill to use — describe the work and let the orchestration handle routing.

**Be explicit about scope.** "Add a login button" is ambiguous. "Add a login button to the header that redirects to /auth/login" gives the system clear boundaries.

**Use `/clear` between unrelated tasks.** Context contamination is real — the system can carry assumptions from a previous task into a new one.

**Trust the quality gates.** If the system says "tests fail" or "TypeScript has errors," fix them before proceeding. The gates exist to prevent compounding errors.

**Commit frequently.** The system reminds you every 60 minutes. Frequent commits = easy rollbacks = lower risk.

**Read the agent log.** On Torvaldsen projects, `.torvaldsen/agent-log.md` is the institutional memory. Read the last 2-3 entries when resuming work.

---

## Quick Reference

```
Skills (auto-trigger):     Just talk naturally — keywords activate them
Agents (heavy work):       Spawned automatically for implementation tasks
Commands (workflows):      /command-name — structured multi-step procedures
Rules (always active):     7 rules loaded every session — enforce standards
Hooks (guardrails):        5 hooks run automatically — protect your work
```

**Most common actions:**

| Want to... | Do this |
|------------|---------|
| Explore a new repo | `/bootstrap` |
| Start a serious project | `/brainstorm "your idea"` |
| Work on an issue | `/issue 42` |
| Review a PR | `/review 123` |
| Check build health | "validate the build" |
| Research a technology | "research WebSocket best practices" |
| Fix broken imports | "fix the broken imports" |
| Check scope drift | "scope check" |
| End a session | `/handoff` (Torvaldsen) or just stop |
