---
name: validation
description: Pre-execution validation system ensuring proper understanding of task scope and instructions. Prevents misunderstandings, validates data structure preservation, and ensures workflow compliance. Use before complex tasks, when scope is unclear, or to validate approach. Triggers on "validate", "verify scope", "check understanding", "pre-task validation", "compliance check".
---

# Validation Skill - Pre-Execution Compliance Checker

## Overview

This skill ensures proper understanding of task scope and instructions before execution, preventing critical failures from misinterpretation.

## Memory-First Protocol (MANDATORY)

Before starting any task:
1. Query Memory MCP for validation rules: `mcp__memory__search_nodes`
2. Load agent instruction entities: `mcp__memory__open_nodes`

During validation:
- Create validation entities: `mcp__memory__create_entities` with type "Validation"
- Add compliance results as observations: `mcp__memory__add_observations`

## Pre-Execution Validation Protocol

**MANDATORY for all complex tasks:**

### 1. Instruction Comprehension
```yaml
validation_checklist:
  agent_instruction_comprehension:
    - read_system_instructions: true
    - understand_role_and_responsibilities: true
    - confirm_tools_and_capabilities: true
    - validate_reporting_requirements: true
```

### 2. Task Scope Validation
```yaml
  task_scope_validation:
    - understand_task_requirements: true
    - distinguish_meta_vs_technical_scope: true
    - confirm_deliverable_expectations: true
    - identify_dependencies_and_constraints: true
```

### 3. Data Structure Analysis
```yaml
  data_structure_analysis:
    - examine_existing_data_structures: true
    - understand_preservation_requirements: true
    - plan_non_destructive_modifications: true
    - validate_append_vs_replace_approach: true
```

### 4. Workflow Compliance
```yaml
  workflow_compliance_check:
    - verify_reporting_protocol_understanding: true
    - confirm_coordination_communication: true
    - validate_commit_frequency_requirements: true
    - check_quality_gate_comprehension: true
```

## Validation Questions Framework

### Core Understanding Questions
Before any task, answer these questions:

**Instruction Comprehension:**
- "Have I read my complete system instructions?"
- "Do I understand my role, responsibilities, and limitations?"
- "What tools am I permitted to use for this task?"
- "Who do I need to report to before and after this task?"

**Task Scope Validation:**
- "Is this a meta-analysis task or technical implementation?"
- "What are the specific deliverables expected?"
- "Am I the correct skill for this type of task?"
- "Do I need to coordinate with other skills?"

**Data Structure Preservation:**
- "Am I modifying existing data structures?"
- "Have I analyzed the current data format and patterns?"
- "Should I append to existing data or create new structures?"
- "What preservation requirements must I follow?"

**Workflow Compliance:**
- "Do I need authorization for this task?"
- "What is my required reporting frequency?"
- "When and how should I commit my work?"
- "Are there quality gates I must pass?"

## Failure Response Protocol

### Critical Validation Failures

```yaml
failure_responses:
  instruction_not_read:
    action: halt_execution
    requirement: must_read_instructions_completely
    validation: must_summarize_key_responsibilities
    
  scope_misunderstanding:
    action: clarify_with_user
    requirement: explicit_scope_confirmation
    validation: must_restate_understanding
    
  data_structure_ignorance:
    action: mandatory_structure_analysis
    requirement: examine_existing_patterns
    validation: document_preservation_plan
    
  workflow_violation_risk:
    action: protocol_review_required
    requirement: confirm_reporting_requirements
    validation: demonstrate_compliance_understanding
```

## Validation Documentation Template

```markdown
## Validation Report: [Task Name]

### Pre-Task Validation Results
- [ ] System instructions read and understood
- [ ] Task scope correctly identified
- [ ] Data structure preservation plan confirmed
- [ ] Workflow compliance requirements understood
- [ ] Reporting protocol acknowledged

### Task Understanding Summary
**Task Type**: [meta/technical/coordination]
**Deliverables**: [specific outputs expected]
**Approach**: [append/create/modify/analyze]
**Dependencies**: [other skills/data/approvals needed]

### Risk Assessment
**Scope Misunderstanding Risk**: [low/medium/high]
**Data Integrity Risk**: [low/medium/high]
**Workflow Violation Risk**: [low/medium/high]
**Mitigation Plan**: [specific prevention measures]

### Authorization Status
- **Validation Passed**: [ ]
- **Ready to Proceed**: [ ]
- **Additional Clarification Needed**: [details]
```

## Activation Triggers

### Automatically Validate When:
- Before any complex task execution
- When new skill receives assignment
- After task scope changes or clarifications
- When data modification tasks detected
- For all multi-skill coordination tasks

## Prohibited Assumptions

### Never Assume:
- Technical implementation when task is meta-analysis
- Replace when task is append
- Create new when should modify existing
- Proceed without scope confirmation

## Success Metrics

### Validation Effectiveness
- **Scope Misunderstanding Prevention**: Target 95% reduction
- **Data Integrity Violations**: Target 100% elimination
- **Workflow Compliance**: Target 90% first-pass compliance
- **User Steering Reduction**: Target 80% fewer corrections needed

### Performance Improvement
- **Task Understanding Accuracy**: Target >95%
- **First-Pass Success Rate**: Target >80%
- **Instruction Adherence**: Target >90%
- **Quality Gate Compliance**: Target >95%
