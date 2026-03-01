---
description: "Synchronize PROJECT-STATUS.md with actual GitHub state. Run periodically or after merging PRs."
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash(gh:*)
  - Bash(git:*)
  - Glob
---

# Torvaldsen Status Sync — Progress Dashboard Update

You are executing the Torvaldsen `/status-sync` command. This synchronizes the project's living documents with the actual state on GitHub.

---

## Step 1: FETCH CURRENT STATE

Gather the real state from GitHub:

```bash
# All issues with full metadata
gh issue list --state all --json number,title,state,labels,milestone --limit 500

# All PRs
gh pr list --state all --json number,title,state,mergedAt,headRefName --limit 500

# Milestone progress
gh api repos/{owner}/{repo}/milestones --jq '.[] | {title, open_issues, closed_issues}'
```

---

## Step 2: CALCULATE METRICS

For each phase (milestone):
- **Total issues** — Count all issues in the milestone
- **Completed** — Count closed issues
- **In Progress** — Count issues with open PRs
- **Blocked** — Count issues with `blocked` label
- **Available** — Total minus (completed + in progress + blocked)
- **Percentage** — (Completed / Total) * 100

Overall:
- **Total progress** — Sum of all completed / Sum of all total
- **Current active phase** — First phase with < 100% completion

---

## Step 3: UPDATE PROJECT-STATUS.md

Rewrite `PROJECT-STATUS.md` with fresh data:

1. **Update header:**
   - Active Phase number and name
   - Overall Progress percentage
   - Last Updated timestamp (now)
   - Last Updated By: "status-sync"

2. **Rewrite Progress Table:**
   | Phase | Name | Total | Done | In Progress | Blocked | Available | % |
   With actual calculated numbers.

3. **Update "Next Available Issues":**
   - Issues that are open, unblocked, in the current phase, with no open PR
   - Prioritize `parallel-safe` labeled issues first

4. **Update "Currently In Progress":**
   - Issues with open PRs — include branch name and author

5. **Update "Blocked Issues":**
   - Issues with `blocked` label — include blocking reason from `.torvaldsen/blocked-issues.md`

6. **Update "Scope Health":**
   - Read `.torvaldsen/scope-manifest.json` for feature completion status

---

## Step 4: UPDATE START_HERE.md

Update the status line:
```markdown
**Phase [N] of [M]** — [Phase Name] — **[X]% complete**
```

---

## Step 5: DETECT ANOMALIES

Check for issues that need attention:

### Orphaned Issues
Issues not in any milestone or not linked to any feature in scope-manifest.json.

### Stale Issues
Issues in progress for more than 2 weeks without activity:
```bash
gh issue list --state open --json number,title,updatedAt | jq '.[] | select(.updatedAt < "[2-weeks-ago]")'
```

### Scope Drift
Compare total issues in GitHub vs total in scope-manifest.json. If they differ, flag it.

### Missing Labels
Issues without required labels (phase, type, area).

Report any anomalies found.

---

## Step 6: COMMIT

```bash
git add PROJECT-STATUS.md START_HERE.md
git commit -m "$(cat <<'EOF'
docs(status): sync project status [$(date +%Y-%m-%d)]

Progress: [X]% complete ([N]/[M] issues)
Active Phase: [N] — [Phase Name]
Anomalies: [none / list]

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

---

## Output

```
Status Sync Complete!

Overall: [X]% complete ([N]/[M] issues)
Active Phase: Phase [N] — [Phase Name] ([X]%)

Phase Progress:
  Phase 1: [X]% ([N]/[M])
  Phase 2: [X]% ([N]/[M])
  ...

Available Now: [N] issues ready to work on
Blocked: [N] issues

Anomalies: [none / list of detected issues]
```
