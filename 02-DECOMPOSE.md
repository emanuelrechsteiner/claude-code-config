--- Cursor Command: decompose.md ---
You are converting a project brainstorm into actual GitHub issues.

## DECOMPOSE WORKFLOW

### PREREQUISITES
1. BRAINSTORM.md file must exist in the project root
2. GitHub repository must be set up and accessible
3. You must have write access to create issues

### PROCESS

#### Step 1: Read and Parse BRAINSTORM.md
- Load the entire BRAINSTORM.md file
- Extract all uncreated issues (marked with `- [ ] Issue:`)
- Group by phase
- Identify dependencies

#### Step 2: Create GitHub Issues
For each issue in BRAINSTORM.md:

**Issue Title Format:**
```
[Phase X] <Issue Description>
```

**Issue Body Template:**
```markdown
## Description
[Clear description of what needs to be done]

## Acceptance Criteria
- [ ] [Specific, testable criterion 1]
- [ ] [Specific, testable criterion 2]
- [ ] [Specific, testable criterion 3]

## Technical Details
- Component/File: [where changes will be made]
- Dependencies: [any prerequisite issues]
- Estimated Time: 2-4 hours

## Testing Requirements
- [ ] Unit tests added/updated
- [ ] Integration tests added/updated
- [ ] Manual testing completed

## Related
- Phase: [Phase number]
- Related to: [link to related issues if any]
```

**Labels to Apply:**
- Phase label: `phase-1`, `phase-2`, etc.
- Type label: `feature`, `bugfix`, `docs`, `test`, `infrastructure`
- Area label: `frontend`, `backend`, `database`, `supabase`, `auth`
- Priority: `high`, `medium`, `low`

#### Step 3: Update BRAINSTORM.md
After creating each issue:
- Change `- [ ] Issue:` to `- [x] Issue #<number>:`
- Add GitHub issue link
- Update issue count

#### Step 4: Create Issue Dependencies
If issues have dependencies:
- Add "Depends on #X" in issue description
- Use GitHub's task list feature
- Consider using GitHub Projects to track phases

### EXAMPLE

**Before (BRAINSTORM.md):**
```markdown
### Phase 1: Foundation
- [ ] Issue: Initialize repository with .gitignore and README
- [ ] Issue: Set up project structure and package.json
```

**After (BRAINSTORM.md):**
```markdown
### Phase 1: Foundation
- [x] Issue #1: Initialize repository with .gitignore and README
- [x] Issue #2: Set up project structure and package.json
```

**Created GitHub Issue #1:**
```
Title: [Phase 1] Initialize repository with .gitignore and README

Body:
## Description
Set up the initial repository structure with proper .gitignore file and comprehensive README documentation.

## Acceptance Criteria
- [ ] .gitignore includes Node.js, TypeScript, environment files
- [ ] README includes project overview, setup instructions
- [ ] README includes tech stack documentation
- [ ] README includes contribution guidelines

## Technical Details
- Files: `.gitignore`, `README.md`
- Dependencies: None (first issue)
- Estimated Time: 1 hour

## Testing Requirements
- [ ] Repository clones correctly
- [ ] Ignored files are not tracked
- [ ] README renders properly on GitHub

## Related
- Phase: Phase 1 - Foundation
- Labels: infrastructure, docs, phase-1
```

### BEST PRACTICES

1. **Clear Acceptance Criteria**
   - Make them specific and testable
   - Include both functional and technical requirements
   - Add testing requirements

2. **Proper Labeling**
   - Always add phase label
   - Add type label (feature/bugfix/etc)
   - Add area label (frontend/backend/etc)

3. **Dependencies**
   - Clearly mark dependent issues
   - Don't create circular dependencies
   - Consider issue order within phases

4. **Estimation**
   - Keep issues to 2-4 hours
   - If larger, break down further
   - Update estimates if needed

5. **Supabase-Specific Issues**
   - Always pair database schema with RLS policies
   - Include Supabase client configuration
   - Consider Auth, Storage, Edge Functions separately

### ISSUE CATEGORIZATION

**Infrastructure Issues:**
- Repository setup
- CI/CD configuration
- Environment setup
- Docker configuration

**Database Issues:**
- Schema design
- Migrations
- RLS policies
- Supabase configuration

**Backend Issues:**
- API endpoints
- Business logic
- Authentication
- Data validation

**Frontend Issues:**
- UI components
- Pages/routes
- State management
- API integration

**Testing Issues:**
- Unit tests
- Integration tests
- E2E tests
- Test infrastructure

**Documentation Issues:**
- API docs
- User guides
- Developer docs
- Deployment guides

### OUTPUT

After completing the decomposition:
1. Show summary: "Created X issues across Y phases"
2. List all created issue numbers with titles
3. Show any issues that couldn't be created (with reasons)
4. Suggest next steps: "Ready to start with `/issue <number>`"

### ERROR HANDLING

If errors occur:
- **GitHub API errors**: Check authentication and permissions
- **Duplicate issues**: Skip and mark in BRAINSTORM.md
- **Rate limiting**: Pause and retry
- **Invalid format**: Fix BRAINSTORM.md format first

## YOUR TASK

Read BRAINSTORM.md and create all GitHub issues following the structure above. Be thorough, clear, and consistent.
