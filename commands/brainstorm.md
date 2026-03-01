---
description: "Transform a rough app idea into a complete product foundation: research, specification, design, brand, architecture, and atomic development plan. Use when starting a new project from an idea."
argument-hint: "[app idea with target group and user story]"
allowed-tools:
  - Task
  - Read
  - Write
  - Edit
  - Glob
  - Grep
  - Bash(git:*)
  - Bash(mkdir:*)
---

# Torvaldsen Brainstorm — Full Product Development Pipeline

You are executing the Torvaldsen `/brainstorm` command. This transforms a rough app idea into a **complete product foundation** ready for development.

**INPUT:** $ARGUMENTS

---

## Pre-Flight

1. Verify we're in a git repository (or initialize one)
2. Create `.torvaldsen/` directory structure if it doesn't exist:
   ```
   .torvaldsen/
   ├── config.json
   ├── scope-manifest.json
   ├── agent-log.md
   ├── blocked-issues.md
   └── phase-summaries/
   ```
3. Read templates from the Torvaldsen workflow package for structure reference

---

## Phase 1: RESEARCH (Parallel Agents)

Spawn a **research-agent** using the Task tool with this prompt:

```
Conduct comprehensive technology research for the following app idea:

"$ARGUMENTS"

Research these domains (add more as needed based on the app idea):

1. **Core Technology Stack** — Frontend framework, backend/API, database, ORM
2. **Authentication** — Auth patterns, providers, session management
3. **Storage** — File/media storage solutions
4. **Real-Time** — If applicable: WebSocket, SSE, polling approaches
5. **Internationalization** — If applicable: i18n libraries, patterns
6. **Payment** — If applicable: payment processors, subscription management
7. **Email/Notifications** — Transactional email, push notifications
8. **Search** — If applicable: full-text search solutions
9. **Deployment** — Hosting platforms, CI/CD, CDN
10. **Security** — Authentication, authorization, data protection patterns
11. **Monitoring** — Error tracking, analytics, logging

For EACH technology domain:
- Evaluate 2-3 alternatives
- Provide pros/cons comparison
- Recommend one with clear justification
- Include implementation code examples where helpful
- Analyze cost (free tier, scaling costs)
- Note browser/platform compatibility

Target: >95% of technical questions answered.

Output as a comprehensive markdown document following the RESEARCH-FINDINGS template structure with sections for each domain, comparison tables, code examples, cost analysis, and security considerations.
```

**Output:** Save as `RESEARCH_FINDINGS.md` in project root.

---

## Phase 2: SPECIFICATION (Sequential — Depends on Research)

After research completes, create the product specification in three sub-phases:

### 2a. Feature Specification

Create detailed specifications directly (or spawn planning-agent):

Using the app idea "$ARGUMENTS" and the research findings in RESEARCH_FINDINGS.md:

1. Expand the rough idea into 3-5 **core features** (each with ID: F001, F002, etc.)
2. For each feature: purpose, user-facing description, technical requirements, data requirements, edge cases, acceptance criteria
3. Write 3-6 **user stories** covering the full user lifecycle
4. Define **success metrics** and KPIs
5. Define **compliance requirements** (GDPR, accessibility, etc.)

### 2b. UX Design

Spawn a **ux-agent** using the Task tool:

```
Based on the feature specifications for "$ARGUMENTS", create UX design specifications:

1. User journey mapping for each user story
2. Interaction patterns: loading states, error states, empty states
3. Responsive breakpoints and mobile-first strategy
4. Accessibility requirements (WCAG 2.1 AA target)
5. Navigation patterns and information architecture
```

### 2c. Design System & Brand

Spawn a **ui-agent** using the Task tool:

```
Create a design system and brand guidelines for "$ARGUMENTS":

1. Design principles (3-5 guiding principles)
2. Color palette (primary, secondary, semantic colors with hex values)
3. Typography scale (headings, body, code — font families, sizes, weights)
4. Spacing scale (xs through 2xl)
5. Component patterns (buttons, forms, cards, modals, navigation)
6. Brand personality and voice (tone guidelines, writing style)
7. Target audience visual profiles
```

**Output:** Combine all three sub-phases into `SPECIFICATION.md` in project root.

---

## Phase 3: ARCHITECTURE (Sequential — Depends on Research + Spec)

Spawn a **planning-agent** using the Task tool:

```
Create the system architecture for "$ARGUMENTS" based on:
- RESEARCH_FINDINGS.md (technology choices)
- SPECIFICATION.md (feature requirements)

Create:
1. System overview (ASCII architecture diagram)
2. Tech stack table with version numbers
3. ADRs (Architecture Decision Records) for EVERY major technology choice:
   - Each ADR: Context, Decision, Alternatives Considered (with rejection reasons), Consequences, Revisit When
   - Reference specific findings from RESEARCH_FINDINGS.md
4. Data flow diagrams (request flow, auth flow, mutation flow)
5. Key architectural patterns (state management, API, auth, error handling)
6. Integration points with external services
7. Deployment architecture
8. Environment variables needed
9. Performance targets
10. Security architecture

Use the ARCHITECTURE template structure.
```

**Output:** Save as `ARCHITECTURE.md` in project root.

---

## Phase 4: PLANNING (Sequential — Depends on Architecture)

Spawn a **planning-agent** using the Task tool:

