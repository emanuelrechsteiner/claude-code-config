---
description: "Start orchestrated development workflow for a new project or feature"
argument-hint: "[project description]"
allowed-tools:
  - Task
  - Read
  - Write
  - Glob
  - Grep
  - Bash
---

# Development Orchestration

You are starting an orchestrated development workflow. Follow these phases strictly.

## Phase 1: Research & Planning (PARALLEL)

**IMMEDIATELY spawn these sub-agents in parallel using the Task tool:**

1. **Research Agent** - Spawn with:
```
Research the technologies, APIs, and best practices needed for: $ARGUMENTS

Focus on:
- Technology choices and trade-offs
- API documentation if applicable
- Best practices and common patterns
- Potential pitfalls to avoid
```

2. **Planning Agent** - Spawn with:
```
Create a comprehensive development plan for: $ARGUMENTS

Include:
- Architecture design
- Task breakdown with agent assignments
- Dependency mapping
- Risk assessment
- Success criteria
```

**Wait for both agents to complete before proceeding.**

## Phase 2: Design (SEQUENTIAL)

After Phase 1 completes:

3. **UX Agent** - Spawn with:
```
Based on the PLANNING.md, create UX design for: $ARGUMENTS

Define:
- User flows
- Wireframes
- Accessibility requirements
```

4. **UI Agent** - Spawn with:
```
Based on the UX design, create UI specifications for: $ARGUMENTS

Define:
- Design tokens
- Component specifications
- Visual consistency guidelines
```

## Phase 3: Implementation (PARALLEL where possible)

Based on the task breakdown in PLANNING.md:

5. **Backend Agent** - For backend tasks
6. **Frontend Agent** - For frontend tasks

**These can run in parallel if there are no blocking dependencies.**

## Phase 4: Quality Assurance

After implementation:

7. **Testing Agent** - Write and run tests
8. **Documentation Agent** - Create/update documentation

## Orchestration Rules

- **You coordinate, agents execute** - Never write code directly
- **Use Task tool** with `subagent_type` parameter for each agent
- **Run parallel agents** in a single Task tool call when possible
- **Wait for dependencies** before starting dependent phases
- **Monitor progress** and handle any blockers

Begin now with Phase 1 for: $ARGUMENTS
