---
title: Keybindings
sidebar: { order: 1 }
description: App shortcuts, the Default, Emacs, and Vim keymap schemes, and custom shortcuts.
---

Marginal has two independent layers of shortcuts:

- **App shortcuts** — menus and windows (open, save, print, view modes, AI).
  Always ⌘ on macOS and **Alt** on Windows/Linux, so Ctrl stays free for
  editing there.
- **Editor keys** — what the keys do inside the text pane. These follow the
  **keymap scheme** you choose in **Settings ▸ Editor ▸ Keybindings**:
  **Default**, **Emacs**, or **Vim**.

The scheme is stored per machine, so choosing Emacs on one computer does not
change another. When a scheme other than Default is active the status bar
shows it: an `EMACS` chip, or the current Vim mode (`NORMAL`, `INSERT`,
`VISUAL`, `V-LINE`, `V-BLOCK`). If that chip is missing, the scheme is not on.

---

## App shortcuts

`Mod` below is **⌘ on macOS**, **Alt on Windows/Linux**.

| Action | Key |
|---|---|
| New document | `Mod+N` |
| Open file… | `Mod+O` |
| Open folder… | `Mod+Shift+O` |
| Save / Save As… | `Mod+S` / `Mod+Shift+S` |
| Close tab | `Mod+W` |
| Print… | `Mod+P` |
| Go to file… | `Mod+T` |
| Command palette | `Mod+T`, then type a command name |
| Editor / Split / Preview | `Mod+1` / `Mod+2` / `Mod+3` |
| Toggle sidebar | `Mod+Shift+E` |
| Filter files (sidebar file list) | `Mod+Shift+F` |
| Toggle terminal | `Mod+J` |
| Zoom in / out / reset | `Mod+=` / `Mod+-` / `Mod+0` |
| AI: edit selection… | `Mod+K` |
| AI: ask about selection… | `Mod+Shift+K` |
| Settings… | `Mod+,` |

