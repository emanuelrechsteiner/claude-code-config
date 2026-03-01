--- Cursor Command: review.md ---
You are performing comprehensive code review on a pull request.

## CODE REVIEW WORKFLOW

### PREREQUISITES
- GitHub PR #$ARGUMENTS must exist
- Must be linked to a GitHub issue
- CI/CD pipeline must be running
- All automated checks should be complete

### 7-PHASE REVIEW PROCESS

#### Phase 1: CONTEXT (10 minutes)

1. **Fetch the Pull Request**
   - Get PR #$ARGUMENTS from GitHub
   - Read title, description, linked issue
   - Check CI/CD status and automated checks
   - Review which files changed

2. **Understand the Purpose**
   - What issue does this solve?
   - What's the technical approach?
   - Are there any architectural decisions?
   - Read the acceptance criteria

3. **Check PR Completeness**
   - [ ] PR is linked to an issue with "Closes #X"
   - [ ] All CI checks passing
   - [ ] All required status checks completed
   - [ ] No merge conflicts
   - [ ] Branch is up to date with main

#### Phase 2: CODE QUALITY (20-30 minutes)

**Code Style & Conventions**
- [ ] Follows project naming conventions
- [ ] Consistent indentation and formatting
- [ ] No unnecessary whitespace changes
- [ ] Comments are clear and helpful
- [ ] No commented-out code blocks
- [ ] No debug code (console.log, debugger, etc.)

**TypeScript Standards**
- [ ] No `any` types used without justification
- [ ] All function parameters typed
- [ ] Return types specified where needed
- [ ] Proper use of interfaces/types
- [ ] No type assertions without comment explaining why
- [ ] Strict mode compliance

**React/Next.js Standards (if applicable)**
- [ ] Proper use of hooks (useEffect, useState, useCallback, etc.)
- [ ] No infinite loops in useEffect (missing dependencies)
- [ ] Proper error boundaries
- [ ] No side effects in render
- [ ] Components properly memoized where needed
- [ ] Proper server/client component separation (App Router)
- [ ] No hydration mismatches

**Express/Node.js Standards (if applicable)**
- [ ] Proper error handling with try/catch
- [ ] Async/await used correctly
- [ ] No callback hell or pyramid of doom
- [ ] Proper middleware usage
- [ ] Environment variables properly configured
- [ ] No hardcoded values or secrets

**Code Readability**
- [ ] Variable names are descriptive
- [ ] Functions have single responsibility
- [ ] Functions are reasonably sized (not too long)
- [ ] Complex logic has explanatory comments
- [ ] No magic numbers without explanation

#### Phase 3: SECURITY (15 minutes)

**Authentication & Authorization**
- [ ] Proper auth checks on protected routes
- [ ] Session/token validation implemented
- [ ] User scoping enforced (can't access other users' data)
- [ ] Rate limiting for sensitive operations
- [ ] Proper logout/session cleanup

**Input Validation**
- [ ] All user inputs validated
- [ ] No SQL injection vulnerabilities
- [ ] No command injection vulnerabilities
- [ ] Proper type coercion and sanitization
- [ ] Form data validated on both client and server

**Data Protection**
- [ ] Sensitive data not logged
- [ ] No secrets in code or comments
- [ ] Environment variables properly used
- [ ] Database queries parameterized
- [ ] No exposed API keys or credentials

**Supabase-Specific (if applicable)**
- [ ] Row Level Security (RLS) policies enforced
- [ ] Supabase client used for all DB operations
- [ ] Auth checks before data access
- [ ] Edge Functions for sensitive operations
- [ ] Storage buckets properly secured

**CORS & Headers**
- [ ] CORS properly configured
- [ ] Security headers set correctly
- [ ] No overly permissive policies
- [ ] Proper content-type headers

#### Phase 4: TESTING (10 minutes)

**Test Coverage**
- [ ] Unit tests added for new functions
- [ ] Integration tests for API endpoints
- [ ] Test coverage is adequate (ideally >80%)
- [ ] Edge cases covered
- [ ] Error cases tested

**Test Quality**
- [ ] Tests are clear and readable
- [ ] Tests have meaningful names
- [ ] No flaky or random tests
- [ ] Proper test setup and teardown
- [ ] Assertions are specific
- [ ] Mock data is realistic

**Testing Approach**
- [ ] Tests follow project conventions
- [ ] Test framework used correctly
- [ ] No test code in production build
- [ ] Tests can run in isolation

#### Phase 5: PERFORMANCE (10 minutes)

**Database Queries**
- [ ] No N+1 query problems
- [ ] Proper indexes on queried columns
- [ ] Joins optimized
- [ ] Pagination used for large datasets
- [ ] Connection pooling configured

**Caching Strategy**
- [ ] Appropriate caching implemented
- [ ] Cache invalidation working
- [ ] No stale cache issues
- [ ] Cache keys are unique

**Rendering Performance (Frontend)**
- [ ] No unnecessary re-renders
- [ ] Proper use of memoization
- [ ] Images optimized and lazy-loaded
- [ ] Bundle size doesn't increase significantly
- [ ] Heavy computations moved to server where appropriate

**API Response Times**
- [ ] Responses are reasonably fast
- [ ] Payload sizes are optimized
- [ ] No blocking operations in request handlers
- [ ] Async operations used properly

