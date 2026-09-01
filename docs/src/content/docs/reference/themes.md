---
title: Themes
sidebar: { order: 2 }
description: Installing and writing themes.
---

> **Status:** the add-on framework described here shipped 2026-08-26 (P1).
> Everything below works except **Install Theme…** and `.marginaltheme`
> double-click packages, which are planned.

Marginal ships with ten built-in themes — five light/dark pairs (Marginal,
GitHub, Solarized, Zenburn, Dracula). You pick one theme per *slot* in
**Settings ▸ Appearance**: the **Light theme** is used in light appearance,
the **Dark theme** in dark appearance, and "System" follows your OS. This
guide is about adding your own themes beyond the built-ins.

A theme controls the whole app in one file: window chrome (sidebar, toolbar,
panels), the editor (colors, cursor, selection, markdown syntax tints), the
preview (text, links, headings, tables, code blocks), mermaid diagrams, and
what Print/PDF/HTML export looks like (exports always use your light-slot
theme, so a light theme doubles as your "paper" style).

---

## Installing a theme

1. Open **Settings (⌘, / Alt+,) ▸ Appearance** and click **Open Themes
   Folder**. This opens (and creates, on first use) the folder where add-on
   themes live:

   | OS | Folder |
   |---|---|
   | macOS | `~/Library/Application Support/md.marginal/themes/` |
   | Windows | `%APPDATA%\md.marginal\themes\` |
   | Linux | `~/.config/md.marginal/themes/` |

2. Copy the theme in — either a folder like `nightlily/` containing a
   `theme.json`, or a bare `some-theme.json` file.

3. Click **Reload Themes** (or just reopen Settings — it rescans on open).
   The theme appears in the Light or Dark dropdown under an **Add-ons**
   heading, depending on its `appearance`.

4. Select it. Done — no restart needed.

If a theme does **not** appear, Settings shows a "theme files failed to
load" notice listing the file and the reason (see Troubleshooting below).
Nothing is ever skipped silently.

**Uninstalling**: delete the theme's folder/file and Reload Themes. If the
removed theme was selected, that slot falls back to the built-in default
(Marginal Light / Marginal Dark) automatically.

**Sharing**: a theme *is* its folder — zip it, send it, the other person
drops it in their themes folder. (A double-clickable `.marginaltheme`
package is planned; the unzipped folder is always the installed form.)

---

## Making your own theme

### The package

A theme is a folder in the themes directory:

```
themes/
  nightlily/
    theme.json        # required — everything below lives here
    syntax.tmTheme    # optional — custom code-block colors (TextMate format)
```

If you don't need a custom `.tmTheme`, a single `nightlily.json` file
directly in `themes/` works too. The folder name doesn't matter; the theme's
identity is the `id` inside `theme.json`.

### theme.json — the minimum

Five fields are required; everything else is optional and gets sensible
defaults derived from these:

```json
{
  "id": "nightlily",
  "name": "Night Lily",
  "appearance": "dark",
  "palette": {
    "bg": "#211d24",        "fg": "#e6e1ea",      "muted": "#9a92a5",
    "chromeBg": "#2a2530",  "border": "#3d3646",
    "hoverBg": "rgb(255 255 255 / 0.05)",
    "activeBg": "rgb(255 255 255 / 0.09)",
    "accent": "#c792ea",    "accentFg": "#211d24",
    "selectionBg": "#44395c",
    "error": "#ef6b73",     "warning": "#d19a66",  "success": "#98c379"
  },
  "syntect": "base16-ocean.dark"
}
```

- `id` — lowercase kebab-case, unique, and stable: it's what your settings
  remember. Don't reuse a built-in id (`marginal-*`, `github-*`,
  `solarized-*`, `zenburn-*` are taken).
- `name` — what the dropdown shows.
- `appearance` — `"light"` or `"dark"`; decides which slot dropdown lists
  the theme and pairs it with the matching preview base style.
- `palette` — the 13 chrome colors, **all required**:

  | Token | Where you see it |
  |---|---|
  | `bg` / `fg` | page background / primary text |
  | `muted` | secondary text — captions, file details, placeholders |
  | `chromeBg` | toolbar, sidebar, file list, panels, dialogs |
  | `border` | 1px hairlines between panes and around controls |
  | `hoverBg` | wash behind hovered buttons/rows (translucent works best) |
  | `activeBg` | wash behind pressed/selected controls |
  | `accent` | primary buttons, links, focus rings, the unsaved-changes dot |
  | `accentFg` | text on top of `accent` |
  | `selectionBg` | text selection |
  | `error` / `warning` / `success` | status colors |

- `syntect` — the code-block color scheme. Either one of the bundled names —
  `"InspiredGitHub"`, `"Solarized (light)"`, `"Solarized (dark)"`,
  `"base16-ocean.light"`, `"base16-ocean.dark"`, `"base16-eighties.dark"`,
  `"base16-mocha.dark"`, `"dracula"` — or exactly `"./syntax.tmTheme"` to
  use the TextMate theme file sitting next to your `theme.json`. (Any editor theme
  exported as `.tmTheme` works — a huge ecosystem to borrow from.)

That minimal theme is already complete: editor colors are derived from the
code scheme, markdown tints and preview colors from the palette.

### Optional: overrides

Add an `"overrides"` object when the derived look isn't enough:

```json
"overrides": {
  "editor":  { "bg": "#211d24", "fg": "#e6e1ea", "selection": "#44395c",
               "cursor": "#c792ea", "activeLine": "rgb(255 255 255 / 0.04)",
               "gutterFg": "#5f5769" },
  "syntax":  { "heading": "#c792ea", "heading-weight": "600",
               "heading1-size": "1.9em", "heading2-size": "1.4em",
               "heading3-size": "1.15em", "heading4-size": "1.07em",
               "link": "#82aaff", "punctuation": "#7f88a6", "tag": "#82aaff",
               "frontmatter-key": "#e0af68", "frontmatter-value": "#9ece6a" },
  "preview": { "link": "#82aaff", "headingFg": "#c792ea",
               "border": "#3d3646", "blockquoteBorder": "#82aaff",
               "blockquoteFg": "#9a92a5", "codeBg": "#2a2530",
               "inlineCodeBg": "#332d3a",
               "tableStripe": "rgb(255 255 255 / 0.04)" },
  "mermaid": { "primaryColor": "#2a2530", "primaryTextColor": "#e6e1ea" }
}
```

- **`editor`** — the editing pane's chrome when you don't want the code
  scheme's own: `bg` `fg` `gutterFg` `activeLine` `selection` `cursor`.
- **`syntax`** — tints for *markdown as you type* (and they win over the
  code scheme's projection). Useful keys: `heading` (all levels),
  `heading1`…`heading6` (per level), `heading-weight`,
  `heading1-size`…`heading4-size` (em values scale editor headings; the
  built-ins run 1.9 / 1.4 / 1.15 / 1.07em), `link`,
  `punctuation` (the `#`/`-`/fence marks), `tag`, plus code-token colors
  like `keyword`, `string`, `comment`, `function`, `number`. YAML
  frontmatter has its own pair, `frontmatter-key` and `frontmatter-value`,
  for the block at the top of a document: unset, keys take the heading
  colour and values read as ordinary body text, so they already tell apart
  in every theme; set either to choose your own. The block is sized at
  `heading4-size`, so it sits just above body text in a theme that scales
  headings and matches it in one that doesn't. A key is a line's leading
  `name:`
  (indented ones too, so nested maps colour as keys); list items, block
  scalars and the wrapped continuation lines of a long value count as
  value text.
