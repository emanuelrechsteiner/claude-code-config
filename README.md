# Claude Code Development Framework + Torvaldsen Workflow v2.0

> A complete Claude Code configuration with agent orchestration, 19 commands, 26 skills, 14 agents, 7 auto-loaded rules, token optimization, and the Torvaldsen atomic development methodology for AI-assisted projects. Built natively for **Claude Code**.

## What's In This Repo

This is a **complete, shareable Claude Code configuration** — everything you need to set up a professional AI-assisted development environment:

| Category | Count | Description |
|----------|-------|-------------|
| **Global Rules** | 7 | Always-loaded rules: code quality, testing, security, git, docs |
| **Agents** | 14 | Implementation specialists (backend, frontend, testing, review, planning, design, cleanup + 6 literary) |
| **Forked Skills** | 6 | Run in isolated context like agents: build validation, research, git ops, debugging, patterns, docs |
| **Background Skills** | 8 | Auto-trigger only (hidden from menu): perf check, Tailwind, imports, etc. |
| **Standard Skills** | 12 | User-invocable: scope check, onboarding, testing, planning, etc. |
| **Commands** | 19 | Slash commands: `/brainstorm`, `/issue`, `/review`, `/deploy`, etc. |
| **Hook Scripts** | 5 | File protection, auto-format, git safety, security guard |
| **Token Optimization** | 3 | env settings: haiku default for sub-agents, thinking cap, auto-compact |
| **Torvaldsen Workflow** | 8 commands | Atomic development methodology for 200+ issue projects |
| **Templates** | 17 | Artifact blueprints + 5 stack-specific rule templates |

