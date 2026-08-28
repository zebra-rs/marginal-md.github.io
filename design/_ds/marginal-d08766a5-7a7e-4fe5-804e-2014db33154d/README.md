# Marginal — design conventions

Marginal is a native markdown editor (Rust + Tauri) for macOS, Windows, and Linux. This project carries its **design tokens and brand rules only — there is no component library**. Build UI from generic components and style them with the tokens below; do not invent component names from this system.

## Styling idiom: CSS custom properties

All color rides `var(--*)` custom properties defined in `tokens/marginal.css` (imported by `styles.css`). Light is the default; the dark values apply under `:root[data-theme="dark"]` or OS dark mode. Color with the tokens, never hard-coded hex:

| Token | Role |
|---|---|
| `--bg` / `--fg` | app background / primary text |
| `--muted` | secondary text, captions, placeholders |
| `--chrome-bg` | toolbars, sidebars, panels, dialogs |
| `--border` | hairline borders and dividers (1px) |
| `--hover-bg` / `--active-bg` | interactive state washes (translucent — layer over any surface) |
| `--accent` / `--accent-fg` | primary buttons, links, focus rings; text on accent |
| `--selection-bg` | text selection |
| `--error` / `--warning` / `--success` | status text and indicators |

## Type

- UI text: `-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", sans-serif`, 13px base.
- Code and editor surfaces: `ui-monospace, "SF Mono", SFMono-Regular, Menlo, Consolas, "Liberation Mono", monospace`.
- No webfonts — Marginal uses system fonts everywhere.

## Tone

Quiet, content-first chrome: `--chrome-bg` panels separated by 1px `--border` hairlines, small type, no shadows-heavy or rounded-card styling. The accent appears sparingly — primary actions, links, focus — never as large fills.

## Where the truth lives

Read `styles.css` and `tokens/marginal.css` before styling anything; brand identity (icon, marketing palette) is in `guidelines/brand.md`.

## Example

```html
<div style="background: var(--chrome-bg); border: 1px solid var(--border); padding: 12px; display: flex; gap: 8px; align-items: center">
  <span style="color: var(--muted)">3 files changed</span>
  <button style="background: var(--accent); color: var(--accent-fg); border: none; border-radius: 6px; padding: 6px 14px">Save</button>
</div>
```

---

## Project contents

- `styles.css` — styles entry point (imports the tokens)
- `tokens/marginal.css` — Marginal Light + Marginal Dark token definitions
- `guidelines/brand.md` — icon, marketing palette, themes, voice

Synced from the Marginal repo (`crates/marginal-core/src/theme/builtins/`) — tokens-only, no components.