- **`preview`** — the rendered pane: `link`, `headingFg`, `heading1Fg` (H1
  only, layered over `headingFg`), `border` (h1/h2 underlines, hr, table
  borders), `blockquoteBorder`, `blockquoteFg`, `codeBg` (fenced blocks),
  `inlineCodeBg`, `tableStripe`.
- **`mermaid`** — diagram theme variables passed straight to mermaid (e.g.
  `primaryColor`, `lineColor`); the special key `"theme": "default"` or
  `"dark"` pins a stock mermaid look instead. **No alpha colors here** —
  mermaid's color math can't handle `rgb(… / 0.5)`.

### Value rules

- Colors: hex (`#rrggbb`, with alpha `#rrggbbaa`), `rgb(…)` /
  `rgb(r g b / a)`, `hsl(…)`, or CSS named colors. Max 64 characters.
- For safety, values may only contain letters, digits, and `# % ( ) , . / -`
  plus spaces. Anything else — `;`, braces, quotes, `<`, `>` — rejects the
  whole theme (you'll see it in the diagnostics list with the field name).
- Limits: `theme.json` ≤ 64 KB, `.tmTheme` ≤ 1 MB, up to 100 add-on themes.
- Optional `"schema": 1` field: leave it out or set 1; a future format bump
  will use it so old apps skip themes they can't render rather than
  mangling them.

### Iterating

1. Edit `theme.json`, save.
2. Settings ▸ **Reload Themes** — changes apply immediately, including to
   the open document.
3. Check both panes (editor + preview), a document with code blocks, tables,
   a blockquote, and a mermaid diagram; then Print (⌘P/Alt+P) to see the
   export look if your theme is in the light slot. `docs/QA.md`'s fixtures
   (`DEMO.md`) exercise everything at once.
4. Tip for dark themes: also check **Force light preview** users — your dark
   theme's editor will sit beside the light-slot preview, so its `accent`
   and `selectionBg` should hold up next to a white pane.

---

## Troubleshooting

| Symptom | Likely cause |
|---|---|
| Theme not in the dropdown | Wrong folder; or it failed to load — check the diagnostics notice in Settings |
| "id collides with a built-in" | Rename your `id` (built-in prefixes are reserved) |
| "value rejected" naming a field | The value uses a forbidden character or is over 64 chars — see Value rules |
| Theme listed under the wrong dropdown | `appearance` says the other mode |
| Code blocks ignore my colors | `syntect` names a stock theme instead of `"./syntax.tmTheme"`, or the sidecar failed to parse (diagnostics will say) |
| Mermaid diagrams look off | Alpha color in `overrides.mermaid`, or pin `"theme": "dark"` instead of variables |
| Everything fell back to Marginal defaults | The selected theme was removed or failed to load — reinstall or reselect |

For the engineering design behind all of this (loading rules, security
model, phasing), see **docs/THEME_ADDONS.md**.
