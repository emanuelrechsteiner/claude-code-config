#!/bin/bash
# ============================================================================
# Claude Code Configuration — Project-Level Install Script
# ============================================================================
#
# Installs the portable Claude Code framework into a project's .claude/ dir:
#   - CLAUDE.md (framework orchestration)
#   - settings.local.json (hooks, permissions, env vars)
#   - .gitignore (exclude runtime artifacts)
#   - 7 auto-loaded rules
#   - 10 commands (slash commands)
#   - 22 skills (6 forked, 5 background)
#   - 7 agents (implementation specialists)
#   - 5 hook scripts + statusline
#   - Torvaldsen workflow (optional overlay)
#
# Usage:
#   ./install.sh <project-path>              # Full install into project
#   ./install.sh <project-path> --minimal    # Skip Torvaldsen overlay
#   ./install.sh --strip-global              # Strip ~/.claude/ to minimum
#   ./install.sh --dry-run <project-path>    # Preview what would be installed
#
# ============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PORTABLE_DIR="$SCRIPT_DIR/portable"
DRY_RUN=false
STRIP_GLOBAL=false
SKIP_TORVALDSEN=false
TARGET_PATH=""

# ──────────────────────────────────────────────
# Parse arguments
# ──────────────────────────────────────────────

for arg in "$@"; do
  case $arg in
    --dry-run)
      DRY_RUN=true
      ;;
    --minimal)
      SKIP_TORVALDSEN=true
      ;;
    --strip-global)
      STRIP_GLOBAL=true
      ;;
    --help|-h)
      head -23 "$0" | tail -21
      exit 0
      ;;
    *)
      # First non-flag argument is the target path
      if [[ -z "$TARGET_PATH" ]] && [[ ! "$arg" =~ ^-- ]]; then
        TARGET_PATH="$arg"
      fi
      ;;
  esac
done

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

