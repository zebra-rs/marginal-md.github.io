---
title: Codex
description: Where OpenAI's Codex CLI reads AGENTS.md, skills, custom agents, rules, and prompts, and what Marginal lists for it.
sidebar: { order: 3 }
---

[Codex](https://developers.openai.com/codex/) is OpenAI's coding agent. Its
instructions are `AGENTS.md` files; skills follow the open `.agents/skills`
convention; custom agents and execution rules live in `.codex` folders.

Select it in **Settings ▸ AI ▸ Coding agent**.

## What Marginal lists

| Section | In the workspace | In your home folder |
|---|---|---|
| **AGENTS.md** | `AGENTS.override.md` and `AGENTS.md`, in the root and in any subfolder | `~/.codex/AGENTS.override.md`, `~/.codex/AGENTS.md` |
| **RULES** | `.codex/rules/*.rules`, in the root and in any subfolder | `~/.codex/rules/*.rules` |
| **SKILLS** | `.agents/skills/*/SKILL.md` and `.codex/skills/*/SKILL.md`, in the root and in any subfolder | `~/.agents/skills/*/SKILL.md`, `~/.codex/skills/*/SKILL.md` |
| **AGENTS** | `.codex/agents/**/*.toml`, in the root and in any subfolder | `~/.codex/agents/**/*.toml` |
| **COMMANDS** | — | `~/.codex/prompts/*.md` |

`CODEX_HOME`, when set in the environment Marginal was launched from,
replaces `~/.codex`. It does not move `~/.agents/skills`, which Codex keys
on your home directory.

Custom agents are named by the `name = "…"` in the TOML file and show its
`description`. Prompts appear as `/name`.

## How Codex uses these files

- **AGENTS.md** is read in every directory from the project root down to
  the directory Codex was started in, one file per directory:
  `AGENTS.override.md` wins over `AGENTS.md` where both exist. The global
  file in `~/.codex` comes first, then the project's files from the root
  down, all concatenated under a 32 KiB budget (`project_doc_max_bytes`).
  Codex stops at the current directory, so an `AGENTS.md` deeper down is
  used only when Codex runs from there; the documentation suggests a line
  in the root file pointing at it.
- **Skills** are folders with a `SKILL.md` whose front matter gives `name`
  and `description`. `.agents/skills` is the documented place, checked in
  every directory from the current one up to the project root; `.codex/skills`
  and `~/.codex/skills` are the older locations, still read. `/etc/codex/skills`
  holds administrator skills. A skill is invoked as `/name`.
- **Custom agents** (sub-agents) are TOML files with `name`, `description`,
  and `developer_instructions`, plus any `config.toml` key such as `model`
  or `sandbox_mode`. The `name` field, not the file name, identifies the
  agent; it can override the built-in `default`, `worker`, and `explorer`.
- **Rules** here are execution policy, not prompts: Starlark files that say
  which commands may run without approval (`prefix_rule(...)`). Codex writes
  `~/.codex/rules/default.rules` when you approve a command and choose to
  remember it. The documentation marks rules as experimental.
- **Custom prompts** in `~/.codex/prompts` are markdown files invoked as
  `/prompts:name`. They are deprecated in favour of skills, and recent
  versions may no longer load them; Marginal lists them so nothing is lost.

Project `.codex` folders are trust-gated: in a project you have not marked
trusted, Codex ignores their config, rules, hooks, and agents. Marginal
lists them regardless.

## Not listed

`.codex/config.toml` and `~/.codex/config.toml`, `hooks.json`, memories,
plugins and marketplaces, and the system paths `/etc/codex` and
`%ProgramData%\OpenAI\Codex`.

Checked against the Codex documentation and source on 1 September 2026.
