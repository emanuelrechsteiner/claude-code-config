# Torvaldsen Development Workflow

> A complete, systematic development methodology inspired by Linus Torvalds' collaborative development principles.

This folder contains the complete workflow for managing software projects from concept to delivery using a structured issue decomposition and team coordination model.

## 📁 Workflow Components

### 1. **01-BRAINSTORM.md** - `/brainstorm` Command
**Purpose:** Transform a project idea into a comprehensive project plan with atomic issues.

**Key Activities:**
- Define project vision and core features
- Create technical architecture documentation
- Decompose project into phases
- Break down features into 2-4 hour atomic issues
- Identify dependencies and parallelization opportunities

**Output:** `BRAINSTORM.md` - A living document with all project phases and issues

**When to Use:** At project initiation or when starting a major new feature

---

### 2. **02-DECOMPOSE.md** - `/decompose` Command
**Purpose:** Convert a BRAINSTORM.md file into tracked GitHub issues with labels, descriptions, and acceptance criteria.

**Key Activities:**
- Parse BRAINSTORM.md for all uncreated issues
- Create GitHub issues with proper formatting
- Apply phase and category labels
- Create issue dependencies
- Update BRAINSTORM.md with issue numbers
- Verify all issues created successfully

**Output:** GitHub Issues #1-#N with proper labels and links

**When to Use:** After finalizing BRAINSTORM.md, before development begins

---

### 3. **03-ISSUE.md** - `/issue <#>` Command
**Purpose:** Complete the full development workflow for a specific GitHub issue.

**7-Phase Workflow:**
1. **Analyze** (5 min) - Fetch issue, identify dependencies
2. **Branch** (1 min) - Create feature branch
3. **Implement** (2-4 hrs) - Write code with standards
4. **Test** (30-60 min) - Unit, integration, manual tests
5. **Commit** (5 min) - Format with conventional commits
6. **PR** (10 min) - Create pull request
7. **Verify** (5 min) - Confirm CI/CD passing

**Output:** Completed GitHub Pull Request ready for review

---

### 4. **04-REVIEW.md** - `/review <#>` Command
**Purpose:** Perform comprehensive code review on a pull request.

**7-Phase Review Process:**
1. **Context** (10 min) - Understand PR purpose
2. **Quality** (20-30 min) - Code style and patterns
3. **Security** (15 min) - Auth, validation, vulnerabilities
4. **Testing** (10 min) - Test coverage and quality
5. **Performance** (10 min) - Queries, caching, rendering
6. **Documentation** (5 min) - Docs and comments
7. **Criteria** (10 min) - Verify acceptance criteria

**Review Outcomes:**
- ✅ APPROVE - Ready to merge
- 💬 REQUEST CHANGES - Issues found
- 💭 COMMENT - Questions or suggestions

---

## 🔄 Complete Workflow Flow

```
START
  ↓
/brainstorm "Project Name"
  ↓ Creates BRAINSTORM.md
/decompose
  ↓ Creates GitHub Issues #1-#N
Multiple Agents in Parallel:
  ├─ /issue 1 → PR #1
  ├─ /issue 2 → PR #2
  └─ /issue N → PR #N
  ↓
Reviewers perform /review #1-#N
  ↓
All PRs merged to development branch
  ↓
Final release/deployment
  ↓
END
```

## 📋 Key Features

### Atomic Issue Design
- Each issue = 2-4 hours maximum
- Independently completable
- Clear acceptance criteria
- No ambiguous language

### Phase Organization
Typical project phases:
1. **Foundation** - Setup, infrastructure, CI/CD
2. **Core Features** - Main functionality
3. **Testing & Docs** - Comprehensive testing
4. **Deployment** - Production setup, monitoring

### Labels System
- **Phase Labels:** `phase-1`, `phase-2`, ..., `phase-12+`
- **Type Labels:** `feature`, `bugfix`, `hotfix`, `refactor`, `docs`
- **Area Labels:** `frontend`, `backend`, `database`, `supabase`, `auth`

### Parallel Execution
Multiple developers can work on different issues simultaneously with no merge conflicts.

## 🚀 Getting Started

### Step 1: Brainstorm
```bash
/brainstorm "Your Project Name"
```

### Step 2: Decompose
```bash
/decompose
```

### Step 3: Develop
```bash
/issue 1
/issue 2
/issue 3
```

### Step 4: Review
```bash
/review #1
/review #2
/review #3
```

## 📊 Example Project

**ConSen(t)ual Dating App**
- Total Issues: 219
- Phases: 18
- Estimated Timeline: 19.5 weeks
- Parallel Development: Up to 18 developers

## 🎯 Best Practices

✅ Clear, atomic issue descriptions
✅ Comprehensive testing before PR
✅ TypeScript strict mode
✅ Security-first code review
✅ Constructive feedback
✅ Complete acceptance criteria verification

---

**Version:** 1.0
**Last Updated:** March 1, 2026
**Inspired By:** Linus Torvalds' Linux Kernel Development Model
