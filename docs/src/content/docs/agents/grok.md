---
title: Grok Build
description: Where xAI's Grok Build reads its instruction files, rules, skills, sub-agents, and commands, and what Marginal lists for it.
sidebar: { order: 4 }
---

[Grok Build](https://docs.x.ai/build/) is xAI's terminal coding agent, the
`grok` command. It reads the same instruction files as Claude Code and
Codex, keeps its own files in `.grok` folders, and reads Claude Code's and
Cursor's folders for compatibility.

Select it in **Settings ▸ AI ▸ Coding agent**.

## What Marginal lists

| Section | In the workspace | In your home folder |
|---|---|---|
| **AGENTS.md** | `AGENTS.md`, `AGENT.md`, `Agents.md`, `CLAUDE.md`, `Claude.md`, and `CLAUDE.local.md` (badged *local*), in the root and in any subfolder | `~/.grok/AGENTS.md`, `~/.grok/CLAUDE.md` |
| **RULES** | `.grok/rules/**/*.md`, `.claude/rules/**/*.md`, `.cursor/rules/**/*.md` and `*.mdc`, in the root and in any subfolder | `~/.grok/rules`, `~/.claude/rules`, `~/.cursor/rules` |
| **SKILLS** | `.grok/skills/*/SKILL.md` and `.agents/skills/*/SKILL.md` in the root and in any subfolder; `.claude/skills` and `.cursor/skills` at the root | `~/.grok/skills`, `~/.agents/skills`, `~/.claude/skills`, `~/.cursor/skills` |
| **AGENTS** | `.grok/agents/*.md` | `~/.grok/agents/*.md` |
| **COMMANDS** | `.grok/commands/*.md`, `.claude/commands/*.md` | `~/.grok/commands/*.md`, `~/.claude/commands/*.md` |

`GROK_HOME`, when set in the environment Marginal was launched from,
replaces `~/.grok`.

There is no `GROK.md`. Grok Build does not read one, and Marginal does not
look for it.

## How Grok Build uses these files

- **Instruction files** are read in every directory from the git root down
  to the current one, checking the names above in that order. A file in a
  subfolder scopes to its subtree; deeper files win. Files ignored by git
  are skipped. `--rules` appends to them and `--system-prompt-override`
  replaces them. Whether `~/.grok/AGENTS.md` itself is read is not stated
  outright in the documentation, which speaks of "global rules in
  `~/.grok`"; Marginal lists it when it exists. `grok inspect` prints what
  Grok actually loaded.
- **Rules** are markdown files in a `rules` folder, one folder per
  directory on the same chain. The Claude Code and Cursor folders are read
  when the `[compat.claude].rules` and `[compat.cursor].rules` settings are
  on, which they are by default.
- **Skills** follow the `SKILL.md` convention with `name`, `description`,
  and options such as `when-to-use`, `paths`, and `user-invocable`. A
  user-invocable skill is a slash command; there is no separate command
  system. The flat `*.md` files in a `commands` folder are the legacy form,
  documented only in the bundled user guide.
- **Sub-agents** in `.grok/agents` are markdown with `name`, `description`,
  `tools`, and `permissionMode` in the front matter; the body is the system
  prompt. Personas, TOML overlays in `.grok/personas`, are a separate
  mechanism and are not listed.

Project rules, skills, and hooks in a folder are honoured only after you
trust the folder (`/hooks-trust` or `--trust`).

## Not listed

`.grok/config.toml` and `~/.grok/config.toml`, `hooks/*.json`, personas,
workflows (`.rhai`), plugins, memory under `~/.grok/memory`, and the managed
`managed_config.toml` and `requirements.toml`.

The community `grok-cli` project by superagent-ai is a different program
with a different layout (`AGENTS.md`, `.agents/skills`, settings in
`user-settings.json`); this page and the setting describe xAI's Grok Build.

Checked against the Grok Build documentation and user guide on 1 September 2026.
