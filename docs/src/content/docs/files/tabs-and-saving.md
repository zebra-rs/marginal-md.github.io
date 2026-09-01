---
title: Tabs, saving, and autosave
description: Working with several documents, saving them, and letting Marginal save for you.
sidebar: { order: 2 }
---

## Tabs

Every open document is a tab in the strip above the editor. A dot on the tab
and in the window title means the document has unsaved changes.

- **Open** a file by clicking it in the file list, with **File ▸ Open…**
  (<kbd>⌘O</kbd>), or from **File ▸ Open Recent**.
- **Start** a new document with **+** in the tab strip or <kbd>⌘N</kbd>.
- **Reorder** tabs by dragging them.
- **Close** a tab with its **×**, <kbd>⌘W</kbd>, or a middle click.

Each tab keeps its own undo history and folding, so switching back and forth
loses nothing.

## Saving

**File ▸ Save** (<kbd>⌘S</kbd>) writes the document to disk and flashes
*Saved* in the status bar. **Save As…** (<kbd>⌘⇧S</kbd>) writes it under a
new name; a new document is suggested as `Untitled.md` in the folder
selected in the sidebar.

Closing a tab with unsaved changes asks what to do: **Save**, **Don't
Save**, or **Cancel**. Quitting with several unsaved documents offers
**Save All**.

## Autosave

Turn on **Settings ▸ General ▸ Saving ▸ Autosave** and Marginal saves a
document a moment after you stop typing. The delay is adjustable, from half
a second to ten seconds. The status bar shows *Autosave on* or *Autosave
off* at its right edge, and flashes *Autosaved* each time it saves.

Autosave only applies to documents that already have a file. A new,
untitled document is not written anywhere until you save it yourself.

## When a file changes on disk

Marginal watches your files. If the document you are editing is changed by
something else, a dialog offers to **Keep Editing** or **Reload From Disk**.
If you have unsaved edits, it says so, since reloading discards them. If the
file is deleted, the status bar reports *File was deleted on disk*, and
saving recreates it.

Marginal ignores its own saves, so autosave never triggers the dialog.
