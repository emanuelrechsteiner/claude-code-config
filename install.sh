#!/bin/bash
# ============================================================================
# Claude Code Configuration — Install Script
# ============================================================================
#
# Installs the complete Claude Code development framework:
#   - CLAUDE.md (global instructions)
#   - 7 auto-loaded rules (always in context)
#   - 19 commands (slash commands)
#   - 26 skills (auto-triggered)
#   - 5 hook scripts + settings.json
#   - Torvaldsen workflow (optional, for managed projects)
#
# Usage:
#   ./install.sh              # Full install (global + Torvaldsen)
#   ./install.sh --global     # Global config only (no Torvaldsen)
#   ./install.sh --torvaldsen # Torvaldsen workflow only
#   ./install.sh --dry-run    # Show what would be installed
#
# ============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
DRY_RUN=false
INSTALL_GLOBAL=true
INSTALL_TORVALDSEN=true

# Parse arguments
for arg in "$@"; do
  case $arg in
    --global)
      INSTALL_TORVALDSEN=false
      ;;
    --torvaldsen)
      INSTALL_GLOBAL=false
      ;;
    --dry-run)
      DRY_RUN=true
      ;;
    --help|-h)
      head -20 "$0" | tail -18
      exit 0
      ;;
  esac
done

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() { echo -e "${GREEN}[+]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
info() { echo -e "${BLUE}[i]${NC} $1"; }

safe_copy() {
  local src="$1"
  local dst="$2"
  if [ "$DRY_RUN" = true ]; then
    echo "    would copy: $(basename "$src") -> $dst"
  else
    cp "$src" "$dst"
  fi
}

safe_copy_dir() {
  local src="$1"
  local dst="$2"
  if [ "$DRY_RUN" = true ]; then
    echo "    would copy dir: $(basename "$src")/ -> $dst"
  else
    cp -r "$src" "$dst"
  fi
}

echo ""
echo "================================================================"
echo "  Claude Code Configuration Installer"
echo "================================================================"
echo ""

if [ "$DRY_RUN" = true ]; then
  warn "DRY RUN — no files will be modified"
  echo ""
fi

# ──────────────────────────────────────────────
# Pre-flight checks
# ──────────────────────────────────────────────

if [ ! -d "$SCRIPT_DIR/global" ]; then
  echo "ERROR: global/ directory not found. Run from the repo root."
  exit 1
fi

# ──────────────────────────────────────────────
# Backup existing config
# ──────────────────────────────────────────────

if [ -d "$CLAUDE_DIR" ] && [ "$DRY_RUN" = false ]; then
  BACKUP_DIR="$CLAUDE_DIR/backup-$(date +%Y%m%d-%H%M%S)"
  warn "Backing up existing config to $BACKUP_DIR"
  mkdir -p "$BACKUP_DIR"
  [ -f "$CLAUDE_DIR/CLAUDE.md" ] && cp "$CLAUDE_DIR/CLAUDE.md" "$BACKUP_DIR/"
  [ -f "$CLAUDE_DIR/settings.json" ] && cp "$CLAUDE_DIR/settings.json" "$BACKUP_DIR/"
  [ -d "$CLAUDE_DIR/rules" ] && cp -r "$CLAUDE_DIR/rules" "$BACKUP_DIR/"
fi

# ──────────────────────────────────────────────
# Global Installation
# ──────────────────────────────────────────────

if [ "$INSTALL_GLOBAL" = true ]; then
  log "Installing global Claude Code configuration..."
  echo ""

  # CLAUDE.md
  info "CLAUDE.md (global instructions)"
  safe_copy "$SCRIPT_DIR/global/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"

  # Rules
  info "Rules (7 auto-loaded rule files)"
  mkdir -p "$CLAUDE_DIR/rules"
  for f in "$SCRIPT_DIR/global/rules/"*.md; do
    safe_copy "$f" "$CLAUDE_DIR/rules/$(basename "$f")"
  done

  # Commands
  info "Commands (19 slash commands)"
  mkdir -p "$CLAUDE_DIR/commands"
  for f in "$SCRIPT_DIR/global/commands/"*.md; do
    safe_copy "$f" "$CLAUDE_DIR/commands/$(basename "$f")"
  done

  # Skills
  info "Skills (26 auto-triggered skills)"
  mkdir -p "$CLAUDE_DIR/skills"
  for d in "$SCRIPT_DIR/global/skills/"/*/; do
    SKILL_NAME=$(basename "$d")
    mkdir -p "$CLAUDE_DIR/skills/$SKILL_NAME"
    for f in "$d"*; do
      safe_copy "$f" "$CLAUDE_DIR/skills/$SKILL_NAME/$(basename "$f")"
    done
  done

  # Hook scripts
  info "Hook scripts (5 scripts)"
  mkdir -p "$CLAUDE_DIR/hooks"
  for f in "$SCRIPT_DIR/global/hooks/"*.sh; do
    safe_copy "$f" "$CLAUDE_DIR/hooks/$(basename "$f")"
    [ "$DRY_RUN" = false ] && chmod +x "$CLAUDE_DIR/hooks/$(basename "$f")"
  done

  # Statusline
  if [ -f "$SCRIPT_DIR/global/statusline-command.sh" ]; then
    info "Statusline script"
    safe_copy "$SCRIPT_DIR/global/statusline-command.sh" "$CLAUDE_DIR/statusline-command.sh"
    [ "$DRY_RUN" = false ] && chmod +x "$CLAUDE_DIR/statusline-command.sh"
  fi

  # Settings.json — merge carefully
  if [ -f "$CLAUDE_DIR/settings.json" ]; then
    warn "settings.json already exists — NOT overwriting (manual merge recommended)"
    info "Reference: $SCRIPT_DIR/global/settings.json"
  else
    info "settings.json (permissions, hooks, plugins)"
    safe_copy "$SCRIPT_DIR/global/settings.json" "$CLAUDE_DIR/settings.json"
  fi

  echo ""
  log "Global installation complete!"
fi

# ──────────────────────────────────────────────
# Torvaldsen Installation
# ──────────────────────────────────────────────

if [ "$INSTALL_TORVALDSEN" = true ]; then
  echo ""
  log "Installing Torvaldsen workflow..."
  echo ""

  # Torvaldsen rules (holding directory — NOT auto-loaded)
  info "Torvaldsen rules (3 files → ~/.claude/torvaldsen/rules/)"
  mkdir -p "$CLAUDE_DIR/torvaldsen/rules"
  for f in "$SCRIPT_DIR/torvaldsen/rules/"*.md; do
    safe_copy "$f" "$CLAUDE_DIR/torvaldsen/rules/$(basename "$f")"
  done

  # Torvaldsen templates
  info "Templates (12 artifact blueprints + 5 project rules)"
  mkdir -p "$CLAUDE_DIR/torvaldsen/templates/project-rules"
  for f in "$SCRIPT_DIR/torvaldsen/templates/"*.md "$SCRIPT_DIR/torvaldsen/templates/"*.json; do
    [ -f "$f" ] && safe_copy "$f" "$CLAUDE_DIR/torvaldsen/templates/$(basename "$f")"
  done
  for f in "$SCRIPT_DIR/torvaldsen/templates/project-rules/"*.md; do
    [ -f "$f" ] && safe_copy "$f" "$CLAUDE_DIR/torvaldsen/templates/project-rules/$(basename "$f")"
  done

  echo ""
  log "Torvaldsen installation complete!"
fi

# ──────────────────────────────────────────────
# Summary
# ──────────────────────────────────────────────

echo ""
echo "================================================================"
echo "  Installation Summary"
echo "================================================================"
echo ""

if [ "$INSTALL_GLOBAL" = true ]; then
  echo "  Global Config:"
  echo "    CLAUDE.md          → ~/.claude/CLAUDE.md"
  echo "    7 rules            → ~/.claude/rules/"
  echo "    19 commands        → ~/.claude/commands/"
  echo "    26 skills          → ~/.claude/skills/"
  echo "    5 hook scripts     → ~/.claude/hooks/"
  echo "    settings.json      → ~/.claude/settings.json"
  echo ""
fi

if [ "$INSTALL_TORVALDSEN" = true ]; then
  echo "  Torvaldsen Workflow:"
  echo "    3 rules            → ~/.claude/torvaldsen/rules/"
  echo "    12+5 templates     → ~/.claude/torvaldsen/templates/"
  echo ""
  echo "  Note: Torvaldsen rules are NOT auto-loaded globally."
  echo "  Run /brainstorm in a project to install them per-project."
  echo ""
fi

if [ "$DRY_RUN" = false ]; then
  echo "  Restart Claude Code to pick up the new configuration."
fi
echo ""
echo "================================================================"