#### Phase 6: DOCUMENTATION (5 minutes)

**Code Comments**
- [ ] Complex logic has explanatory comments
- [ ] Comments explain WHY, not WHAT
- [ ] JSDoc comments on public functions
- [ ] README updated if needed
- [ ] Environment variables documented

**API Documentation**
- [ ] Endpoint documented
- [ ] Request/response format clear
- [ ] Error codes documented
- [ ] Examples provided

**Type Documentation**
- [ ] Complex types explained
- [ ] Generic types properly bounded
- [ ] Type interfaces documented

#### Phase 7: ACCEPTANCE CRITERIA (10 minutes)

**From the Linked Issue:**
- [ ] Criterion 1 - Verified and working
- [ ] Criterion 2 - Verified and working
- [ ] Criterion 3 - Verified and working
- [ ] All acceptance criteria from issue met

**Additional Verification**
- [ ] Feature works as described
- [ ] No regressions in existing functionality
- [ ] Error handling graceful
- [ ] Edge cases handled properly

### REVIEW OUTCOMES

**✅ APPROVE**
- All checks passed
- No issues found
- Ready to merge

**💬 REQUEST CHANGES**
- Issues found that must be fixed
- Clearly specify what needs to change
- Explain why it needs to change
- Provide specific examples if possible

**💭 COMMENT**
- Questions about implementation
- Suggestions for improvement
- Discussion points
- No blocking issues

### CONSTRUCTIVE FEEDBACK GUIDELINES

1. **Be Specific**
   - ❌ "This is bad"
   - ✅ "This function has a potential N+1 query issue because..."

2. **Provide Context**
   - ❌ "Change this variable name"
   - ✅ "This variable should be `userPermissions` instead of `perms` to match the codebase convention"

3. **Offer Solutions**
   - ❌ "This won't work"
   - ✅ "Consider using `Promise.all()` here to avoid sequential requests"

4. **Respect Opinions**
   - ❌ "This approach is wrong"
   - ✅ "This approach works, but we typically use X pattern in this codebase for similar problems"

5. **Balance Criticism**
   - Point out what works well
   - Acknowledge complexity
   - Appreciate effort

### COMMON ISSUES CHECKLIST

**Frequently Found Issues:**
- [ ] Missing error handling
- [ ] Unhandled promise rejections
- [ ] Missing TypeScript types
- [ ] Inefficient queries (N+1)
- [ ] Missing authentication checks
- [ ] No input validation
- [ ] Missing tests
- [ ] Hard-coded values
- [ ] Exposed secrets/credentials
- [ ] Side effects in render

**Frequently Found in Next.js:**
- [ ] API routes affected by middleware
- [ ] Client component marked as server
- [ ] Server component accessing client APIs
- [ ] Missing `use client` directives
- [ ] Hydration mismatches
- [ ] Image optimization not used
- [ ] Dynamic import issues

**Frequently Found in Supabase:**
- [ ] Missing RLS policies
- [ ] Direct database access without auth check
- [ ] Supabase client not configured properly
- [ ] Missing error handling for DB operations

### REVIEW TEMPLATE

```markdown
## Review of PR #$ARGUMENTS

### Summary
[Brief overview of what this PR does]

### Context Check
- CI/CD Status: ✅ Passing
- Issue Linked: ✅ Closes #X
- Up to Date: ✅ Yes

### Code Quality
✅ Strengths:
- [What's done well]

💬 Suggestions:
- [Minor improvements]

### Security
✅ All checks passed

### Testing
✅ Test coverage adequate

### Acceptance Criteria
✅ All criteria met:
- [x] Criterion 1
- [x] Criterion 2
- [x] Criterion 3

### Decision
**✅ APPROVE**

This is ready to merge.
```

### ERROR HANDLING

**If Issues Found:**
1. Clearly list what needs to be fixed
2. Provide specific code examples
3. Explain the impact or risk
4. Suggest solutions
5. Be willing to discuss alternatives

**If Tests Missing:**
1. Identify what tests are needed
2. Explain what scenarios should be covered
3. Reference similar tests in codebase
4. Offer to help write them

**If Performance Issues:**
1. Show the specific problematic code
2. Explain the performance impact
3. Provide benchmark or profiling data if possible
4. Suggest optimization approach

### COMPLETION CHECKLIST

Before submitting review, verify:
- [ ] All 7 phases completed
- [ ] Specific issues identified with examples
- [ ] Constructive tone maintained
- [ ] Feedback is actionable
- [ ] No blocking issues if approving
- [ ] Clear next steps if requesting changes
- [ ] Approval/changes/comment decision made

### OUTPUT FORMAT

When submitting review on GitHub:

```markdown
[Provide comprehensive feedback following the 7-phase review]

## Decision: [✅ APPROVE / 💬 REQUEST CHANGES / 💭 COMMENT]

[Summary of key points]
```

## YOUR TASK

Complete comprehensive code review for PR #$ARGUMENTS following all 7 phases above. Be thorough, specific, and constructive.

**Remember:**
- Review code, not the person
- Be specific and provide examples
- Offer solutions, not just criticism
- Focus on impact and risk
- Verify all acceptance criteria
- Approve only when truly ready to merge
