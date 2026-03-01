# Torvaldsen Development Workflow v2.0

> A strict atomic development methodology for AI-assisted projects, inspired by Linus Torvalds' collaborative development principles. Built natively for **Claude Code**.

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

### Quick Install (Global)

Copy the workflow files to your Claude Code configuration:

```bash
# Clone the workflow
git clone https://github.com/emanuelrechsteiner/Development_Process_inspired_by_Linus_Torvalds.git
cd Development_Process_inspired_by_Linus_Torvalds

# Copy commands (globally discoverable as /brainstorm, /issue, etc.)
cp -r commands/* ~/.claude/commands/

# Copy skills (auto-trigger on matching keywords)
cp -r skills/* ~/.claude/skills/

# Copy rules + templates to holding directory (NOT auto-loaded globally)
mkdir -p ~/.claude/torvaldsen/rules ~/.claude/torvaldsen/templates/project-rules
cp rules/* ~/.claude/torvaldsen/rules/
cp templates/*.md templates/*.json ~/.claude/torvaldsen/templates/
cp templates/project-rules/* ~/.claude/torvaldsen/templates/project-rules/

# Merge hooks into your settings.json (manual merge recommended)
cat hooks/hooks-config.json
# → Add the hooks entries to your ~/.claude/settings.json "hooks" section
```

> **Why rules go to `~/.claude/torvaldsen/rules/` instead of `~/.claude/rules/`:**
> Files in `~/.claude/rules/` are always loaded into every conversation — even non-Torvaldsen projects. Torvaldsen rules (592 lines) should only consume context in Torvaldsen-managed projects. The `/brainstorm` command automatically copies them to each project's `.claude/rules/` during initialization.

### Per-Project Install

To install into a specific project without global commands:

```bash
mkdir -p /path/to/project/.claude/commands /path/to/project/.claude/skills /path/to/project/.claude/rules
cp -r commands/* /path/to/project/.claude/commands/
cp -r skills/* /path/to/project/.claude/skills/
cp rules/* /path/to/project/.claude/rules/
```

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

## Package Structure

```
Workflwo_Torvaldsen/
├── README.md                            # This file
├── commands/                            # → Copy to .claude/commands/
│   ├── brainstorm.md                    #   /brainstorm "App Idea"
│   ├── decompose.md                     #   /decompose
│   ├── issue.md                         #   /issue <#>
│   ├── review.md                        #   /review <PR#>
│   ├── phase-gate.md                    #   /phase-gate <N>
│   ├── status-sync.md                   #   /status-sync
│   ├── handoff.md                       #   /handoff
│   └── lessons.md                       #   /lessons
├── skills/                              # → Copy to .claude/skills/
│   ├── torvaldsen-onboard/
│   │   └── SKILL.md                     #   Auto: onboard, get started
│   └── scope-check/
│       └── SKILL.md                     #   Auto: scope check, scope creep
├── rules/                               # → Copy to ~/.claude/torvaldsen/rules/
│   ├── torvaldsen-workflow.md           #   Core workflow rules (per-project)
│   ├── torvaldsen-commits.md            #   Git commit conventions (per-project)
│   └── torvaldsen-scope.md              #   Scope discipline rules (per-project)
├── hooks/                               # → Merge into settings.json
│   └── hooks-config.json               #   Hook definitions
└── templates/                           # → Copy to ~/.claude/torvaldsen/templates/
    ├── BRAINSTORM.template.md           #   Master plan structure
    ├── RESEARCH-FINDINGS.template.md    #   Tech evaluation
    ├── SPECIFICATION.template.md        #   Features + design + brand
    ├── ARCHITECTURE.template.md         #   ADRs + system design
    ├── CONVENTIONS.template.md          #   Code patterns + naming
    ├── PROJECT-STATUS.template.md       #   Living dashboard
    ├── PHASE-SUMMARY.template.md        #   Phase completion record
    ├── START-HERE.template.md           #   Onboarding entry
    ├── ADR.template.md                  #   Architecture Decision Record
    ├── SCOPE-MANIFEST.template.json     #   Feature tracking
    ├── CLAUDE-PROJECT.template.md       #   Project CLAUDE.md
    ├── CONTRIBUTING.template.md         #   Contribution guide
    └── project-rules/                   #   Stack-specific rule templates
        ├── nextjs-app-router.rule.md    #   Next.js App Router patterns
        ├── supabase.rule.md             #   Supabase/RLS patterns
        ├── convex.rule.md               #   Convex patterns
        ├── python-fastapi.rule.md       #   Python/FastAPI patterns
        └── react-performance.rule.md    #   React scroll/animation patterns
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
