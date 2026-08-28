# CLAUDE.md

The Marginal marketing site — GitHub Pages at **https://marginal.md**
(CNAME in-repo; apex A/AAAA → GitHub Pages; repo `zebra-rs/marginal.github.io`).
`README.md` describes the layout; this file is working context for Claude.

## What is authoritative

The product truth lives in the **sibling checkouts**, not here:

- `~/backend` — the license server. `design/BACKEND.md` §8 (decided: (B)) and
  `design/IMPLEMENTATION_PLAN.md` Step 21 govern what this site may claim.
- `~/marginal` — the desktop app (Rust + Tauri 2). Feature claims must match
  its `IMPLEMENTATION_PLAN.md`; theme palettes come from
  `crates/marginal-core/src/theme/builtins/*.json` (ten themes, five
  palettes × light/dark).

Claims that must stay true on every page:

- Pricing: **$10/mo or $96/yr**, one plan, 14-day trial, **no card**.
- A lapsed subscription = **read-only, never locked files** (reading,
  preview, PDF export, and saving already-modified buffers keep working).
- AI = the customer's **own Anthropic key**, stored in the OS keychain,
  **never a license gate**.
- No invented artifacts, sizes, package managers, or signing claims.
  Windows is *not* Authenticode-signed; macOS is notarized by `release.yml`.

## Download links are intentionally dead-ended

`zebra-rs/marginal` is **private** with **no tags/releases**; its
`release.yml` drafts a GitHub release on a `v*` tag. Until a release (or a
public mirror) exists, `download.html` says "being prepared" and links
nothing. Wire real URLs when the first release ships.

## Workflow

- Copy/fact changes: edit `index.html` / `download.html` directly (plain
  HTML/CSS + small inline JS; shared styles in `assets/site.css`).
- Visual redesign: happens in Claude Design; the canvas export lives in
  `design/` (`*.dc.html` + `support.js` + `_ds/`); re-bake the static pages
  by hand from it, carrying the fact fixes forward — the canvas may lag.
  The claude.ai/design **"Marginal" design-system project** (tokens +
  `guidelines/brand.md`) is reachable via `/design-login` + DesignSync.
- Test params: `?theme=light|dark` forces a theme, `?noanim=1` renders the
  finished state (typing demo + reveals off) — use for screenshots.
- Verify before pushing: `./run.sh` (or `python3 -m http.server 8090`),
  headless Chrome screenshots, and check every local `href`/`src` resolves;
  gate the push on those checks with `&&`.
- `assets/og.png` regenerates from `assets/og-source.svg` via
  `rsvg-convert -w 1200 -h 630`; favicons from `assets/marginal-icon.svg`.
- Push (SSH agent has no identities):
  `git push "https://x-access-token:$(env -u GH_TOKEN gh auth token)@github.com/zebra-rs/marginal.github.io.git" main`
  — redact the token if output is echoed.
