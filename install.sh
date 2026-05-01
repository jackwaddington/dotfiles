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

# Scripts (copied to ~/bin, not symlinked, so they work standalone)
mkdir -p ~/bin
for file in "$DOTFILES/scripts/"*.sh; do
  name=$(basename "$file")
  target="$HOME/bin/$name"
  if [ -f "$target" ]; then
    echo "  skip (already exists): $target"
  else
    cp "$file" "$target"
    chmod +x "$target"
    echo "  installed: $target"
  fi
done

echo ""
echo "Add ~/bin to your PATH if not already there:"
echo "  export PATH=\"\$HOME/bin:\$PATH\""
echo ""
echo "Done."