```
Create the development plan for "$ARGUMENTS" based on:
- SPECIFICATION.md (features to build)
- ARCHITECTURE.md (how to build them)

Decompose into phases and atomic issues:

1. Organize features into development PHASES (foundation → core → enhancement → polish)
2. Break each phase into ATOMIC ISSUES (each = 2-4 hours of work max)
3. For each issue:
   - Clear title: "[Phase X] <Description>"
   - Type label: feat/fix/test/docs/infrastructure
   - Area label: auth/api/ui/db/config
   - Whether it's parallel-safe (can be worked on alongside other issues)
   - Dependencies: which issues block it
4. Map dependencies between issues (which blocks which)
5. Identify parallel-safe issues per phase
6. Estimate timeline per phase
7. Define milestone markers (git tags: v0.N.0-<phase-name>)

Use the BRAINSTORM template structure.
Each issue should have a clear, atomic scope — never combine "implement X and also Y" into one issue.
```

**Output:** Save as `BRAINSTORM.md` in project root.

---

## Phase 5: PROJECT SETUP (Sequential — Depends on All Above)

Generate the remaining project infrastructure artifacts:

### 5a. CONVENTIONS.md

Based on ARCHITECTURE.md decisions, create code conventions:
- Folder structure rules with correct/incorrect examples
- File naming conventions per category
- Component patterns (if frontend)
- Import ordering rules
- State management patterns
- Error handling patterns
- Testing patterns
- API patterns

Use the CONVENTIONS template.

### 5b. START_HERE.md

Quick onboarding entry:
- One paragraph project description
- Tech stack (condensed)
- Current status line (Phase 0 — setup complete)
- Key documents table
- Environment setup steps
- Contribution flow

Use the START-HERE template.

### 5c. CLAUDE.md

Project-level Claude Code instructions:
- Import workflow rules: `@.claude/rules/torvaldsen-workflow.md` etc.
- Quick project overview
- Condensed architecture decisions
- Critical conventions (extracted from CONVENTIONS.md)
- Agent routing rules
- Canonical documentation sources
- Current status line

Use the CLAUDE-PROJECT template.

### 5d. README.md

Public-facing project overview:
- Project description and screenshots/mockups (placeholder)
- Tech stack
- Getting started guide
- Project structure
- Contributing link

### 5e. CONTRIBUTING.md

How to contribute using the Torvaldsen workflow. Use the CONTRIBUTING template.

### 5f. .torvaldsen/ State Files

Initialize workflow state:

**`.torvaldsen/config.json`:**
```json
{
  "project_name": "[name]",
  "repository": "[repo URL]",
  "created_date": "[today]",
  "workflow_version": "2.0.0",
  "total_phases": [N],
  "total_issues": [N],
  "current_phase": 0,
  "status": "brainstormed"
}
```

**`.torvaldsen/scope-manifest.json`:**
Initialize from the SCOPE-MANIFEST template, populated with features from SPECIFICATION.md. Set `locked: false` (locked by `/decompose`).

**`.torvaldsen/agent-log.md`:**
```markdown
# Agent Log — [Project Name]

> Append-only session history. Never delete entries.

---

## Session: Brainstorm

**Date:** [today]
**Agent:** brainstorm-pipeline
**Duration:** [estimated]

**Actions:**
- Generated RESEARCH_FINDINGS.md ([N] technical domains evaluated)
- Generated SPECIFICATION.md ([N] features, [N] user stories, design system, brand)
- Generated ARCHITECTURE.md ([N] ADRs)
- Generated BRAINSTORM.md ([N] phases, [N] issues)
- Generated project infrastructure (CONVENTIONS, START_HERE, CLAUDE.md, README, CONTRIBUTING)
- Initialized .torvaldsen/ workflow state

**Decisions:**
- [Key architectural decisions made — summarize top 3]

**Next Steps:**
- Review all generated documents
- Run `/decompose` to create GitHub issues and milestones
```

**`.torvaldsen/blocked-issues.md`:**
```markdown
# Blocked Issues

> Issues that cannot proceed. Updated by `/issue` and `/status-sync`.

No blocked issues yet.
```

---

## Phase 6: COMMIT

Stage and commit all generated artifacts:

```bash
git add BRAINSTORM.md RESEARCH_FINDINGS.md SPECIFICATION.md ARCHITECTURE.md \
       CONVENTIONS.md START_HERE.md CLAUDE.md README.md CONTRIBUTING.md \
       .torvaldsen/
git commit -m "docs(project): initialize Torvaldsen workflow for [project name]

Generated product foundation:
- RESEARCH_FINDINGS.md: [N] technical domains evaluated
- SPECIFICATION.md: [N] features, design system, brand guidelines
- ARCHITECTURE.md: [N] ADRs, system design
- BRAINSTORM.md: [N] phases, [N] atomic issues
- CONVENTIONS.md: code patterns and naming rules
- Project infrastructure: START_HERE, CLAUDE.md, README, CONTRIBUTING
- Workflow state: .torvaldsen/

Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

## Output Summary

After all phases complete, display:

```
Torvaldsen Brainstorm Complete!

Documents Generated:
  - RESEARCH_FINDINGS.md    [N KB, N domains]
  - SPECIFICATION.md        [N KB, N features, N user stories]
  - ARCHITECTURE.md         [N KB, N ADRs]
  - BRAINSTORM.md           [N KB, N phases, N issues]
  - CONVENTIONS.md          [N KB]
  - START_HERE.md           [Quick onboarding]
  - CLAUDE.md               [Agent instructions]
  - README.md               [Public overview]
  - CONTRIBUTING.md         [Contribution guide]
  - .torvaldsen/*           [Workflow state initialized]

Total: [N] documents, [N] issues across [N] phases
Estimated Timeline: [X weeks/months]

Next Step: Review the documents, then run `/decompose` to create GitHub issues.
```
