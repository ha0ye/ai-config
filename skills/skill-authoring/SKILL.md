---
name: skill-authoring
description: Create, convert, or review an agent skill (a SKILL.md file). Use when the user wants to turn a system prompt, process document, or repeated workflow into a skill, write a new skill, merge overlapping skills, or check an existing skill for trigger quality, structure, and portability. Do not use for running or editing the content of a skill the user already considers finished.
---

# Overview

Help me write skills that trigger correctly, are easy to review, and work in more than one agent. A skill is one folder with a `SKILL.md` file. Optional supporting files sit beside it.

Work in the mode I give you. If I give none, propose the skill outline and the description first, get my agreement once, then write the file.

## Choose the right form first

Before you write, decide if a skill is the right form. State the reason in one line.

- **Skill:** a repeatable workflow with a clear trigger, used in some sessions but not all.
- **Standing instruction:** a preference that applies to every session (tone, formatting, writing style). Put it in the user's global instructions, not in a skill.
- **Reference file:** large static material (templates, design tokens, schemas). Put it in the skill folder and link to it from `SKILL.md`. Load it only when needed.
- **Merge:** if the new skill overlaps an existing one by more than about half, extend the existing skill or split out the shared part. Do not create near-duplicates.

## Conversion workflow (prompt or process doc to skill)

1. **Inventory.** List the source files. Mark which ones overlap.
2. **Separate three kinds of content** in each source:
   - *Workflow:* steps, commands, output formats. Keep.
   - *Context:* facts about one project, audience, or organization. Remove from the skill and ask for it at run time, or move it to its own skill that loads only on request.
   - *Environment assumptions:* named tools, uploaded files, preview panes, product-specific commands. Remove or replace with neutral wording.
3. **Resolve conflicts** between versions. Use the newer one only if I confirm it is newer. Ask when you cannot tell.
4. **Write the description** (next section) before the body.
5. **Write the body** to the structure below.
6. **Check** with the checklist at the end. Report what you checked and what you did not.

## The description

The description decides when the skill loads. Write it for a reader who sees only this field.

- State what the skill does, then when to use it, with the words a user would actually say (including command names such as `/summary`).
- State when **not** to use it, and name the skill to use instead.
- Keep it to a few sentences. Do not summarize the whole body.
- Do not put secrets, paths, or project-specific names in it unless the skill is project-specific.
- Test it: write three requests that should trigger the skill and three near-misses that should not. Check the description separates them.

## Frontmatter

- Use exactly two fields: `name` and `description`. Other fields can break other agents.
- `name` equals the folder name. Use lowercase letters, digits, and hyphens.
- Use a short prefix to group related skills (for example `curriculum-`), and use it consistently.

## Body structure

Use these parts, in this order. Omit a part only if it does not apply.

1. **Overview:** the role and the outcome, in a few sentences.
2. **Inputs to collect:** what to ask for at the start, and what is acceptable as "unknown". Never invent values the user did not give.
3. **Workflow:** numbered steps. Mark the steps that need user approval.
4. **Output format:** exact structure for each output, with length limits.
5. **Delegation:** one line. Say if parts may go to a subagent and which parts must stay with the main agent. Delegate when the work reads far more than it returns, when items are independent, or when a fresh reviewer is needed. Do not delegate when the step needs user approval or one consistent voice.
6. **Before you finish:** a short checklist of what must be true when the skill ends. Include the list of files or records touched.

## Style rules

- Use short, direct sentences and plain words (ASD-STE100 for technical text).
- Say what to do, not what to avoid, unless the avoided action is a real risk.
- Use neutral wording for tools: "delegate to a subagent if your agent supports it, otherwise do it inline". Do not name tools, models, or slash-command syntax, except command names that are part of the skill's own interface.
- Give one example when a format is hard to describe in words. Do not give more.
- Keep the body under about 300 lines. Move long tables, templates, and reference material to separate files in the skill folder.
- Do not duplicate content that another skill owns. Link to it by name.

## Interface commands

If the skill defines commands (for example `/summary`), define each with its purpose, format, and length limit. State that a command runs immediately, with no clarifying turn, if that is the intent.

## Checklist

Run this before you finish. Report each item as pass, fail, or not checked.

- [ ] Folder name equals `name`; frontmatter has only `name` and `description`.
- [ ] Description says what, when, and when not (with the alternative skill).
- [ ] Three should-trigger and three should-not-trigger requests are separated by the description.
- [ ] No project-specific context baked in; it is collected at run time or kept in a separate skill.
- [ ] No references to files, uploads, or tools that the skill does not bundle.
- [ ] Every sentence is complete (no cut-off text from the source).
- [ ] Output formats have exact structure and length limits.
- [ ] Delegation line and "Before you finish" section are present.
- [ ] No overlap with an existing skill that should have been merged.
- [ ] The skill was read once as a user would run it, and no step depends on missing information.

## Before you finish

- State the skill's path and the sources it came from.
- List what you removed from the sources and why (context, environment assumptions, duplicates).
- List open decisions that need my judgment.
- Report the checklist results. Do not claim you ran the skill unless you did.
