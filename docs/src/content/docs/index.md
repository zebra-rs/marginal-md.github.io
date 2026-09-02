---
title: Marginal manual
description: How to use Marginal, the markdown editor for your coding agent's files.
---

Marginal is a native markdown editor for macOS, Windows, and Linux. One Rust
markdown engine drives the editor, the preview, PDF export, and the context
handed to the AI. Your files stay plain markdown on disk.

## Made for your coding agent

The files that steer a coding agent are markdown: `CLAUDE.md`, `AGENTS.md`,
rules, skills, sub-agents, commands. Marginal finds them where **your** agent
looks for them and lists them beside your notes, so you edit the agent's
instructions with the same preview, AI help, and export as everything else.

Pick the agent in **Settings ▸ AI ▸ Coding agent**. Claude Code is the
default; Codex, Grok Build, OpenCode, Cursor, and Qwen Code are the others,
and each has a page here that lists every folder it reads:

| Agent | Instruction file | Manual page |
|---|---|---|
| Claude Code | `CLAUDE.md` | [Claude Code](agents/claude-code/) |
| Codex | `AGENTS.md` | [Codex](agents/codex/) |
| Grok Build | `AGENTS.md` | [Grok Build](agents/grok/) |
| OpenCode | `AGENTS.md` | [OpenCode](agents/opencode/) |
| Cursor | `AGENTS.md`, `.cursor/rules` | [Cursor](agents/cursor/) |
| Qwen Code | `QWEN.md` | [Qwen Code](agents/qwen-code/) |

Start with [Your coding agent](agents/overview/).

## Where to start

- New to Marginal? [Install it](start/install/), then take
  [a tour of the window](start/tour/).
- Working with a coding agent? Read [Your coding agent](agents/overview/)
  and the page for yours.
- Want the AI features? [Connect your Anthropic key](ai/setup/), then read
  about [editing with AI](ai/editing/).
- Looking something up? The [Settings](reference/settings/),
  [Keybindings](reference/keybindings/), and [Themes](reference/themes/)
  pages list everything.

## A note on shortcuts

Shortcuts in this manual are written the macOS way, with <kbd>⌘</kbd>. On
Windows and Linux the same shortcuts use <kbd>Alt</kbd> instead, so
<kbd>⌘K</kbd> is <kbd>Alt+K</kbd>. Ctrl is left to the editor there. The
screenshots are from macOS.

Looking for the app itself? See [marginal.md](https://marginal.md/).
