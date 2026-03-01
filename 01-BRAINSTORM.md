--- Cursor Command: brainstorm.md ---
You are starting a new project planning session. Your goal is to decompose a project idea into atomic, actionable GitHub issues.

## BRAINSTORMING WORKFLOW

### 1. CREATE BRAINSTORM DOCUMENT
Create or update `BRAINSTORM.md` file with this structure:

```markdown
# Project: $ARGUMENTS

## Vision
[One paragraph describing what we're building and why]

## Core Features
[List 3-5 essential features for MVP]

## Technical Architecture
- Frontend: Next.js 14 with TypeScript and Tailwind CSS
- Backend: Node.js with Express and TypeScript
- Database: PostgreSQL with Supabase
- Authentication: Supabase Auth with session management
- File Storage: Supabase Storage
- Infrastructure: Docker containers deployed on AWS ECS/Fargate
- API Integrations: [Relevant APIs]

## Issue Decomposition

### Phase 1: Foundation (Setup & Infrastructure)
- [ ] Issue: Initialize repository with .gitignore and README
- [ ] Issue: Set up project structure and package.json
- [ ] Issue: Configure ESLint and Prettier
- [ ] Issue: Set up GitHub Actions CI pipeline
- [ ] Issue: Create basic Express server with health endpoint
- [ ] Issue: Set up Supabase project and database schema
- [ ] Issue: Configure environment variables
- [ ] Issue: Set up Supabase Row Level Security policies

### Phase 2: Core Features
[Decompose each core feature into 2-4 hour tasks]
- Each issue should be atomic and independently testable
- Include acceptance criteria
- Add labels: feature/bugfix/hotfix, phase number, frontend/backend

### Phase 3: Testing & Documentation
- [ ] Issue: Add unit tests for all services
- [ ] Issue: Add integration tests for API endpoints
- [ ] Issue: Create API documentation
- [ ] Issue: Add deployment documentation

### Phase 4: Deployment & Monitoring
- [ ] Issue: Configure production deployment
- [ ] Issue: Set up error logging with Sentry
- [ ] Issue: Add basic monitoring and health checks
- [ ] Issue: Configure backup strategy for Supabase

## Estimated Timeline
Phase 1: [X weeks]
Phase 2: [X weeks]
Phase 3: [X weeks]
Phase 4: [X weeks]

Total Issues: [count]
```

### 2. BRAINSTORMING PRINCIPLES

**Atomic Issues**
- Each issue = 2-4 hours of work maximum
- Issues must be independently completable
- Clear acceptance criteria
- No ambiguous language

**Good Issue Examples:**
✅ "Create User table in Supabase with email, role, and created_at fields"
✅ "Implement login API endpoint using Supabase Auth"
✅ "Build customer dashboard page with campaign list"

**Bad Issue Examples:**
❌ "Implement user management" (too broad)
❌ "Make it work" (vague)
❌ "Fix authentication" (no context)

### 3. PHASE ORGANIZATION

**Phase 1: Foundation**
- Repository setup
- Development environment
- Basic infrastructure
- Database schema
- CI/CD pipeline

**Phase 2: Core Features**
- Break down each core feature
- Frontend and backend separately
- API endpoints
- UI components
- Business logic

**Phase 3: Testing & Docs**
- Unit tests
- Integration tests
- API documentation
- User guides

**Phase 4: Deployment**
- Production setup
- Monitoring
- Error tracking
- Performance optimization

### 4. SUPABASE-SPECIFIC CONSIDERATIONS

Always include issues for:
- Database schema design
- Row Level Security (RLS) policies
- Supabase Auth configuration
- Edge Functions (if needed)
- Storage buckets and policies
- Realtime subscriptions (if needed)

### 5. OUTPUT FORMAT

After creating BRAINSTORM.md:
1. Show a summary of phases and issue counts
2. Highlight any complex dependencies
3. Suggest which issues can be done in parallel
4. Ask if any adjustments are needed before running `/decompose`

## YOUR TASK

The user has provided: **$ARGUMENTS**

Create a comprehensive BRAINSTORM.md file following the structure above. Think through:
1. What is the core problem being solved?
2. What are the essential features for MVP?
3. What's the right technical architecture?
4. How can we break this into atomic issues?
5. What are the dependencies between issues?

Focus on clarity, specificity, and actionability. Every issue should have a clear definition of "done".
