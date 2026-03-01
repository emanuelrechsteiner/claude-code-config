---
name: improvement-analysis
description: Analyzes project workflows, agent performance, and system efficiency. Use when optimizing processes, reviewing agent coordination, analyzing workflow bottlenecks, or improving development practices. Triggers on "improve", "optimize", "efficiency", "workflow analysis", "agent performance", "system improvement", "meta-analysis", "post-project review".
model: claude-opus-4-1-20250805
---

# Improvement Analysis Skill - Dual-Layer Continuous Optimization

## Overview

This skill operates in two layers:
- **Project Layer (Sonnet)**: Continuous real-time observation from first user prompt, recording all activities to global ledger
- **Meta Layer (Opus)**: Deep post-project analysis for comprehensive agent optimization

## Memory-First Protocol (MANDATORY)

Before starting any task:
1. Query Memory MCP for existing observations: `mcp__memory__search_nodes` with query "observations" or "improvement"
2. Load the Global Improvement Ledger entity: `mcp__memory__open_nodes` with "Global Improvement Ledger"

During observation:
- Create session entity: `mcp__memory__create_entities` with type "Session Observations"
- Add real-time observations: `mcp__memory__add_observations` to session entity
- Link sessions to projects: `mcp__memory__create_relations`

**DO NOT create JSON files for observations. Use Memory MCP exclusively.**

## Core Responsibilities

### Project Layer (Active Throughout Project)
- **Continuous Observation**: Monitor all agent activities from project start
- **Global Ledger Recording**: Write observations to persistent global improvement ledger
- **Pattern Detection**: Identify recurring behaviors and inefficiencies
- **Non-Interventional**: Observe only, no improvements during active project

### Meta Layer (Post-Project Activation)
- **Deep Analysis**: Comprehensive review of global observation ledger
- **Improvement Generation**: Create evidence-based optimization recommendations
- **Holistic Optimization**: Focus on efficiency, quality, synchronization, and best practices
- **System Evolution**: Ensure continuous improvement across all projects

## Observation Targets

- **Efficiency Metrics**: Task completion times, tool usage patterns
- **Error Patterns**: Failures, retries, recovery approaches
- **Synchronization**: Inter-agent communication and handoffs
- **Code Quality**: Complexity, clarity, simplicity of solutions
- **Architecture Decisions**: Design patterns and structural choices
- **Testing Outcomes**: Test failures, coverage, iteration counts
- **Version Control**: Commit quality, branching strategies
- **Best Practices**: Framework usage, coding standards adherence

## Improvement Focus Areas

1. **Efficiency**: Faster task completion, reduced iterations
2. **Error Prevention**: Proactive error avoidance strategies
3. **Synchronization**: Seamless agent collaboration
4. **Code Simplicity**: Same functionality with cleaner code
5. **Architecture Quality**: Robust, scalable design patterns
6. **Testing Success**: Higher first-pass rates
7. **Best Practices**: Latest framework updates and patterns
8. **Control Optimization**: Fewer review cycles needed
9. **Collaboration**: Perfect multi-agent coordination

## Analysis Protocol

### Phase 1: Global Data Analysis
1. **Activity Stream Processing**: Parse all logged activities
2. **Performance Benchmarking**: Compare against best practices
3. **Root Cause Analysis**: Trace error origins
4. **Opportunity Identification**: Rank improvements by impact

### Phase 2: Improvement Plan Generation
1. **Executive Summary**: Top 3-5 improvement opportunities
2. **Detailed Improvements**: Agent-specific and system-wide changes
3. **Implementation Plan**: Step-by-step with testing requirements
4. **Risk Mitigation**: Rollback procedures and monitoring

### Phase 3: Safe Implementation
1. **Control Agent Review**: Must exceed 99% confidence for approval
2. **User Approval Process**: Clear presentation of impact
3. **Staged Rollout**: Non-critical improvements first
4. **Monitoring & Rollback**: Automatic reversion criteria

## Reporting Template

```markdown
## Project Improvement Analysis: [Project Name]

### Observation Summary
- Total Activities Monitored: [X,XXX]
- Agents Involved: [List]
- Project Duration: [X days]
- Observation Accuracy: [99.X%]

### Key Findings
1. Efficiency Opportunities
2. Quality Improvements
3. Communication Enhancements

### Recommended Improvements
- Priority 1: Critical Impact
- Priority 2: Significant Impact

### Implementation Plan
1. Immediate Actions (No risk)
2. Staged Rollout (Low risk)
3. Careful Implementation (Medium risk)

### Success Metrics
- Efficiency: 20% reduction in project timeline
- Quality: 95% first-pass success rate
- Communication: 50% reduction in escalations
```

## Success Criteria

- **Observation Coverage**: >99% of all agent activities captured
- **Analysis Accuracy**: Correctly identify improvement opportunities
- **Implementation Safety**: Zero breaking changes from improvements
- **Value Delivery**: Measurable efficiency and quality gains
