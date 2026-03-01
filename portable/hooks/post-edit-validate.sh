#!/bin/bash
# Post-edit validation hook - runs TypeScript and ESLint checks after file edits
# Returns exit code 0 on success, 2 to block on error
#
# Bug patterns this hook prevents:
# 1. Stray characters at EOF (the "1" bug from incomplete edits)
# 2. TypeScript errors going unnoticed
# 3. ESLint violations accumulating

FILE_PATH="$1"

# Exit early if no file path provided
if [[ -z "$FILE_PATH" ]]; then
    exit 0
fi

# Skip if not a TypeScript/JavaScript file
if [[ ! "$FILE_PATH" =~ \.(ts|tsx|js|jsx)$ ]]; then
    exit 0
fi

# Skip if file doesn't exist (might have been deleted)
if [[ ! -f "$FILE_PATH" ]]; then
    exit 0
fi

# Find project root by looking for package.json
find_project_root() {
    local dir="$(dirname "$1")"
    while [[ "$dir" != "/" && "$dir" != "." ]]; do
        if [[ -f "$dir/package.json" ]]; then
            echo "$dir"
            return 0
        fi
        dir="$(dirname "$dir")"
    done
    # Fallback to current directory
    echo "$(pwd)"
}

PROJECT_ROOT="$(find_project_root "$FILE_PATH")"

# ═══════════════════════════════════════════════════════════════════════════════
# CHECK 1: Stray characters at EOF (the "1" bug)
# ═══════════════════════════════════════════════════════════════════════════════
# This catches incomplete edits that leave stray characters (often "1") at the end

# Get last few characters of file
LAST_CHARS=$(tail -c 10 "$FILE_PATH" 2>/dev/null | od -c | tail -1)

# Check if file ends with a lone digit (common error pattern)
LAST_CHAR=$(tail -c 2 "$FILE_PATH" 2>/dev/null | head -c 1)
if [[ "$LAST_CHAR" =~ ^[0-9]$ ]]; then
    # Verify it's actually stray (not part of valid code)
    LAST_LINE=$(tail -1 "$FILE_PATH" 2>/dev/null)
    # If the entire last line is just a digit, it's definitely stray
    if [[ "$LAST_LINE" =~ ^[0-9]+$ ]]; then
        echo "⚠️  Warning: Stray character '$LAST_LINE' detected at EOF in $FILE_PATH"
        echo "    This is likely an incomplete edit artifact."
        exit 2
    fi
fi

# ═══════════════════════════════════════════════════════════════════════════════
# CHECK 2: TypeScript compilation
# ═══════════════════════════════════════════════════════════════════════════════
# Only run if tsconfig.json exists in project root

if [[ -f "$PROJECT_ROOT/tsconfig.json" ]]; then
    # Run TypeScript check - limit output to first 20 lines
    cd "$PROJECT_ROOT" || exit 0
    TSC_OUTPUT=$(npx tsc --noEmit 2>&1 | head -20)
    TSC_EXIT_CODE=${PIPESTATUS[0]}

    if [[ $TSC_EXIT_CODE -ne 0 ]]; then
        echo "❌ TypeScript errors found after editing $FILE_PATH:"
        echo "$TSC_OUTPUT"
        echo ""
        echo "    Fix these errors before continuing."
        exit 2
    fi
fi

# ═══════════════════════════════════════════════════════════════════════════════
# CHECK 3: ESLint validation
# ═══════════════════════════════════════════════════════════════════════════════
# Run ESLint on the specific file (non-blocking - just warnings)

cd "$PROJECT_ROOT" || exit 0

# Check for various ESLint config formats
HAS_ESLINT=false
for config in ".eslintrc.json" ".eslintrc.js" ".eslintrc.cjs" ".eslintrc.yaml" ".eslintrc.yml" "eslint.config.js" "eslint.config.mjs"; do
    if [[ -f "$PROJECT_ROOT/$config" ]]; then
        HAS_ESLINT=true
        break
    fi
done

if [[ "$HAS_ESLINT" == "true" ]]; then
    ESLINT_OUTPUT=$(npx eslint "$FILE_PATH" --max-warnings 0 2>&1 | head -15)
    ESLINT_EXIT_CODE=${PIPESTATUS[0]}

    if [[ $ESLINT_EXIT_CODE -ne 0 ]]; then
        echo "⚠️  ESLint issues in $FILE_PATH:"
        echo "$ESLINT_OUTPUT"
        echo ""
        # Don't block on ESLint warnings, just report
        # Uncomment the next line to make ESLint errors blocking:
        # exit 2
    fi
fi

# All checks passed
echo "✅ Validation passed for $(basename "$FILE_PATH")"
exit 0
