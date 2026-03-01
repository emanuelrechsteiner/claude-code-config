---
name: consistency-check
description: "Comprehensive manuscript consistency checker. Analyzes novels for naming inconsistencies, timeline errors, plot holes, plausibility issues, and detail contradictions (like 'laser drill vs. sharp stone'). Use for manuscripts, novels, screenplays. Triggers on: 'consistency check', 'check consistency', 'find inconsistencies', 'plot holes', 'continuity errors', 'manuscript review'."
user-invocable: false
allowed-tools: Read, Glob, Grep, Task
---

# Consistency Check Skill - Manuscript Analysis

## Purpose

Perform comprehensive consistency analysis on a manuscript by coordinating five specialized agents:

1. **naming-consistency-agent** - Character names, places, technology terms
2. **timeline-consistency-agent** - Dates, durations, sequences
3. **story-loopholes-agent** - Plot holes, unresolved threads
4. **plausibility-agent** - Believability within story rules
5. **detail-consistency-agent** - Specific object/action contradictions

## Invocation

```
/consistency-check [chapter-range]
/consistency-check                    # Full manuscript
/consistency-check 1-3                # Chapters 1-3 only
/consistency-check Kapitel_2.1.docx   # Single file
```

## Consistency Check Protocol

### Step 1: Locate Manuscript Files

```bash
# Find all chapter files
glob "**/*.docx" "**/*.md" "**/Kapitel*.docx"
```

### Step 2: Launch Sub-Agents in Parallel

Using the Task tool, spawn all five agents simultaneously:

```
Agent 1: naming-consistency-agent
Prompt: "Analyze [files] for naming inconsistencies. Track all character names, place names, technology terms, and objects. Flag any variations, misspellings, or contradictions."

Agent 2: timeline-consistency-agent
Prompt: "Analyze [files] for timeline inconsistencies. Build a temporal map, verify all date references, check 'X days later' calculations, verify character ages."

Agent 3: story-loopholes-agent
Prompt: "Analyze [files] for plot holes. Track setup/payoff promises, verify character motivations, check world rule consistency, flag unresolved threads."

Agent 4: plausibility-agent
Prompt: "Analyze [files] for plausibility issues. Check for convenience clusters, unrealistic reactions, implausible competence, and world rule violations."

Agent 5: detail-consistency-agent
Prompt: "Analyze [files] for detail contradictions. Track every object's description, creation method, and state. Flag ANY changes like 'laser drill vs. stone'."
```

### Step 3: Compile Unified Report

Merge all sub-agent findings into one comprehensive report.

## Report Format

```markdown
# Manuscript Consistency Report

**Analyzed**: [file list]
**Date**: [date]
**Overall Assessment**: [Excellent / Good / Needs Work / Critical]

---

## Executive Summary

| Category | Critical | Major | Minor |
|----------|----------|-------|-------|
| Details | X | X | X |
| Timeline | X | X | X |
| Plot | X | X | X |
| Names | X | X | X |
| Plausibility | X | X | X |
| **TOTAL** | **X** | **X** | **X** |

---

## 🔴 Critical Issues (Must Fix)

### Detail Contradictions
[From detail-consistency-agent]

### Timeline Breaks
[From timeline-consistency-agent]

---

## 🟠 Major Issues (Should Fix)

### Plot Holes
[From story-loopholes-agent]

### Naming Issues
[From naming-consistency-agent]

---

## 🟡 Minor Issues (Nice to Fix)

### Plausibility Concerns
[From plausibility-agent]

---

## Full Details by Chapter

### Chapter 1.x
[All issues found in this chapter]

### Chapter 2.x
[All issues found in this chapter]

---

## Continuity Database

### Characters
| Name | Canonical | Aliases | First Seen |
|------|-----------|---------|------------|
| Jakob Wahad | Jakob Wahad | Kurzer | Ch 1.2 |

### Objects
| Object | Description | Creation | Owner |
|--------|-------------|----------|-------|
| Amulett | silber, gegenläufige Halbkreise | Neil | Jakob (after Ch X) |

### Timeline
| Date | Event | Chapter |
|------|-------|---------|
| 31.10.2226 | Neil "fällt" | 1.3 |

---

## Recommendations

1. [Highest priority fixes]
2. [...]
```

## Quick Mode

For fast pre-review check, run only critical agents:

```
/consistency-check --quick
```

Runs only:
- detail-consistency-agent
- timeline-consistency-agent

Returns: `✅ No critical issues` or `❌ X critical issues found`

## Example Issue Types

### Detail Contradiction (CRITICAL)
```
❌ Ch 1.1: "mit einem Laser-Bohrer eingeritzt"
   Ch 3.2: "das er mit einem spitzen Stein eingeritzt hatte"
   → Same sign, different creation tools
```

### Timeline Error (CRITICAL)
```
❌ Ch 2.1: "seit 14 Tagen" (K.I. outage)
   But dates show only 10 days passed
```

### Plot Hole (MAJOR)
```
❌ Setup: Judith's pregnancy (Ch 6.2)
   Payoff: MISSING - never resolved
```

### Naming Issue (MAJOR)
```
❌ "AllWissen" (standard) vs "Allwissen" (Ch 4.3)
   → Inconsistent capitalization
```

### Plausibility Issue (MINOR)
```
⚠️ Ch 6.3: Escape too easy
   (Noted in text as suspicious - may be intentional)
```

## Integration

After running consistency check:
1. Review report with author
2. Prioritize fixes by severity
3. Update manuscript
4. Re-run to verify fixes

## Special Instructions for Nemesin

For this specific manuscript, remember:
- Two hypotheses (Menschen vs. K.I.) must BOTH remain plausible
- "Geheilten" emotional flatness is INTENTIONAL
- German text with specific terminology (Derivat, AllWissen, etc.)
- Track the Brüder-Zeichen (symbol) carefully
