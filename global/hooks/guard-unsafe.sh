#!/bin/bash
# Guard against potentially unsafe operations
# This hook validates commands before execution
# Exit codes: 0 = allow, 2 = block

# Read JSON input from stdin
INPUT=$(cat)

# Extract command from tool_input
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# If no command, allow (not a Bash command)
if [[ -z "$COMMAND" ]]; then
    exit 0
fi

# =============================================================================
# CRITICAL BLOCKERS - These commands are never allowed
# =============================================================================

# Destructive file system operations
if [[ "$COMMAND" =~ rm[[:space:]]+-rf[[:space:]]+(/|~|\$HOME) ]]; then
    echo "BLOCKED: Destructive rm -rf on critical path" >&2
    exit 2
fi

if [[ "$COMMAND" =~ rm[[:space:]]+-rf[[:space:]]+\* ]]; then
    echo "BLOCKED: Destructive rm -rf with wildcard" >&2
    exit 2
fi

# Privilege escalation
if [[ "$COMMAND" =~ ^sudo[[:space:]] ]] || [[ "$COMMAND" =~ \|[[:space:]]*sudo ]]; then
    echo "BLOCKED: sudo commands require manual execution" >&2
    exit 2
fi

if [[ "$COMMAND" =~ ^su[[:space:]] ]]; then
    echo "BLOCKED: su commands require manual execution" >&2
    exit 2
fi

# Disk formatting and partition operations
if [[ "$COMMAND" =~ (mkfs|fdisk|parted|gdisk) ]]; then
    echo "BLOCKED: Disk formatting commands require manual execution" >&2
    exit 2
fi

# Raw disk writes
if [[ "$COMMAND" =~ dd[[:space:]].*if= ]]; then
    echo "BLOCKED: dd commands require manual execution" >&2
    exit 2
fi

# Writing to device files (except /dev/null and /dev/stdout which are safe)
if [[ "$COMMAND" =~ \>[[:space:]]*/dev/ ]] && [[ ! "$COMMAND" =~ /dev/null ]] && [[ ! "$COMMAND" =~ /dev/stdout ]] && [[ ! "$COMMAND" =~ /dev/stderr ]]; then
    echo "BLOCKED: Writing to device files requires manual execution" >&2
    exit 2
fi

# =============================================================================
# SECURITY SENSITIVE - Block commands that could exfiltrate data
# =============================================================================

# Network exfiltration with curl/wget posting data
if [[ "$COMMAND" =~ curl.*(-d|--data|-F|--form|--upload-file) ]]; then
    echo "BLOCKED: curl data upload requires manual execution" >&2
    exit 2
fi

if [[ "$COMMAND" =~ wget.*--post ]]; then
    echo "BLOCKED: wget POST requires manual execution" >&2
    exit 2
fi

# Reverse shells and netcat
if [[ "$COMMAND" =~ (nc|netcat|ncat)[[:space:]] ]]; then
    echo "BLOCKED: netcat commands require manual execution" >&2
    exit 2
fi

# SSH key operations
if [[ "$COMMAND" =~ ssh-keygen.*-f ]]; then
    echo "BLOCKED: SSH key generation requires manual execution" >&2
    exit 2
fi

# =============================================================================
# GIT DANGEROUS OPERATIONS - These need extra caution
# =============================================================================

if [[ "$COMMAND" =~ git[[:space:]]+push[[:space:]]+--force ]]; then
    echo "WARNING: Force push detected - proceeding with caution" >&2
    # Allow but warn - could also exit 2 to block
fi

if [[ "$COMMAND" =~ git[[:space:]]+reset[[:space:]]+--hard ]]; then
    echo "WARNING: Hard reset detected - uncommitted changes will be lost" >&2
fi

if [[ "$COMMAND" =~ git[[:space:]]+clean[[:space:]]+-fd ]]; then
    echo "WARNING: Clean with -fd will delete untracked files and directories" >&2
fi

# =============================================================================
# ENVIRONMENT VARIABLE EXPOSURE
# =============================================================================

if [[ "$COMMAND" =~ (printenv|env)[[:space:]]*$ ]] || [[ "$COMMAND" =~ echo[[:space:]]+\$[A-Z_]*KEY ]] || [[ "$COMMAND" =~ echo[[:space:]]+\$[A-Z_]*SECRET ]] || [[ "$COMMAND" =~ echo[[:space:]]+\$[A-Z_]*TOKEN ]]; then
    echo "WARNING: Potential secret exposure in command" >&2
    # Allow but warn - secrets should be in .env files
fi

# =============================================================================
# SAFE - Allow the command
# =============================================================================

exit 0
