--- Cursor Command: issue.md ---
You are completing a full development workflow for a specific GitHub issue.

## ISSUE WORKFLOW

### PREREQUISITES
- GitHub issue #$ARGUMENTS must exist
- Repository must be clean (no uncommitted changes)
- Must be on main/master branch initially

### COMPLETE WORKFLOW PROCESS

#### Phase 1: ANALYZE (5 minutes)

1. **Fetch the Issue**
   - Get issue #$ARGUMENTS from GitHub
   - Read title, description, acceptance criteria
   - Check labels and phase
   - Identify dependencies

2. **Verify Prerequisites**
   - Ensure dependent issues are completed
   - Confirm required infrastructure exists
   - Check environment setup

3. **Plan Approach**
   - Identify files to create/modify
   - Determine testing strategy
   - Plan commit structure

#### Phase 2: CREATE BRANCH (1 minute)

**Branch Naming Convention:**
```
<type>/issue-<number>-<short-description>

Types:
- feature/  : New functionality
- bugfix/   : Bug fixes
- hotfix/   : Critical production fixes
- refactor/ : Code improvements
- docs/     : Documentation only
```

**Examples:**
- `feature/issue-12-user-auth`
- `bugfix/issue-45-memory-leak`
- `hotfix/issue-78-security-patch`

**Commands:**
```bash
git checkout main
git pull origin main
git checkout -b feature/issue-$ARGUMENTS-<description>
```

#### Phase 3: IMPLEMENT (2-4 hours)

**Development Rules:**
1. **Stay Focused**
   - Implement ONLY what's in the issue
   - Don't add "nice to have" features
   - Follow acceptance criteria exactly

2. **Code Quality**
   - Use TypeScript strictly (no `any`)
   - Follow existing code patterns
   - Add proper error handling
   - Include logging where appropriate

3. **Supabase Best Practices**
   - Always use RLS policies
   - Use Supabase client for all DB operations
   - Implement proper auth checks
   - Use Edge Functions for sensitive operations

4. **Security**
   - Validate all inputs
   - Sanitize user data
   - Use parameterized queries
   - Never expose secrets
   - Implement proper CORS

5. **Documentation**
   - Add JSDoc comments for functions
   - Update README if needed
   - Document any environment variables
   - Add inline comments for complex logic

#### Phase 4: TEST (30-60 minutes)

**Testing Requirements:**

1. **Unit Tests**
   ```typescript
   describe('Feature Name', () => {
     it('should handle normal case', () => {
       // Test implementation
     });

     it('should handle edge cases', () => {
       // Test edge cases
     });

     it('should handle errors', () => {
       // Test error handling
     });
   });
   ```

2. **Integration Tests**
   - Test API endpoints end-to-end
   - Test database operations
   - Test authentication flows
   - Test Supabase RLS policies

3. **Manual Testing**
   - Test in development environment
   - Verify all acceptance criteria
   - Test error scenarios
   - Check UI/UX if applicable

4. **Run Test Suite**
   ```bash
   npm run test
   npm run lint
   npm run type-check
   ```

#### Phase 5: COMMIT & PUSH (5 minutes)

**Commit Message Format:**
```
<type>: <description> - closes #<issue-number>

[Optional longer description]

[Optional breaking changes]
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Formatting
- `refactor`: Code restructuring
- `test`: Adding tests
- `chore`: Maintenance

**Examples:**
```
feat: implement user invitation system - closes #12

Added email invitation service using Supabase Auth.
Includes invitation validation and expiration logic.

bugfix: fix memory leak in data sync - fixes #45

Properly cleanup event listeners in useEffect.
```

**Git Commands:**
```bash
git add .
git commit -m "feat: <description> - closes #$ARGUMENTS"
git push origin <branch-name>
```

#### Phase 6: CREATE PULL REQUEST (10 minutes)

**PR Title:**
```
[Phase X] <Issue title> - closes #<issue-number>
```

**PR Description Template:**
```markdown
## Issue
Closes #$ARGUMENTS

## Changes
- [List main changes]
- [List main changes]

## Testing
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Linter passes
- [ ] Manual testing completed

## Acceptance Criteria
- [ ] [Criterion 1 from issue]
- [ ] [Criterion 2 from issue]
- [ ] [Criterion 3 from issue]

## Screenshots (if applicable)
[Add screenshots for UI changes]

## Notes for Reviewer
[Any important context or decisions]

## Deployment Notes
[Any migration scripts, environment variables, or deployment steps]
```

**PR Checklist:**
- [ ] Linked to issue with "Closes #X"
- [ ] All tests pass
- [ ] Linter passes
- [ ] Code reviewed (self-review)
- [ ] Documentation updated
- [ ] No console.log or debug code
- [ ] Environment variables documented

#### Phase 7: VERIFY (5 minutes)

**Final Checks:**
1. PR created successfully
2. CI/CD pipeline running
3. Issue automatically linked
4. All checks passing
5. Ready for review

### ERROR HANDLING

**Common Issues:**

1. **Merge Conflicts**
   - Pull latest main
   - Resolve conflicts
   - Re-test
   - Force push if needed

2. **Failed Tests**
   - Fix the tests or code
   - Don't skip tests
   - Don't commit broken code

3. **Linting Errors**
   - Run `npm run lint:fix`
   - Fix remaining errors manually
   - Commit fixes

4. **Type Errors**
   - Fix TypeScript errors
   - Don't use `@ts-ignore` without justification
   - Add proper types

### COMPLETION CHECKLIST

Before finishing, verify:
- [ ] Issue #$ARGUMENTS fully addressed
- [ ] All acceptance criteria met
- [ ] Tests written and passing
- [ ] Code follows project standards
- [ ] Documentation updated
- [ ] Branch pushed to GitHub
- [ ] PR created and linked
- [ ] CI/CD pipeline passing
- [ ] Ready for code review

### OUTPUT FORMAT

Provide a summary:
```
✅ Issue #$ARGUMENTS Completed

Branch: <branch-name>
Commits: X commits
Files Changed: X files
Tests Added: X tests
PR: #<pr-number>

Status: Ready for review
```

## YOUR TASK

Complete the full workflow for issue #$ARGUMENTS following all steps above. Be thorough, test comprehensively, and ensure quality.

**Remember:**
- Implement ONLY what's in the issue
- Write tests for everything
- Follow Supabase best practices
- Keep security in mind
- Document your changes