Fold and unfold commands (Fold All, Fold Level 2–4, Unfold All) have no
default key — reach them from the View menu or the palette, or give them one
under [Custom shortcuts](#custom-shortcuts).

---

## Default scheme

Standard platform editing: `Mod+Z` / `Mod+Y` undo and redo, `Mod+A` select
all, `Mod+F` find, `Mod+D` select next occurrence, Tab to indent, and the
usual arrow/word/line motion.

On top of that, the basic Emacs motions are available on **Ctrl** on every
platform. macOS provides them itself in any text view; Windows and Linux get
them from Marginal, limited to the keys CodeMirror leaves free:

| Key | Action | macOS | Windows/Linux |
|---|---|---|---|
| `Ctrl+P` / `Ctrl+N` | previous / next line | ✓ | ✓ |
| `Ctrl+B` / `Ctrl+F` | back / forward character | ✓ | `Ctrl+B` only¹ |
| `Ctrl+A` / `Ctrl+E` | line start / line end | ✓ | `Ctrl+E` only¹ |
| `Ctrl+D` / `Ctrl+H` | delete forward / backward | ✓ | ✓ |
| `Ctrl+K` | kill to end of line | ✓ | ✓ |
| `Ctrl+O`, `Ctrl+T`, `Ctrl+V` | open line, transpose, page down | ✓ | — |

¹ On Windows and Linux `Ctrl+A` stays **Select All** and `Ctrl+F` stays
**Find**, since those are the platform conventions. Choose the Emacs scheme
if you want them as Emacs keys.

---

## Emacs scheme

Everything from Default, plus a real Emacs layer: a mark and region, a kill
ring independent of the system clipboard, the `C-x` prefix, and Meta (⌥ / Alt)
commands.

**Motion** — `C-f` `C-b` `C-n` `C-p` character/line, `M-f` `M-b` by word,
`C-a` `C-e` line ends, `M-<` `M->` buffer ends (`S-M-,` / `S-M-.`),
`C-v` / `M-v` page down/up, `M-g` goto line, `C-l` recenter.

**Mark and region** — `C-Space` set mark, `C-x C-x` exchange point and mark,
`M-@` mark word, `M-h` select paragraph, `Esc` clear the mark. With a mark
set, every motion extends the selection instead of moving.

**Kill ring** — `C-w` kill region, `M-w` copy region, `C-k` kill line,
`M-d` kill word forward, `M-Backspace` kill word backward, `C-y` yank,
`M-y` yank-pop (cycle the ring). `S-Delete` also yanks.

**`C-x` prefix** — `C-x u` undo, `C-x h` select all, `C-x C-x` exchange
point and mark, `C-x C-u` / `C-x C-l` upcase / downcase region,
`C-x r` rectangular region.

**Search** — `C-s` / `C-r` open the find panel and search forward or
backward from the cursor. The first match is selected as you type; inside
the panel, `C-s` steps to the next match and `C-r` to the previous one,
and `C-g` closes the panel with the match still selected and the cursor
on it (Escape does the same). So `C-s readme C-s C-s C-g` leaves you on
the third "readme" after the cursor.

**Other** — `C-g` cancel, `C-u` universal argument (repeat count),
`C-/` or `C-z` undo, `C-t` transpose characters, `M-u` / `M-l` change
case, `M-;` toggle comment, `M-/` completion, `M-x` command line.

Two platform details:

- **Windows/Linux**: `Ctrl+X` and `Ctrl+C` cut and copy **when text is
  selected**, and act as Emacs keys otherwise — so the platform clipboard
  habits keep working alongside the `C-x` prefix. Paste stays `Ctrl+V`.
- **macOS**: `⌃X` becomes the Emacs prefix in this scheme (it is otherwise
  reserved so it cannot shadow-invoke Cut).

---

## Vim scheme

A full modal editor: Normal, Insert, Visual and Visual-Block modes, motions,
operators, text objects, counts, registers, marks, macros (`q`), `.` repeat,
`/` and `?` search (forward and backward, `n` / `N` for the next and
previous match, Escape cancels the prompt) wired into the editor's own
search, and an ex line (`:`) with `:s`, ranges and `:noh`.

- `:w` saves the document (it runs Marginal's Save, so it works on untitled
  documents too).
- The status bar shows the current mode; the cursor is a block in Normal
  mode and a bar in Insert mode, in your theme's cursor colour.
- Not supported: Vim plugins, window splits, and anything requiring a Vim
  runtime — this is Vim keybindings, not embedded Vim.

---

## Custom shortcuts

**Settings ▸ Editor ▸ Custom shortcuts** binds any chord to any command:
click the field, press the shortcut, pick the command, then **Add**.

- Custom shortcuts work **anywhere in the window**, not just the editor, and
  take precedence over the keymap scheme.
- A chord needs a real modifier (or an F-key); a bare letter is refused
  because it would shadow typing and Vim motions.
- Shortcuts the app's menus already own (`⌘K`, `⌘S`, `⌘T`, … / `Alt+K`,
  `Alt+S`, …) are consumed by the menu before they reach the field, so they
  cannot be recorded.

Bindable targets are every palette command plus these editor commands:
Undo, Redo, Delete Line, Move Line Up/Down, Duplicate Line, Select Line,
Select All, Select Next Occurrence, Expand Selection (Syntax), Simplify
Selection, Go to Start/End of Document, Go to Matching Bracket, Transpose
Characters, Find in Document.

---

## When a key does nothing

1. **Check the scheme.** No `EMACS` chip or Vim mode in the status bar means
   the scheme is not active on *this* machine — the setting does not sync
   between computers.
2. **The command may need a precondition.** `C-x u` needs something in the
   undo history; `C-w` needs a region; `C-x C-x` and `C-y` need a mark or a
   previous kill.
3. **Another program may own the key.** Input-method switchers, launchers,
   virtualisation software and clipboard managers all take chords before any
   app sees them — check the OS shortcut settings and whatever runs in your
   menu bar or tray.
4. **Input methods intercept keys.** With a CJK input method active, `⌃Space`
   is usually the input-source switch, and the *second* key of a prefix chord
   such as `C-x u` goes to composition instead of the editor. Switching the
   input source to direct/ASCII input makes those chords work; this is a
   limitation of how input methods handle keys before the application, not
   something the editor can intercept.
