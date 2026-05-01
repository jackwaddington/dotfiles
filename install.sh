#!/bin/bash
# Run this on any new machine after cloning the repo.
# Creates necessary directories and symlinks dotfiles into place.

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

echo "Installing dotfiles from $DOTFILES"

# Claude Code commands
mkdir -p ~/.claude/commands
for file in "$DOTFILES/claude/commands/"*.md; do
  name=$(basename "$file")
  target="$HOME/.claude/commands/$name"
  if [ -L "$target" ]; then
    echo "  skip (already linked): $target"
  else
    ln -s "$file" "$target"
    echo "  linked: $target"
  fi
done

echo "Done."
