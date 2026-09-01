# Screenshots for the manual

`shoot.sh` takes the manual's screenshots from the real app, automatically,
on macOS:

```sh
docs/shots/shoot.sh          # light and dark, every scene
docs/shots/shoot.sh light    # one appearance
```

It launches `/Applications/Marginal.app` on the `fixture/` workspace (a few
sample notes, so no private files appear), sets the window to 1280 × 800,
reaches each scene with keystrokes through System Events, and captures the
window with `screencapture -l`. Output lands in `../src/assets/shots/` as
Retina PNGs: `<scene>.png` for light, `<scene>-dark.png` for dark.

Before it starts it backs up `~/Library/Application Support/md.marginal/`,
and it restores that backup when it finishes, so your own window size,
recent files, workspace and settings survive. Quit Marginal first — it is
single-instance, so a running copy would be reused instead of launched.

The terminal running the script needs **Screen Recording** and
**Accessibility** permission (System Settings ▸ Privacy & Security).

## Adding a scene

Scenes live in `shoot.sh` under `scenes_workspace` (the normal window) and
`scenes_reader` (the `--reader` window). Reach the state with `key`, `menu`
or `type_text`, then call `shot <name>`; keep names stable, the manual
references them by file name. Menu titles can be listed with:

```sh
osascript -e 'tell application "System Events" to tell process "Marginal" to get name of every menu item of menu "View" of menu bar 1'
```

## Using a shot in a page

Astro optimises images under `src/assets/`. Show the matching theme with
Starlight's utility classes:

```html
<img src="../../assets/shots/editor-split.png" alt="…" class="dark:sl-hidden" />
<img src="../../assets/shots/editor-split-dark.png" alt="…" class="light:sl-hidden" />
```

(`.md` pages can use plain `![…](../../assets/shots/editor-split.png)` for a
single image.)
