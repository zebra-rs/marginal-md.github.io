---
title: Claude Code
description: Where Claude Code reads CLAUDE.md, rules, skills, sub-agents, and commands, and what Marginal lists for it.
sidebar: { order: 2 }
---

[Claude Code](https://code.claude.com/docs/) is Anthropic's coding agent and
Marginal's default. Its context lives in `CLAUDE.md` files and a `.claude`
folder, in the project and in your home directory.

Select it in **Settings ▸ General ▸ Coding agent**.

## What Marginal lists

| Section | In the workspace | In your home folder |
|---|---|---|
| **CLAUDE.md** | `CLAUDE.md` in the root and in any subfolder; `CLAUDE.local.md` beside it, badged *local*; `.claude/CLAUDE.md` | `~/.claude/CLAUDE.md` |
| **RULES** | `.claude/rules/**/*.md` | `~/.claude/rules/**/*.md` |
| **SKILLS** | `.claude/skills/*/SKILL.md` | `~/.claude/skills/*/SKILL.md` |
| **AGENTS** | `.claude/agents/*.md` | `~/.claude/agents/*.md` |
| **COMMANDS** | `.claude/commands/**/*.md` | `~/.claude/commands/**/*.md` |

`CLAUDE_CONFIG_DIR`, when set in the environment Marginal was launched from,
replaces `~/.claude` as the home-folder location.

Skills and sub-agents are named by the `name:` in their front matter, and
show its `description:` as their second line. Rules keep their file name;
commands appear as `/name`, with a subfolder in front as `/folder/name`.

## How Claude Code uses these files

- **CLAUDE.md** is loaded at the start of a session in this order: the
  managed file, `~/.claude/CLAUDE.md`, then the project's files from the
  outermost parent down, each followed by its `CLAUDE.local.md`. A
  `CLAUDE.md` in a subfolder is loaded on demand, when Claude reads a file
  there. `@path` lines import other files, up to four hops deep.
- **Rules** in `.claude/rules` are markdown with an optional `paths:` list
  of globs in the front matter. A rule without `paths:` is loaded at the
  start; one with `paths:` is loaded when a matching file is read.
  Subfolders and symlinks are followed.
- **Skills** are folders holding a `SKILL.md` plus any supporting files.
  The front matter gives the `name`, `description`, and whether the skill
  can be invoked by you (`/name`), by Claude, or both. Custom commands in
  `.claude/commands` are the older form of the same thing: still read, one
  `/name` per file, but new work belongs in skills.
- **Sub-agents** in `.claude/agents` are markdown with a front matter
  `name`, `description`, and options such as `tools`, `model`, and
  `memory`; the body is the sub-agent's system prompt.

The project-level files take precedence over the ones in your home folder
when a name clashes.

## Not listed

`.claude/settings.json`, `settings.local.json`, and `~/.claude/settings.json`
(including the hooks defined there), `.mcp.json`, output styles, workflows,
worktrees, plugins, the auto-memory folder under `~/.claude/projects`, and
the managed paths under `/Library/Application Support/ClaudeCode`,
`/etc/claude-code`, or `C:\Program Files\ClaudeCode`.

Checked against the Claude Code documentation on 1 September 2026.
