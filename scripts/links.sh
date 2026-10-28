#!/bin/bash
# Create or check the symlinks from each AI tool into this repo.
#
#   scripts/links.sh install   create missing links; never overwrite real files
#   scripts/links.sh check     report links that are missing, broken, or wrong
#
# Exit code of "check" is 0 when everything is correct, 1 otherwise.

REPO="$HOME/ai-config"

# Folders where each tool looks for skills.
SKILL_DIRS="$HOME/.copilot/skills $HOME/.codex/skills $HOME/.claude/skills"

# Instruction files that should all point at AGENTS.md in this repo.
INSTRUCTION_LINKS="
$HOME/.codex/AGENTS.md
$HOME/.claude/CLAUDE.md
$HOME/.copilot/copilot-instructions.md
"

mode="$1"
problems=0

# link_one TARGET LINK_PATH
# TARGET is the file or folder in this repo. LINK_PATH is where the tool looks.
link_one() {
  target="$1"
  link="$2"

  if [ -L "$link" ]; then
    current="$(readlink "$link")"
    if [ "$current" = "$target" ]; then
      echo "ok       $link"
    else
      echo "WRONG    $link -> $current (expected $target)"
      problems=1
    fi
  elif [ -e "$link" ]; then
    echo "BLOCKED  $link exists and is not a symlink; move or delete it yourself"
    problems=1
  elif [ "$mode" = "install" ]; then
    mkdir -p "$(dirname "$link")"
    ln -s "$target" "$link"
    echo "created  $link -> $target"
  else
    echo "MISSING  $link"
    problems=1
  fi
}

if [ "$mode" != "install" ] && [ "$mode" != "check" ]; then
  echo "usage: scripts/links.sh install|check"
  exit 2
fi

# One symlink per skill, so each tool's own skills (such as .system) stay untouched.
for dir in $SKILL_DIRS; do
  for skill in "$REPO"/skills/*; do
    link_one "$skill" "$dir/$(basename "$skill")"
  done
done

for file in $INSTRUCTION_LINKS; do
  link_one "$REPO/AGENTS.md" "$file"
done

# Links that point into the repo but whose skill was removed.
for dir in $SKILL_DIRS; do
  for link in "$dir"/*; do
    if [ -L "$link" ] && [ ! -e "$link" ]; then
      echo "BROKEN   $link (target no longer exists)"
      problems=1
    fi
  done
done

exit $problems