### Quick Install

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
cd YOUR_REPO
./install.sh            # Full install
./install.sh --global   # Only global config (no Torvaldsen)
./install.sh --dry-run  # Preview what would be installed
```

---

## The Problem

In long-running projects (200+ issues, 12+ months) developed with AI coding agents:

- **Context is lost** — Agents forget between sessions. No persistent memory.
- **Scope drifts** — Agents add "helpful" features or skip "hard" ones without tracking.
- **Quality degrades** — Each new agent introduces slightly different patterns.
- **Continuity breaks** — A new agent can't understand what was built, why, or what's next.

## The Solution

Torvaldsen is a **distributable Claude Code workflow package** that provides:

- **8 custom commands** — The complete development lifecycle from idea to release
- **2 auto-triggering skills** — Agent onboarding and scope enforcement
- **3 always-loaded rules** — Workflow discipline, commit conventions, scope management
- **11 templates** — Standardized artifact blueprints
- **Living documentation** — Self-updating project status, conventions, and architecture records
- **Phase gates** — Quality verification before advancing
- **Scope manifest** — Locked feature list with 3-layer enforcement

---

## Seven Design Principles

1. **Documents over memory** — Agents forget, files persist
2. **Append over overwrite** — Agent log is append-only, phase summaries accumulate
3. **Verify over trust** — Phase gates check actual state, scope checks compare code vs manifest
4. **Compress over dump** — Phase summaries compress entire phases into ~500 words
5. **Explicit over implicit** — Every issue states what's NOT in scope, every ADR states WHY
6. **Sequential gates over parallel hope** — Phases don't advance until gates pass
7. **Separation of concerns** — Docs commits separate from code commits

---

## Installation

### Automated Install (Recommended)

```bash
git clone https://github.com/emanuelrechsteiner/Development_Process_inspired_by_Linus_Torvalds.git
cd Development_Process_inspired_by_Linus_Torvalds
./install.sh
```

The install script:
- Backs up your existing `~/.claude/` configuration
- Copies global config (CLAUDE.md, rules, commands, skills, hooks)
- Copies Torvaldsen workflow (rules, templates — NOT auto-loaded)
- Won't overwrite `settings.json` if it exists (manual merge recommended)

**Options:**
- `./install.sh --global` — Only global config, skip Torvaldsen
- `./install.sh --torvaldsen` — Only Torvaldsen workflow
- `./install.sh --dry-run` — Preview without changes

### Manual Install

```bash
# Global config
cp global/CLAUDE.md ~/.claude/
cp global/rules/*.md ~/.claude/rules/
cp global/commands/*.md ~/.claude/commands/
cp -r global/skills/* ~/.claude/skills/
cp global/hooks/*.sh ~/.claude/hooks/
# Merge global/settings.json into your existing ~/.claude/settings.json

# Torvaldsen (optional)
mkdir -p ~/.claude/torvaldsen/rules ~/.claude/torvaldsen/templates/project-rules
cp torvaldsen/rules/*.md ~/.claude/torvaldsen/rules/
cp torvaldsen/templates/*.md torvaldsen/templates/*.json ~/.claude/torvaldsen/templates/
cp torvaldsen/templates/project-rules/*.md ~/.claude/torvaldsen/templates/project-rules/
```

> **Why Torvaldsen rules go to `~/.claude/torvaldsen/rules/` NOT `~/.claude/rules/`:**
> Files in `~/.claude/rules/` are always loaded into every conversation — even non-Torvaldsen projects. Torvaldsen rules (592 lines) should only consume context when needed. The `/brainstorm` command copies them to each project's `.claude/rules/` during initialization.

---

## Complete Workflow

```
START: Rough app idea + target group + user story
  │
  ▼
/brainstorm "App Idea Description"
  │  Phase 1: RESEARCH → RESEARCH_FINDINGS.md
  │  Phase 2: SPECIFICATION → SPECIFICATION.md (features + design + brand)
  │  Phase 3: ARCHITECTURE → ARCHITECTURE.md (ADRs + system design)
  │  Phase 4: PLANNING → BRAINSTORM.md (phases + atomic issues)
  │  Phase 5: SETUP → CONVENTIONS.md, START_HERE.md, CLAUDE.md, .torvaldsen/*
  │  Phase 6: COMMIT
  │
  │  Output: 9 root documents + workflow state
  ▼
/decompose
  │  Creates: GitHub Issues + Milestones + Labels
  │  Generates: PROJECT-STATUS.md
  │  Locks: scope-manifest.json
  │  Tags: scope-lock-<date>
  ▼
╔══════════════════════════════════════════╗
║           PHASE LOOP                     ║
║                                          ║
║  /torvaldsen-onboard  (new agent)        ║
║    │                                     ║
║    ▼                                     ║
║  /issue <#>                              ║
║    │  P0: Onboard check                  ║
║    │  P1: Analyze + scope boundary       ║
║    │  P2: Branch                         ║
║    │  P3: Implement + conventions        ║
║    │  P4: Test + validate build          ║
║    │  P5: Commit (structured format)     ║
║    │  P6: PR + scope check               ║
║    │  P7: Verify CI                      ║
║    │  P8: Status sync                    ║
║    │  P9: /clear (mandatory)             ║
║    ▼                                     ║
║  /review <PR#>                           ║
║    │  10-phase review with scope verify  ║
║    ▼                                     ║
║  (merge PR)                              ║
║    │                                     ║
║  /status-sync    (periodic)              ║
║  /handoff        (end of session)        ║
║    │                                     ║
║  /phase-gate <N> (all issues done)       ║
║    │  5-step verification + git tag      ║
║    ▼                                     ║
║  /lessons        (after phase)           ║
║    │  Update CONVENTIONS + ARCHITECTURE  ║
╚══════════════════════════════════════════╝
  │
  ▼
FINAL RELEASE (tag v1.0.0)
```

---

## Command Reference

### `/brainstorm` — Full Product Development Pipeline

**Input:** A rough app idea with target group and user story.

**Output:** 9 root documents forming a complete product foundation:

| Document | Content |
|----------|---------|
| `RESEARCH_FINDINGS.md` | Comprehensive technology evaluation (8-12 domains) |
| `SPECIFICATION.md` | Features, user stories, design system, brand guidelines |
| `ARCHITECTURE.md` | System design, ADRs for every major technology choice |
| `BRAINSTORM.md` | Master plan with phases, atomic issues, timeline |
| `CONVENTIONS.md` | Code patterns, naming rules, folder structure |
| `START_HERE.md` | Quick onboarding entry point |
| `CLAUDE.md` | Agent instructions (auto-loaded) |
| `README.md` | Public project overview |
| `CONTRIBUTING.md` | Contribution guide |
| `.torvaldsen/*` | Workflow state (config, scope manifest, agent log) |

### `/decompose` — Issue Creation

Converts BRAINSTORM.md into GitHub infrastructure:
- Creates labeled GitHub issues with milestones
- Generates PROJECT-STATUS.md (living dashboard)
- Locks the scope manifest
- Tags: `scope-lock-<date>`

### `/issue <#>` — Atomic Development (9 Phases)

The daily development loop — complete workflow for one issue:
1. Onboard check (conventions, architecture, blockers)
2. Analyze + explicit scope boundary statement
3. Branch (convention-enforced naming)
4. Implement (with convention compliance)
5. Test (full validation suite)
6. Commit (structured format with phase/feature trailers)
7. PR (with scope verification)
8. Status sync (update living documents)
9. Context hygiene (`/clear` mandatory)

### `/review <PR#>` — Comprehensive Review (10 Phases)

Every PR goes through:
1. **Scope verification** — Does the PR match the issue?
2. Context — PR purpose and CI status
3. Code quality — Bugs, readability, type safety
4. **Convention compliance** — Matches CONVENTIONS.md?
5. **Architectural consistency** — Follows ADRs?
6. Security — Vulnerabilities, auth, data protection
7. Testing — Coverage, quality, edge cases
8. Performance — N+1 queries, re-renders, bundle size
9. Documentation — JSDoc, comments, API docs
10. Acceptance criteria — All met?

### `/phase-gate <N>` — Phase Completion Verification

5-step quality gate:
1. Issue verification (all closed, all PRs merged)
2. Quality verification (TypeScript, ESLint, tests, build)
3. Scope verification (all features delivered, no extras)
4. Phase summary generation (compressed context for future agents)
5. Git tag (`v0.N.0-<phase-name>`)

### `/status-sync` — Progress Dashboard Update

Synchronizes PROJECT-STATUS.md with GitHub reality. Detects anomalies: orphaned issues, stale work, scope drift.

### `/handoff` — Agent Context Transfer

Captures session state for the next agent: uncommitted work, decisions made, blockers, recommended next action. Appends to the append-only agent log.

### `/lessons` — Pattern Extraction

Extracts reusable patterns from completed work. Updates CONVENTIONS.md with new patterns and anti-patterns. Updates ARCHITECTURE.md with ADR refinements.

---

## Skills (Auto-Triggered)

### `torvaldsen-onboard`

**Triggers:** "onboard", "get started", "what should I work on", "where are we"

Gets a new agent productive in < 10 minutes:
1. Read START_HERE.md (project overview)
2. Read PROJECT-STATUS.md (current state)
3. Read CONVENTIONS.md (code patterns)
4. Skim ARCHITECTURE.md (tech decisions)
5. Read latest phase summary (what was built before)
6. Read agent log last 2 entries (what the last agent did)
7. Recommend next issue

### `scope-check`

**Triggers:** "scope check", "scope creep", "verify scope"

Verifies work matches the plan:
- **Per-issue:** Checks every changed file against issue scope
- **Per-phase:** Checks feature completion against scope manifest
- **Scope change protocol:** Documents, requires human approval, tracks in manifest

---

## Living Artifact System

### Context Tier System

| Tier | Documents | When to Load |
|------|-----------|-------------|
| 1 (Always) | START_HERE.md, PROJECT-STATUS.md | Every session |
| 2 (Active) | CONVENTIONS.md, agent-log.md, current issue | When writing code |
| 3 (On Demand) | ARCHITECTURE.md, SPECIFICATION.md, phase summaries | When making decisions |
| 4 (Reference) | BRAINSTORM.md, RESEARCH_FINDINGS.md | Rarely |

### Git Strategy

**Commits:** `<type>(<area>): <description> - closes #<N>` with Phase/Feature trailers
**Branches:** `<type>/issue-<N>-<description>`
**Tags:** `v0.N.0-<phase-name>` per phase, `scope-lock-<date>` after decompose

---

## Repository Structure

```
claude-code-config/
├── README.md                            # This file
├── install.sh                           # Automated installer
│
├── global/                              # ═══ GLOBAL CONFIG (→ ~/.claude/) ═══
│   ├── CLAUDE.md                        #   Global instructions (75 lines)
│   ├── settings.json                    #   Permissions, hooks, plugins
│   ├── statusline-command.sh            #   Status line script
│   ├── rules/                           #   Auto-loaded every session (544 lines)
│   │   ├── foundation.md                #     Agent orchestration, dev phases
│   │   ├── code-quality.md              #     TypeScript/Python standards
│   │   ├── testing-quality.md           #     Testing cadence, coverage targets
│   │   ├── security.md                  #     Input validation, auth, secrets
│   │   ├── workflow-git.md              #     Branches, commits, PRs
│   │   ├── documentation.md             #     Active/archived docs, JSDoc
│   │   └── mcp-tool-usage.md            #     MCP path conventions
│   ├── agents/                          #   14 active sub-agent definitions (Task tool)
│   │   ├── backend-agent.md             #     API, database, server logic (skills: backend-dev, validate-build)
│   │   ├── frontend-agent.md            #     UI components, state, styling (skills: ui-dev, react-perf, tailwind)
│   │   ├── testing-agent.md             #     Unit/integration/E2E tests (skills: testing-suite, validate-build)
│   │   ├── planning-agent.md            #     Architecture, task breakdown (model: sonnet)
│   │   ├── ui-agent.md                  #     Visual design, component specs
│   │   ├── ux-agent.md                  #     User flows, wireframes
│   │   ├── cleanup-agent.md             #     Dead code, debug artifacts (model: haiku)
│   │   ├── code-reviewer-agent.md       #     Read-only code review (hooks: blocks Write/Edit)
│   │   ├── consistency-orchestrator-agent.md # Manuscript consistency
│   │   ├── naming-consistency-agent.md  #     Name/term consistency
│   │   ├── timeline-consistency-agent.md #    Timeline/date consistency
│   │   ├── detail-consistency-agent.md  #     Object/action detail checks
│   │   ├── plausibility-agent.md        #     Story logic plausibility
│   │   └── story-loopholes-agent.md     #     Plot holes, loose threads
│   │   # 6 agents archived → replaced by forked skills:
│   │   # build-validator → validate-build skill (context: fork, model: haiku)
│   │   # research → research skill (context: fork, model: haiku)
│   │   # version-control → version-control skill (context: fork, model: haiku)
│   │   # framework-specialist → nextjs-debug skill (context: fork, model: haiku)
│   │   # pattern-extractor → pattern-document skill (context: fork, model: sonnet)
│   │   # documentation → documentation skill (context: fork, model: sonnet)
│   ├── commands/                        #   19 slash commands
│   │   ├── bootstrap.md                 #     /bootstrap — repo setup
│   │   ├── brainstorm.md                #     /brainstorm — idea → foundation
│   │   ├── decompose.md                 #     /decompose → GitHub issues
│   │   ├── develop.md                   #     /develop — orchestrated workflow
│   │   ├── documentation.md             #     /documentation — generate docs
│   │   ├── handoff.md                   #     /handoff — agent context transfer
│   │   ├── implement.md                 #     /implement — implementation phase
│   │   ├── issue.md                     #     /issue <#> — 9-phase dev loop
│   │   ├── ledger.md                    #     /ledger — observation health
│   │   ├── lessons.md                   #     /lessons — pattern extraction
│   │   ├── meta.md                      #     /meta — system verification
│   │   ├── onboard.md                   #     /onboard — codebase deep dive
│   │   ├── phase-gate.md                #     /phase-gate <N> — quality gate
│   │   ├── plan.md                      #     /plan — development planning
│   │   ├── research.md                  #     /research — technology research
│   │   ├── review.md                    #     /review <PR#> — 10-phase review
│   │   ├── start.md                     #     /start — codebase exploration
│   │   ├── status-sync.md               #     /status-sync — dashboard update
│   │   └── test.md                      #     /test — run/write tests
│   ├── skills/                          #   26 auto-triggered skills
│   │   ├── agent-coordination/          #     Multi-agent coordination
│   │   ├── backend-development/         #     Firebase, state management
│   │   ├── consistency-check/           #     Manuscript consistency
│   │   ├── dependency-audit/            #     npm audit, outdated pkgs
│   │   ├── documentation/               #     Technical docs
│   │   ├── fix-review/                  #     Post-fix completeness
│   │   ├── human-testing/               #     UX/UI manual testing
│   │   ├── import-fixer/                #     Broken import repair
│   │   ├── improvement-analysis/        #     Workflow optimization
│   │   ├── nextjs-debug/                #     Next.js diagnostics
│   │   ├── orchestration/               #     Agent scrum master
│   │   ├── pattern-document/            #     Learning extraction
│   │   ├── project-bootstrap/           #     Repo exploration
│   │   ├── project-planning/            #     Strategic planning
│   │   ├── react-perf-check/            #     React performance
│   │   ├── research/                    #     Tech research
│   │   ├── scope-check/                 #     Scope enforcement
│   │   ├── tailwindcss-v4-styling/      #     Tailwind v4 patterns
│   │   ├── testing-suite/               #     QA specialist
│   │   ├── torvaldsen-onboard/          #     Agent onboarding
│   │   ├── type-coverage/               #     TypeScript coverage
│   │   ├── ui-development/              #     React components
│   │   ├── ux-design/                   #     UX workflows
│   │   ├── validate-build/              #     Build validation
│   │   ├── validation/                  #     Pre-execution checks
│   │   └── version-control/             #     Git operations
│   └── hooks/                           #   5 hook scripts
│       ├── auto-format.sh               #     Post-edit formatting
│       ├── file-protection.sh           #     Sensitive file guard
│       ├── git-state-check.sh           #     Git safety checks
│       ├── guard-unsafe.sh              #     Dangerous command blocker
│       └── post-edit-validate.sh        #     Post-edit validation
│
├── torvaldsen/                          # ═══ TORVALDSEN WORKFLOW (optional) ═══
│   ├── commands/                        #   8 Torvaldsen commands (also in global/)
│   ├── skills/                          #   2 Torvaldsen skills (also in global/)
│   ├── rules/                           #   Per-project rules (NOT auto-loaded)
│   │   ├── torvaldsen-workflow.md       #     Core workflow (164 lines)
│   │   ├── torvaldsen-commits.md        #     Commit conventions (202 lines)
│   │   └── torvaldsen-scope.md          #     Scope discipline (226 lines)
│   ├── hooks/
│   │   └── hooks-config.json            #   Torvaldsen hook definitions
│   └── templates/                       #   Artifact blueprints
│       ├── BRAINSTORM.template.md
│       ├── RESEARCH-FINDINGS.template.md
│       ├── SPECIFICATION.template.md
│       ├── ARCHITECTURE.template.md
│       ├── CONVENTIONS.template.md
│       ├── PROJECT-STATUS.template.md
│       ├── PHASE-SUMMARY.template.md
│       ├── START-HERE.template.md
│       ├── ADR.template.md
│       ├── SCOPE-MANIFEST.template.json
│       ├── CLAUDE-PROJECT.template.md
│       ├── CONTRIBUTING.template.md
│       └── project-rules/               #   Stack-specific templates
│           ├── nextjs-app-router.rule.md
│           ├── supabase.rule.md
│           ├── convex.rule.md
│           ├── python-fastapi.rule.md
│           └── react-performance.rule.md
│
└── archive/                             # Historical/legacy files
```

---

## v1.0 → v2.0 Comparison

| Aspect | v1.0 | v2.0 |
|--------|------|------|
| Format | 4 markdown docs | 8 commands + 2 skills + 3 rules + 12 templates + hooks |
| Brainstorm output | 1 file | 9 root documents + workflow state |
| Research | None | RESEARCH_FINDINGS.md (8-12 technical domains) |
| Design/Brand | None | SPECIFICATION.md (design system, brand voice) |
| State tracking | None | PROJECT-STATUS.md (living dashboard) |
| Architecture | Stated, not justified | Full ADRs with alternatives + rationale |
| Agent onboarding | None | < 10 minute cold start protocol |
| Scope enforcement | None | 3-layer guardian (define → implement → review) |
| Context management | None | Tier system + phase summaries |
| Phase quality gates | None | 5-step verification with `/phase-gate` |
| Git traceability | Basic commits | Structured commits with phase/feature trailers + tags |
| Agent continuity | None | Append-only agent log + `/handoff` |
| Convention enforcement | Implicit | Explicit CONVENTIONS.md + review compliance |
| Claude Code integration | None | Native commands, skills, hooks, rules |
| Tech stack | Hardcoded | Template-driven, adapts to any stack |

---

## Example Project

The ConSen(t)ual Dating App was developed using Torvaldsen v1.0 and produced:
- **219 issues** across **18 phases**
- **3,697 lines** of documentation across 7 root documents + 18 supporting docs
- Estimated timeline: **19.5 weeks**

v2.0 adds the infrastructure to maintain quality and continuity across all 219 issues and 18 phases, even with rotating AI agents.

---

**Version:** 2.0.0
**Last Updated:** March 2026
**Inspired By:** Linus Torvalds' Linux Kernel Development Model
**Built For:** Claude Code (Anthropic)
