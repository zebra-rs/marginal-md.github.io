# Marginal manual

The user manual for [Marginal](https://marginal.md), built with
[Astro](https://astro.build) and [Starlight](https://starlight.astro.build)
and served at **https://marginal.md/docs/**. This repo is the source of
truth for user-facing documentation; the app repo links here.

## Viewing it locally

```sh
pnpm --dir docs install    # once
pnpm --dir docs dev        # then open http://127.0.0.1:4321/docs/
```

The dev server reloads as you edit. It runs in the background as a daemon;
to stop or restart it:

```sh
pnpm --dir docs exec astro dev stop
pnpm --dir docs dev
```

To see exactly what GitHub Pages will serve, build and preview instead:

```sh
pnpm --dir docs build      # static output in docs/dist/
pnpm --dir docs preview    # serves dist/ at http://127.0.0.1:4321/docs/
pnpm --dir docs exec astro preview stop
```

## Writing pages

Pages live in `src/content/docs/`, one folder per sidebar group:

| Folder | Sidebar group |
|---|---|
| `start/` | Start here |
| `agents/` | Coding agents — one page per agent, mirroring `crates/marginal-core/src/workspace/agents.rs` in the app repo |
| `files/` | Files |
| `writing/` | Writing |
| `ai/` | AI |
| `output/` | Output |
| `more/` | More |
| `reference/` | Reference |

The groups themselves are defined in `astro.config.mjs`; the pages inside a
group are picked up automatically. Every page starts with frontmatter:

```md
---
title: The editor
description: One sentence, shown in search results and link previews.
sidebar: { order: 1 }
---
```

`order` sets the position within the group. Link to other pages with
relative URLs ending in a slash, for example `../../ai/setup/`, and to a
section with `#its-heading-id`.

Plain `.md` is the default and supports GitHub-flavored Markdown, task
lists, footnotes, `> [!TIP]`-style alerts, and Starlight's `:::tip` /
`:::note` / `:::caution` asides. Use `<kbd>⌘K</kbd>` for keys. Write
shortcuts the macOS way; the landing page tells readers that ⌘ means Alt on
Windows and Linux.

A page that shows a screenshot is `.mdx`, so it can import the component:

```mdx
import Shot from '../../../components/Shot.astro';

<Shot name="editor-split" alt="What the picture shows" caption="Optional caption." />
```

`name` is a file in `src/assets/shots/` without the extension; the
component shows `editor-split.png` in the light theme and
`editor-split-dark.png` in the dark one, and Astro resizes both.

## Screenshots

Screenshots are taken automatically from the real app, on macOS:

```sh
docs/shots/shoot.sh          # both appearances, every scene (~4 minutes)
docs/shots/shoot.sh light    # one appearance
```

Quit Marginal first. The script backs up and restores your config
directory, so your own window size, recent files, and settings survive.
`shots/README.md` explains how it works and how to add a scene; the scenes
are the `scenes_*` functions in `shots/shoot.sh`.

## Before pushing

```sh
pnpm --dir docs build
```

must pass. The deploy workflow runs the same build, so a page that breaks
it never reaches the site. Check any link you added by opening it in the
preview.

## Deploying

`.github/workflows/deploy.yml` at the repo root builds the manual on every
push to `main` and publishes it, together with the hand-baked marketing
pages, through GitHub Pages. Nothing else is needed; the manual is live a
minute or two after the push.