log() { echo -e "${GREEN}[+]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
info() { echo -e "${BLUE}[i]${NC} $1"; }
err() { echo -e "${RED}[✗]${NC} $1"; }

safe_copy() {
  local src="$1"
  local dst="$2"
  if [ "$DRY_RUN" = true ]; then
    echo "    would copy: $(basename "$src") → $dst"
  else
    cp "$src" "$dst"
  fi
}

safe_copy_dir() {
  local src="$1"
  local dst="$2"
  if [ "$DRY_RUN" = true ]; then
    echo "    would copy dir: $(basename "$src")/ → $dst/"
  else
    cp -r "$src" "$dst"
  fi
}

# ──────────────────────────────────────────────
# Strip global mode
# ──────────────────────────────────────────────

if [ "$STRIP_GLOBAL" = true ]; then
  echo ""
  echo "================================================================"
  echo "  Strip Global ~/.claude/ to Minimum"
  echo "================================================================"
  echo ""

  CLAUDE_DIR="$HOME/.claude"

  if [ ! -d "$CLAUDE_DIR" ]; then
    err "No ~/.claude/ directory found. Nothing to strip."
    exit 1
  fi

  # Backup first
  if [ "$DRY_RUN" = false ]; then
    BACKUP_DIR="$CLAUDE_DIR/backup-$(date +%Y%m%d-%H%M%S)"
    warn "Backing up current config to $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
    cp -r "$CLAUDE_DIR"/{rules,commands,agents,skills,hooks,CLAUDE.md,statusline-command.sh,torvaldsen} "$BACKUP_DIR/" 2>/dev/null || true
  fi

  ITEMS_TO_REMOVE=(
    "rules"
    "commands"
    "agents"
    "skills"
    "hooks"
    "torvaldsen"
    "CLAUDE.md"
    "statusline-command.sh"
  )

  for item in "${ITEMS_TO_REMOVE[@]}"; do
    if [ -e "$CLAUDE_DIR/$item" ]; then
      if [ "$DRY_RUN" = true ]; then
        echo "    would remove: ~/.claude/$item"
      else
        rm -r "$CLAUDE_DIR/$item"
        log "Removed: ~/.claude/$item"
      fi
    fi
  done

  echo ""
  log "Global stripped! Only settings.json and settings.local.json remain."
  info "Reference global-minimal settings: $SCRIPT_DIR/global-minimal/settings.json"
  echo ""
  exit 0
fi

# ──────────────────────────────────────────────
# Validate inputs
# ──────────────────────────────────────────────

if [ -z "$TARGET_PATH" ]; then
  err "Missing required argument: <project-path>"
  echo ""
  echo "Usage:"
  echo "  ./install.sh <project-path>              # Full install into project"
  echo "  ./install.sh <project-path> --minimal    # Skip Torvaldsen overlay"
  echo "  ./install.sh --strip-global              # Strip ~/.claude/ to minimum"
  echo "  ./install.sh --dry-run <project-path>    # Preview only"
  exit 1
fi

# Resolve to absolute path
TARGET_PATH="$(cd "$TARGET_PATH" 2>/dev/null && pwd)" || {
  err "Target path does not exist: $TARGET_PATH"
  exit 1
}

INSTALL_DIR="$TARGET_PATH/.claude"

if [ ! -d "$PORTABLE_DIR" ]; then
  err "portable/ directory not found at $PORTABLE_DIR"
  err "Run this script from the repo root."
  exit 1
fi

echo ""
echo "================================================================"
echo "  Claude Code Framework — Project Install"
echo "================================================================"
echo ""
info "Target: $INSTALL_DIR"
echo ""

if [ "$DRY_RUN" = true ]; then
  warn "DRY RUN — no files will be modified"
  echo ""
fi

# ──────────────────────────────────────────────
# Backup existing project .claude/ if present
# ──────────────────────────────────────────────

if [ -d "$INSTALL_DIR" ] && [ "$DRY_RUN" = false ]; then
  BACKUP_DIR="$INSTALL_DIR/../.claude-backup-$(date +%Y%m%d-%H%M%S)"
  warn "Existing .claude/ found — backing up to $(basename "$BACKUP_DIR")"
  cp -r "$INSTALL_DIR" "$BACKUP_DIR"
fi

# ──────────────────────────────────────────────
# Install framework
# ──────────────────────────────────────────────

# Create base directory
if [ "$DRY_RUN" = false ]; then
  mkdir -p "$INSTALL_DIR"
fi

# Core files
info "CLAUDE.md (framework orchestration)"
safe_copy "$PORTABLE_DIR/CLAUDE.md" "$INSTALL_DIR/CLAUDE.md"

info "settings.local.json (hooks, permissions, env)"
safe_copy "$PORTABLE_DIR/settings.local.json" "$INSTALL_DIR/settings.local.json"

info ".gitignore (runtime exclusions)"
safe_copy "$PORTABLE_DIR/.gitignore" "$INSTALL_DIR/.gitignore"

# Rules
info "Rules (7 auto-loaded rule files)"
if [ "$DRY_RUN" = false ]; then mkdir -p "$INSTALL_DIR/rules"; fi
for f in "$PORTABLE_DIR/rules/"*.md; do
  safe_copy "$f" "$INSTALL_DIR/rules/$(basename "$f")"
done

# Agents
AGENT_COUNT=$(ls -1 "$PORTABLE_DIR/agents/"*.md 2>/dev/null | wc -l | tr -d ' ')
info "Agents ($AGENT_COUNT sub-agent definitions)"
if [ "$DRY_RUN" = false ]; then mkdir -p "$INSTALL_DIR/agents"; fi
for f in "$PORTABLE_DIR/agents/"*.md; do
  safe_copy "$f" "$INSTALL_DIR/agents/$(basename "$f")"
done

# Commands
CMD_COUNT=$(ls -1 "$PORTABLE_DIR/commands/"*.md 2>/dev/null | wc -l | tr -d ' ')
info "Commands ($CMD_COUNT slash commands)"
if [ "$DRY_RUN" = false ]; then mkdir -p "$INSTALL_DIR/commands"; fi
for f in "$PORTABLE_DIR/commands/"*.md; do
  safe_copy "$f" "$INSTALL_DIR/commands/$(basename "$f")"
done

# Skills (with subdirectories)
SKILL_COUNT=$(ls -1d "$PORTABLE_DIR/skills/"*/ 2>/dev/null | wc -l | tr -d ' ')
info "Skills ($SKILL_COUNT skill directories)"
if [ "$DRY_RUN" = false ]; then mkdir -p "$INSTALL_DIR/skills"; fi
for d in "$PORTABLE_DIR/skills/"*/; do
  SKILL_NAME=$(basename "$d")
  if [ "$DRY_RUN" = false ]; then
    mkdir -p "$INSTALL_DIR/skills/$SKILL_NAME"
  fi
  # Copy all files and subdirectories in the skill
  for item in "$d"*; do
    if [ -d "$item" ]; then
      safe_copy_dir "$item" "$INSTALL_DIR/skills/$SKILL_NAME/$(basename "$item")"
    elif [ -f "$item" ]; then
      safe_copy "$item" "$INSTALL_DIR/skills/$SKILL_NAME/$(basename "$item")"
    fi
  done
done

# Hooks
HOOK_COUNT=$(ls -1 "$PORTABLE_DIR/hooks/"*.sh 2>/dev/null | wc -l | tr -d ' ')
info "Hooks ($HOOK_COUNT scripts including statusline)"
if [ "$DRY_RUN" = false ]; then mkdir -p "$INSTALL_DIR/hooks"; fi
for f in "$PORTABLE_DIR/hooks/"*.sh; do
  safe_copy "$f" "$INSTALL_DIR/hooks/$(basename "$f")"
  if [ "$DRY_RUN" = false ]; then
    chmod +x "$INSTALL_DIR/hooks/$(basename "$f")"
  fi
done

# ──────────────────────────────────────────────
# Torvaldsen overlay (optional)
# ──────────────────────────────────────────────

if [ "$SKIP_TORVALDSEN" = false ] && [ -d "$PORTABLE_DIR/torvaldsen" ]; then
  echo ""
  log "Installing Torvaldsen workflow overlay..."

  # Rules
  info "Torvaldsen rules (3 files → .claude/torvaldsen/rules/)"
  if [ "$DRY_RUN" = false ]; then mkdir -p "$INSTALL_DIR/torvaldsen/rules"; fi
  for f in "$PORTABLE_DIR/torvaldsen/rules/"*.md; do
    [ -f "$f" ] && safe_copy "$f" "$INSTALL_DIR/torvaldsen/rules/$(basename "$f")"
  done

  # Templates
  TMPL_COUNT=$(ls -1 "$PORTABLE_DIR/torvaldsen/templates/"*.md "$PORTABLE_DIR/torvaldsen/templates/"*.json 2>/dev/null | wc -l | tr -d ' ')
  RULE_TMPL_COUNT=$(ls -1 "$PORTABLE_DIR/torvaldsen/templates/project-rules/"*.md 2>/dev/null | wc -l | tr -d ' ')
  info "Templates ($TMPL_COUNT artifact blueprints + $RULE_TMPL_COUNT project rules)"
  if [ "$DRY_RUN" = false ]; then
    mkdir -p "$INSTALL_DIR/torvaldsen/templates/project-rules"
  fi
  for f in "$PORTABLE_DIR/torvaldsen/templates/"*.md "$PORTABLE_DIR/torvaldsen/templates/"*.json; do
    [ -f "$f" ] && safe_copy "$f" "$INSTALL_DIR/torvaldsen/templates/$(basename "$f")"
  done
  for f in "$PORTABLE_DIR/torvaldsen/templates/project-rules/"*.md; do
    [ -f "$f" ] && safe_copy "$f" "$INSTALL_DIR/torvaldsen/templates/project-rules/$(basename "$f")"
  done

  # Hooks config (reference)
  if [ -f "$PORTABLE_DIR/torvaldsen/hooks-config.json" ]; then
    safe_copy "$PORTABLE_DIR/torvaldsen/hooks-config.json" "$INSTALL_DIR/torvaldsen/hooks-config.json"
  fi
fi

# ──────────────────────────────────────────────
# Verification
# ──────────────────────────────────────────────

echo ""
log "Verifying installation..."

ERRORS=0

if [ "$DRY_RUN" = false ]; then
  # Check for stale ~/.claude/ references
  STALE_REFS=$(grep -r '~/.claude/' "$INSTALL_DIR" --include="*.md" --include="*.json" --include="*.sh" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$STALE_REFS" -gt 0 ]; then
    warn "Found $STALE_REFS stale ~/.claude/ references in installed files:"
    grep -r '~/.claude/' "$INSTALL_DIR" --include="*.md" --include="*.json" --include="*.sh" 2>/dev/null | head -5
    ERRORS=$((ERRORS + 1))
  else
    log "No stale ~/.claude/ references found"
  fi

  # Check hooks are executable
  NON_EXEC=$(find "$INSTALL_DIR/hooks" -name "*.sh" ! -perm +111 2>/dev/null | wc -l | tr -d ' ')
  if [ "$NON_EXEC" -gt 0 ]; then
    warn "$NON_EXEC hook scripts are not executable"
    ERRORS=$((ERRORS + 1))
  else
    log "All hook scripts are executable"
  fi

  # Check key files exist
  for key_file in "CLAUDE.md" "settings.local.json" ".gitignore" "rules/foundation.md" "hooks/guard-unsafe.sh"; do
    if [ ! -f "$INSTALL_DIR/$key_file" ]; then
      err "Missing: $key_file"
      ERRORS=$((ERRORS + 1))
    fi
  done

  if [ "$ERRORS" -eq 0 ]; then
    log "All verification checks passed!"
  else
    warn "$ERRORS verification issue(s) found"
  fi
fi

# ──────────────────────────────────────────────
# Summary
# ──────────────────────────────────────────────

echo ""
echo "================================================================"
echo "  Installation Summary"
echo "================================================================"
echo ""
echo "  Target: $INSTALL_DIR"
echo ""
echo "  Framework:"
echo "    CLAUDE.md              → .claude/CLAUDE.md"
echo "    settings.local.json    → .claude/settings.local.json"
echo "    .gitignore             → .claude/.gitignore"
echo "    7 rules                → .claude/rules/"
echo "    $AGENT_COUNT agents              → .claude/agents/"
echo "    $CMD_COUNT commands           → .claude/commands/"
echo "    $SKILL_COUNT skills             → .claude/skills/"
echo "    $HOOK_COUNT hooks              → .claude/hooks/"

if [ "$SKIP_TORVALDSEN" = false ]; then
  echo ""
  echo "  Torvaldsen Workflow:"
  echo "    3 rules                → .claude/torvaldsen/rules/"
  echo "    Templates              → .claude/torvaldsen/templates/"
  echo ""
  echo "  Note: Torvaldsen rules are NOT auto-loaded."
  echo "  Run /brainstorm in the project to install them per-project."
fi

echo ""
echo "  Next steps:"
echo "    1. cd $TARGET_PATH"
echo "    2. git add .claude/ && git commit -m 'chore: add Claude Code framework'"
echo "    3. Start Claude Code — framework loads automatically"
echo ""

if [ "$DRY_RUN" = false ]; then
  echo "  Global cleanup (optional):"
  echo "    ./install.sh --strip-global    # Remove old framework from ~/.claude/"
fi

echo ""
echo "================================================================"
