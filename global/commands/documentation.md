---
description: Generate comprehensive documentation suite based on codebase understanding
argument-hint: [--format <md|html|pdf>] [--depth <basic|detailed|comprehensive>] [--update-only]
model: claude-sonnet-4-20250514
---

# Intelligent Documentation Generator

Generate comprehensive documentation for the current codebase, leveraging deep understanding from previous analysis.

## User Request

$ARGUMENTS

## Instructions

### 1. Assess Current Documentation State
- Review existing documentation in docs/, README files, code comments
- Identify documentation gaps and outdated content
- Understand the target audience and documentation requirements

### 2. Leverage Codebase Knowledge
- Use findings from previous codebase analysis (if available via /start command)
- Understand the project architecture, features, and technical stack
- Identify key components, APIs, and integration points that need documentation

### 3. Generate Documentation Suite
Create comprehensive documentation including:
- **README.md**: Project overview, setup instructions, basic usage
- **API Documentation**: Endpoint documentation, request/response examples
- **Architecture Guide**: System design, components, data flow
- **Developer Guide**: Setup, development workflow, contributing guidelines
- **User Guide**: End-user documentation and tutorials
- **Deployment Guide**: Installation, configuration, maintenance

### 4. Documentation Quality Standards
Ensure all documentation includes:
- Clear, concise explanations suitable for the target audience
- Code examples and usage patterns
- Troubleshooting sections and FAQ
- Visual diagrams where helpful (system architecture, data flow)
- API examples with realistic data
- Step-by-step tutorials for common tasks

### 5. Format and Organization
- Use consistent markdown formatting and structure
- Create logical navigation and cross-references
- Include table of contents for longer documents
- Add badges for build status, version, license where appropriate
- Ensure documentation is maintainable and easy to update

## Success Criteria
- Complete documentation coverage of all major features
- Clear setup and usage instructions for new users
- Comprehensive API documentation with examples
- Developer-friendly contribution guidelines
- Proper organization and navigation structure