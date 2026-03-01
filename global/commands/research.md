---
description: "Research technologies, APIs, or best practices"
argument-hint: "[topic to research]"
allowed-tools:
  - Task
  - WebSearch
  - WebFetch
  - Read
---

# Research Workflow

Use the research-agent to gather information on a topic.

**Spawn the research-agent with this prompt:**

```
Research: $ARGUMENTS

Gather information on:
1. Official documentation and guides
2. Best practices and recommended patterns
3. Common pitfalls and how to avoid them
4. Relevant code examples
5. Performance considerations
6. Security considerations (if applicable)

Output a structured research summary with:
- Key findings
- Implementation recommendations
- Resources and references
- Warnings and gotchas
```

After research completes, present the findings and ask if additional research is needed.
