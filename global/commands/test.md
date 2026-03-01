---
description: "Run tests or write new tests for the codebase"
argument-hint: "[optional: specific file or feature to test]"
allowed-tools:
  - Task
  - Bash
  - Read
  - Glob
---

# Testing Workflow

Use the testing-agent to write and run tests.

**Spawn the testing-agent with:**

```
Testing task: $ARGUMENTS

If no specific target provided, analyze the codebase and:
1. Identify untested code
2. Write missing unit tests
3. Run the full test suite
4. Report coverage metrics

If a specific target is provided:
1. Write comprehensive tests for that target
2. Run the tests
3. Report results

Ensure:
- Tests follow project conventions
- Coverage meets minimum requirements (80%)
- All tests pass before completing
```

After testing completes, present the test results and coverage report.
