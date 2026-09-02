---
title: Cursor
description: Where Cursor reads rules, AGENTS.md, skills, subagents, and commands, and what Marginal lists for it.
sidebar: { order: 6 }
---

[Cursor](https://cursor.com/docs) is an AI code editor with a terminal
agent, `cursor-agent`, that reads the same files. Its rules are `.mdc`
files in `.cursor/rules`; it also reads `AGENTS.md`, `CLAUDE.md`, and
several other agents' skill and sub-agent folders.

Select it in **Settings ▸ General ▸ Coding agent**.

## What Marginal lists

| Section | In the workspace | In your home folder |
|---|---|---|
| **AGENTS.md** | `AGENTS.md` and `CLAUDE.md`, in the root and in any subfolder; the legacy `.cursorrules` at the root | — |
| **RULES** | `.cursor/rules/**/*.mdc`, in the root and in any subfolder | `~/.cursor/rules/**/*.mdc` |
| **SKILLS** | `.agents/skills/*/SKILL.md` and `.cursor/skills/*/SKILL.md` in the root and in any subfolder; `.claude/skills` and `.codex/skills` at the root | `~/.agents/skills`, `~/.cursor/skills`, `~/.claude/skills`, `~/.codex/skills` |
| **AGENTS** | `.cursor/agents/*.md`, `.claude/agents/*.md`, `.codex/agents/*.md` or `*.toml` | `~/.cursor/agents`, `~/.claude/agents`, `~/.codex/agents` |
| **COMMANDS** | `.cursor/commands/*.md` | `~/.cursor/commands/*.md` |

Cursor has no environment variable that moves `~/.cursor`, and no
instruction file in the home folder: user rules are kept in Cursor's
settings and synced with your account, not on disk.

Only `.mdc` files count as rules. A plain `.md` in `.cursor/rules` is
ignored by Cursor, so Marginal does not list it there. Rules keep their file
name, with the folder in front for nested ones: `packages/api/api.mdc`.

## How Cursor uses these files

- **Rules** are `.mdc` files with a front matter `description`, `globs`,
  and `alwaysApply`. A rule is applied always, when its description fits,
  when a file matching its globs is in play, or only when you mention it.
  Rules folders inside subfolders are discovered everywhere, matching the
  editor and the CLI. Team rules from the dashboard rank above project
  rules, which rank above user rules.
- **AGENTS.md** in a subfolder is combined with the ones above it, the more
  specific winning. `CLAUDE.md` at the root is read the same way and is
  always applied. `.cursorrules` is legacy and will be deprecated; the
  documentation suggests moving its text into an always-apply rule.
- **Skills** are `SKILL.md` folders with `name` and `description`, invoked
  with `/`. `.agents/skills` is checked first, then `.cursor/skills`; the
  Claude Code and Codex folders are read for compatibility. A skill folder
  may sit one level down inside a category folder.
- **Subagents** are markdown with a front matter `name`, `description`,
  `model`, `readonly`, and `is_background`. `.cursor` wins over `.claude`
  and `.codex` on a name clash, and project over user.
- **Commands** are one markdown file per command, the file name being the
  command, the body the prompt. Cursor is steering commands into skills;
  `/migrate-to-skills` converts them.

The `.claude` and `.codex` folders may depend on Cursor's "Include
third-party plugins, skills, and other configs" setting.

## Not listed

`.cursor/hooks.json`, `.cursor/mcp.json`, `.cursor/permissions.json`,
`.cursor/sandbox.json`, `.cursor/worktrees.json`, `.cursor/environment.json`,
`.cursorignore` and `.cursorindexingignore`, `.cursor/cli.json`,
`~/.cursor/cli-config.json`, plugins, and the enterprise hooks under
`/Library/Application Support/Cursor`, `/etc/cursor`, or `C:\ProgramData\Cursor`.

Checked against the Cursor documentation on 1 September 2026.
