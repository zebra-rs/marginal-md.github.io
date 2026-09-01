---
title: macOS, Windows, and Linux
description: Where the three platforms differ, and where Marginal keeps its files on each.
sidebar: { order: 5 }
---

Marginal is the same app on all three platforms, with a few differences
that follow each platform's conventions.

## Shortcuts

App shortcuts use <kbd>⌘</kbd> on macOS and <kbd>Alt</kbd> on Windows and
Linux, so that Ctrl stays free for editing there: <kbd>Ctrl+P</kbd>,
<kbd>Ctrl+N</kbd>, <kbd>Ctrl+B</kbd>, <kbd>Ctrl+E</kbd>, <kbd>Ctrl+K</kbd>,
<kbd>Ctrl+D</kbd>, and <kbd>Ctrl+H</kbd> move and delete the Emacs way on
every platform, while <kbd>Ctrl+A</kbd> and <kbd>Ctrl+F</kbd> stay Select
All and Find. The [Keybindings](../../reference/keybindings/) page has the
full picture.

On Windows and Linux the **Edit** menu items carry no shortcuts, for the
same reason, and Linux has no **Window** menu, since window management
belongs to the desktop there.

## Opening files

A double-click on a `.md` file opens the [reading view](../../writing/reading-view/)
everywhere. On Windows and Linux, `marginal FILE.md` from a terminal does
the same, because the app cannot tell the two apart; on macOS the command
line opens the editor.

## Other differences

| | macOS | Windows | Linux |
|---|---|---|---|
| Window background | Optional blur and opacity in Settings ▸ Appearance | — | — |
| Full screen | View ▸ Enter Full Screen | — | — |
| Terminal shell | Your `$SHELL`, as a login shell | PowerShell, then Windows PowerShell, then the command prompt | Your `$SHELL` |
| Direct PDF export | Native print operation | WebView2 | WebKitGTK |
| Print window | Closes after the dialog | Print… / Close buttons, Esc closes | Same as Windows |
| Key storage | Keychain | Credential Manager | Secret Service |
| Code signing | Signed and notarized | Not signed; SmartScreen warns once | Not signed |

## Where Marginal keeps its files

| | Config directory |
|---|---|
| macOS | `~/Library/Application Support/md.marginal/` |
| Windows | `%APPDATA%\md.marginal\` |
| Linux | `~/.config/md.marginal/` |

It holds `settings.json`, the `themes` folder for
[add-on themes](../../reference/themes/), and `startup-timing.log` if you
have used `--timing`. Your API key and sign-in tokens are not there; they
are in the system's key store.
