# MCP Tool Usage Guidelines

> Patterns for using MCP tools correctly to prevent validation errors

## Path Conventions

### MCP Filesystem Tools (relative paths)

Serena and MCP filesystem tools use **relative paths** from project root:

```
✅ relative_path: "src/components/Button.tsx"
✅ relative_path: "./src/utils/helper.ts"
❌ relative_path: "/Users/name/project/src/Button.tsx"  // WRONG - absolute path
```

### Claude Native Tools (absolute paths)

Claude's built-in Read/Edit/Write tools use **absolute paths**:

```
✅ file_path: "/Users/name/project/src/Button.tsx"
❌ file_path: "src/Button.tsx"  // WRONG - relative path
```

## Tool Selection Matrix

| Need | MCP Tool | Native Tool | Notes |
|------|----------|-------------|-------|
| Read file | `mcp__filesystem__read_text_file` | `Read` | Native handles more formats |
| Edit file (regex) | `mcp__plugin_serena_serena__replace_content` | - | Powerful regex support |
| Edit file (exact) | - | `Edit` | Simple replacements |
| Write file | `mcp__filesystem__write_file` | `Write` | Similar capabilities |
| Find symbols | `mcp__plugin_serena_serena__find_symbol` | - | Language-aware |
| Search text | `mcp__plugin_serena_serena__search_for_pattern` | `Grep` | Both work well |
| List files | `mcp__filesystem__list_directory` | `Glob` | Native more flexible |

## Common Parameter Formats

### mcp__filesystem__read_multiple_files

**Correct:**
```json
{
  "paths": ["/absolute/path/file1.ts", "/absolute/path/file2.ts"]
}
```

**Wrong:**
```json
{
  "paths": "file1.ts"  // ❌ String instead of array
}
```

### mcp__filesystem__edit_file

**Correct:**
```json
{
  "path": "/absolute/path/file.ts",
  "edits": [
    { "oldText": "find this", "newText": "replace with" }
  ]
}
```

**Wrong:**
```json
{
  "path": "/absolute/path/file.ts",
  "edits": "find this -> replace with"  // ❌ String instead of array
}
```

### mcp__plugin_serena_serena__replace_content

**Correct:**
```json
{
  "relative_path": "src/file.ts",
  "needle": "pattern to find",
  "repl": "replacement",
  "mode": "literal"
}
```

For regex mode:
```json
{
  "relative_path": "src/file.ts",
  "needle": "function\\s+\\w+",
  "repl": "const $!1 =",
  "mode": "regex"
}
```

**Wrong:**
```json
{
  "relative_path": "/absolute/path/src/file.ts",  // ❌ Absolute path
  "mode": "regex"  // ❌ Missing needle and repl
}
```

## Project Boundary Restrictions

MCP tools cannot write outside project directory:

```
❌ Cannot create file outside of the project directory
   got relative_path='/Users/.../.claude/plans/...'
```

**Solution:** Use Claude's native `Write` tool for files outside project.

## Error Prevention Checklist

Before using MCP tools:

- [ ] **Path format** - Using relative for MCP, absolute for native?
- [ ] **Array parameters** - Using arrays where required (paths, edits)?
- [ ] **Required fields** - All required parameters provided?
- [ ] **Project boundary** - File within project directory?
- [ ] **Read first** - Read file before editing (for native Edit)?

## Common Error Patterns

### Pattern 1: Wrong path format
```
Error: File does not exist
```
→ Check if using relative vs absolute correctly for the tool

### Pattern 2: Wrong parameter type
```
Invalid input: expected array, received string
```
→ Wrap single items in arrays: `["item"]` not `"item"`

### Pattern 3: Missing required parameter
```
The required parameter `old_string` is missing
```
→ You're using wrong tool (MCP vs native) or missing fields

### Pattern 4: Path outside project
```
AssertionError - Cannot create file outside of project directory
```
→ Use Claude's native Write tool for external files
