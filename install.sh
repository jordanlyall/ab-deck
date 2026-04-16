#!/bin/bash
# ab-deck installer
# Symlinks this repo into ~/.claude/skills/ so the skill is discoverable by Claude Code.
# Usage: ./install.sh

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$HOME/.claude/skills"
TARGET="$SKILLS_DIR/ab-deck"

mkdir -p "$SKILLS_DIR"

if [ -L "$TARGET" ]; then
  echo "ab-deck already symlinked. Re-linking to $REPO_DIR"
  rm "$TARGET"
elif [ -d "$TARGET" ]; then
  echo "WARNING: $TARGET exists and is not a symlink."
  echo "Back it up before re-running:"
  echo "  mv $TARGET ${TARGET}.bak"
  exit 1
fi

ln -s "$REPO_DIR" "$TARGET"
chmod +x "$REPO_DIR/build.sh"

echo "Installed: $TARGET → $REPO_DIR"
echo ""
echo "Test: in Claude Code, ask 'use ab-deck to make a sample deck'"
echo "Or render an example manually:"
echo "  cat $REPO_DIR/examples/art-tank-pitch.md"
