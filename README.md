# ai-config

A single source folder my personal AI-tool setup. This repo contains shared skills and one general instruction file. Separate AI tools are configured with symlinks to the contents here.

## Contents

| Path | Purpose |
|---|---|
| `AGENTS.md` | General system prompt (working preferences). Source of truth. |
| `skills/` | One folder per skill, each with a `SKILL.md`. |
| `scripts/links.sh` | Creates and checks the symlinks. |

Skills:

- `thought-partner` — general thinking partner for talks, presentations, projects.
- `curriculum-ideation` — lesson and slide-beat drafting. It asks for the curriculum context at the start.
- `skill-authoring` — converts prompts into skills and reviews skills.

## Where the links go

| Tool | Skills | Instructions |
|---|---|---|
| Copilot CLI | `~/.copilot/skills/<skill>` | `~/.copilot/copilot-instructions.md` |
| Codex | `~/.codex/skills/<skill>` | `~/.codex/AGENTS.md` |
| Claude Code | `~/.claude/skills/<skill>` | `~/.claude/CLAUDE.md` |

Each skill gets its own link. The tools' own skills, such as `~/.codex/skills/.system`, are not touched.

## Install on a new machine

```bash
git clone <your-remote-url> ~/ai-config
~/ai-config/scripts/links.sh install
```

The script creates missing links only. It never overwrites a real file. If it reports `BLOCKED`, a real file or folder is in the way. Compare it with the repo version, then move or delete it, and run `install` again.

The script assumes the repo is at `~/ai-config`. If you clone it elsewhere, change `REPO` at the top of the script.

## Check for drift

```bash
~/ai-config/scripts/links.sh check
```

| Status | Meaning | Fix |
|---|---|---|
| `ok` | Link is correct. | None. |
| `MISSING` | No link. | Run `install`. |
| `WRONG` | Link points somewhere else. | Delete the link, run `install`. |
| `BLOCKED` | A real file is there. A tool or editor may have replaced the link. | Merge any changes into the repo, delete the file, run `install`. |
| `BROKEN` | Link points to a skill that no longer exists. | Delete the link. |

The script exits with 0 when all links are correct, and 1 otherwise.

Some tools rewrite a symlinked file as a regular file when they edit it. After you let a tool edit an instruction file, run `check`. `git status` in this repo shows content changes. `BLOCKED` shows replaced links.

## Add or change a skill

1. Create `skills/<name>/SKILL.md`. The folder name must equal `name` in the frontmatter. Use only `name` and `description` there.
2. Run `scripts/links.sh install` to link the new skill into every tool.
3. Commit.

To remove a skill, delete its folder and its three links, then run `check`.

Use the `skill-authoring` skill to convert a prompt into a skill or to review one.

## Edit the instructions

Edit `AGENTS.md` in this repo. All three tools read the same file. Keep tool-specific rules out of it. If a tool needs its own rules, give that tool its own file and remove its link.

## Git

```bash
cd ~/ai-config
git init
git add .
git commit -m "Initial ai-config"
```

## Known limits

- Copilot CLI reads `~/.copilot/copilot-instructions.md` and also instruction files in each project (`AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md`). They add to the global file. A rule repeated in a project file applies twice. Run `/instructions` in the CLI to see what loaded.
- The Codex and Claude skill folders support the `SKILL.md` format, but I have not tested these skills in those tools.
- Skills with other fields in the frontmatter may not load in every tool. Keep to `name` and `description`.
