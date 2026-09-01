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

## The manual (`docs/`)

An Astro + Starlight project (`@astrojs/starlight`, with the
`@astrojs/starlight-markdoc` preset so `.mdoc` pages can use Markdoc tags).
Served at **https://marginal.md/docs/** — `base: '/docs'` in
`docs/astro.config.mjs` prefixes every link, so the build output is copied
to `_site/docs/` by the workflow, not to the artifact root.

- Pages: `docs/src/content/docs/**/*.md`, `title:` frontmatter required.
  Plain `.md` gets GFM, task lists, footnotes, `> [!TIP]` alerts and `:::tip`
  asides; only `.mdoc` pages get Starlight's tabs/steps/cards tags, and
  `.mdoc` loses task lists (Markdoc has none). Marginal itself only opens
  `md|markdown|mdown`, so prefer `.md`.
- Sidebar groups are `autogenerate`d from directories in
  `docs/astro.config.mjs` (Starlight ≥ 0.39 shape:
  `{ label, items: [{ autogenerate: { directory } }] }`).
- Palette: `docs/src/styles/custom.css` maps Starlight's `--sl-color-*`
  variables to the tokens in `assets/site.css`; change both together.
- **This repo is the source of truth for user-facing documentation**
  (decided 2026-09-01). The two reference pages were seeded from the app
  repo's `docs/KEYBINDINGS.md` and `THEMES.md`, which were then deleted
  there; the app repo's `docs/` holds developer docs only, and its
  `README.md` / `CLAUDE.md` link here. When the app's behaviour changes
  (shortcuts, settings, themes, menus) the page here is what gets updated;
  `~/marginal/docs/THEME_ADDONS.md` §8 remains the schema contract the
  Themes page is derived from.
- `/docs/` is **outside** the password gate on the root `index.html`; the
  manual is public the moment it deploys.

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
  gate the push on those checks with `&&`. For the manual,
  `pnpm --dir docs build` must pass, and `pnpm --dir docs preview` serves
  `docs/dist/` at `http://localhost:4321/docs/` with the base applied
  (Astro 7's preview daemonizes — stop it with `pnpm --dir docs exec astro
  preview stop`).
- Deploy: `.github/workflows/deploy.yml` on push to `main` — builds
  `docs/`, rsyncs the root pages plus `docs/dist/` → `_site/docs/`, and
  publishes with `actions/deploy-pages`. Settings ▸ Pages ▸ Source must be
  **GitHub Actions** (`gh api -X PUT repos/zebra-rs/marginal.github.io/pages
  -f build_type=workflow`); in the old branch mode the workflow builds but
  nothing it produces is served.
- `assets/og.png` regenerates from `assets/og-source.svg` via
  `rsvg-convert -w 1200 -h 630`; favicons from `assets/marginal-icon.svg`.
- Push (SSH agent has no identities):
  `git push "https://x-access-token:$(env -u GH_TOKEN gh auth token)@github.com/zebra-rs/marginal.github.io.git" main`
  — redact the token if output is echoed.
