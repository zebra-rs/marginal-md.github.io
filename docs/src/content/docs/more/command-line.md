---
title: Command line
description: Open files and folders, the reading view, and a one-off appearance from a terminal.
sidebar: { order: 2 }
---

```
Usage: marginal [OPTIONS] [FILE|FOLDER]...

Arguments:
  [FILE|FOLDER]...  Markdown files to open; a folder opens as the workspace.
                    Windows/Linux: a lone file opens as a reader preview
                    (like a double-click; Esc exits, Settings ▸ General
                    disables)

Options:
      --reader <FILE>                   Preview-only window for FILE (no
                                        sidebar, tabs, or toolbar; Esc exits)
      --appearance <system|light|dark>  Appearance for this launch only; the
                                        saved setting is untouched
      --timing                          Append this launch's startup phases
                                        to startup-timing.log in the config
                                        directory
  -h, --help                            Print this help and exit
```

## Finding the executable

On macOS the executable is inside the app bundle. An alias makes it handy:

```sh
alias marginal='/Applications/Marginal.app/Contents/MacOS/marginal'
```

On Windows and Linux the installer puts `marginal` where the system finds
it.

## Notes

- Paths are relative to the current directory. Paths that do not exist are
  ignored, as are unknown options.
- A single file opens the editor on macOS and the
  [reading view](../../writing/reading-view/) on Windows and Linux, where a
  terminal launch is indistinguishable from a double-click.
- If Marginal is already running, the arguments are handed to the running
  copy, which comes to the front.
- `--appearance` is for this launch only. Picking an appearance in
  **Settings ▸ Appearance** ends the override.
- `--timing` is a diagnostic. It appends the launch's startup phases to
  `startup-timing.log` in the [config directory](../platforms/#where-marginal-keeps-its-files).
