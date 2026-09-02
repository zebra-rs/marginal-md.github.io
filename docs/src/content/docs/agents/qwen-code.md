---
title: Qwen Code
description: Where Qwen Code reads QWEN.md, skills, sub-agents, and commands, and what Marginal lists for it.
sidebar: { order: 7 }
---

[Qwen Code](https://qwenlm.github.io/qwen-code-docs/) is Alibaba's terminal
coding agent. Its context file is `QWEN.md`, with `AGENTS.md` as a second
name, and its skills, sub-agents, and commands live in `.qwen` folders.

Select it in **Settings ▸ AI ▸ Coding agent**.

## What Marginal lists

| Section | In the workspace | In your home folder |
|---|---|---|
| **QWEN.md** | `QWEN.md` and `AGENTS.md`, in the root and in any subfolder; `.qwen/QWEN.local.md` at the root, badged *local* | `~/.qwen/QWEN.md`, `~/.qwen/AGENTS.md` |
| **SKILLS** | `.qwen/skills/*/SKILL.md`, `.agents/skills/*/SKILL.md` | `~/.qwen/skills`, `~/.agents/skills` |
| **AGENTS** | `.qwen/agents/*.md` | `~/.qwen/agents/*.md` |
| **COMMANDS** | `.qwen/commands/**/*.md` and `*.toml` | `~/.qwen/commands/**/*.md` and `*.toml` |

Qwen Code has no rules folder, so there is no **RULES** section.

`QWEN_HOME`, when set in the environment Marginal was launched from,
replaces `~/.qwen`. It does not move `~/.agents/skills`, which Qwen Code
keys on your home directory.

Commands in a subfolder are namespaced with a colon, the way Qwen Code
names them: `git/commit.md` is `/git:commit`.

## How Qwen Code uses these files

- **QWEN.md** is read from your home folder, then from every directory
  from the current one up through the project root, root first. The names
  it looks for come from the `context.fileName` setting, `QWEN.md` and
  `AGENTS.md` by default; setting it replaces the list, so a setting of
  `AGENTS.md` alone drops `QWEN.md`. `.qwen/QWEN.local.md` at the git root
  is the per-machine file, read only in a trusted folder. `@path` lines
  import other files, up to five levels deep. There is no `.qwen/QWEN.md`;
  Qwen Code does not read one, and Marginal does not look for it. Nothing is
  scanned downward into subfolders, so a nested `QWEN.md` applies when Qwen
  Code runs from that folder.
- **Skills** are `SKILL.md` folders with a required `name` and
  `description`, one level deep, found at the git root in `.qwen/skills`
  and `.agents/skills`. Each skill is also a `/name` command. Archived and
  pending skills in `.qwen/archived-skills` and `.qwen/pending-skills` are
  not loaded and not listed.
- **Sub-agents** in `.qwen/agents` are markdown with a front matter `name`,
  `description`, `model`, `approvalMode`, `tools`, and more; the body is
  the system prompt. Claude Code's `permissionMode` values are accepted as
  aliases. Project beats user on a name clash.
- **Commands** are markdown with an optional `description`,
  `argument-hint`, and `when_to_use` in the front matter, and `{{args}}` in
  the body. TOML commands with a `prompt` key are the older form: still
  loaded, with a prompt to migrate them.

Skills and sub-agents are found from the git root; commands and settings
from the directory Qwen Code was started in.

## Not listed

`.qwen/settings.json` and `~/.qwen/settings.json` (including hooks and MCP
servers defined there), `.qwen/.env`, `.qwenignore`, extensions under
`~/.qwen/extensions`, agent plugins, memory under `~/.qwen/projects`, and
the system settings under `/Library/Application Support/QwenCode`,
`/etc/qwen-code`, or `C:\ProgramData\qwen-code`.

Checked against the Qwen Code documentation and source on 1 September 2026.
