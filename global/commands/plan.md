---
description: "Create a development plan for a project or feature"
argument-hint: "[feature/project description]"
allowed-tools:
  - Task
  - Read
  - Glob
  - Grep
---

# Planning Workflow

Create a comprehensive development plan using the planning-agent.

**Spawn the planning-agent with this prompt:**

```
Create a comprehensive development plan for: $ARGUMENTS

Your plan must include:

1. **Architecture Design**
   - System components and their purposes
   - Data flow between components
   - Technology stack with rationale

2. **Task Breakdown**
   - Phase-organized tasks
   - Each task assigned to appropriate agent (backend-agent, frontend-agent, etc.)
   - Dependencies between tasks
   - Time estimates

3. **Risk Assessment**
   - Potential blockers
   - Mitigation strategies

4. **Success Criteria**
   - Measurable outcomes
   - Quality requirements

Output this as PLANNING.md in the project root.
```

After the planning-agent completes, summarize the plan and ask if the user wants to proceed with implementation using `/develop`.
