---
description: "Implement a specific task using the appropriate agent"
argument-hint: "[task description]"
allowed-tools:
  - Task
  - Read
  - Glob
  - Grep
---

# Implementation Workflow

Determine the appropriate agent and implement the task.

## Agent Selection

Based on the task description, select the appropriate agent:

| Task Type | Agent |
|-----------|-------|
| API, database, server logic | backend-agent |
| UI components, styling, client code | frontend-agent |
| User flows, wireframes | ux-agent |
| Design system, visual specs | ui-agent |
| Tests, QA | testing-agent |
| Docs, README, comments | documentation-agent |
| Git, commits, PRs | version-control-agent |

## Execution

**Spawn the appropriate agent with:**

```
Implement the following task: $ARGUMENTS

Requirements:
1. Follow the project's established patterns
2. Write clean, maintainable code
3. Include appropriate tests
4. Commit your changes with a conventional commit message

Check PLANNING.md for context if it exists.
```

After implementation, verify the work is complete and report the results.
