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
- AI = the customer's **own API key** (Anthropic, OpenAI, Google, xAI, or
  Alibaba Cloud; see the manual's *Connect an API key*), stored in the OS
  keychain, **never a license gate**.
- No invented artifacts, sizes, package managers, or signing claims.
  Windows is *not* Authenticode-signed; macOS is notarized by `release.yml`.

## Download links

Builds are public releases on **`zebra-rs/marginal-releases`** (the app
source stays private). `download.html` detects the visitor's OS and
architecture, asks the GitHub API for the latest release at page load
(the site's one external request; the API allows any origin, 60 requests
an hour per IP), and points each file link at the matching asset by name
pattern (`_universal.dmg`, `-setup.exe`, `.msi`, `_amd64`/`_aarch64`
AppImage, `_amd64`/`_arm64` deb, `.x86_64`/`.aarch64` rpm). Without JS,
or if the request fails, every link falls back to the releases page, and
an "All releases on GitHub" button is always shown. If asset names change
on the release side, the patterns in `download.html` must follow.

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
- **Coding agents** (`docs/src/content/docs/agents/`, the group right after
  *Start here* — deliberately prominent, it is the feature) is one overview
  plus one page per agent (Claude Code, Codex, Grok Build, OpenCode,
  Cursor, Qwen Code). Each page's "What Marginal lists" table mirrors, row
  for row, that agent's `AgentSpec` in the app repo
  (`crates/marginal-core/src/workspace/agents.rs`, `CATALOG`); a change on
  either side is a change on both. The "How X uses these files" notes and
  the "Not listed" lists came from each agent's official docs, checked
  2026-09-01 — say so at the foot of the page, and re-check before
  claiming anything newer. `GROK.md` and `.qwen/QWEN.md` are *not* read by
  their agents (documented, not oversight); Codex `.rules` files are
  execution policy, not prompts.
- Palette: `docs/src/styles/custom.css` maps Starlight's `--sl-color-*`
  variables to the tokens in `assets/style.css`; change both together.
- **This repo is the source of truth for user-facing documentation**
  (decided 2026-09-01). The two reference pages were seeded from the app
  repo's `docs/KEYBINDINGS.md` and `THEMES.md`, which were then deleted
  there; the app repo's `docs/` holds developer docs only, and its
  `README.md` / `CLAUDE.md` link here. When the app's behaviour changes
  (shortcuts, settings, themes, menus) the page here is what gets updated;
  `~/marginal/docs/THEME_ADDONS.md` §8 remains the schema contract the
  Themes page is derived from.
- **Screenshots** come from `docs/shots/shoot.sh` (macOS only): it copies
  `docs/shots/fixture/` to `/Users/Shared/Notes`, launches the installed
  app through LaunchServices with `--appearance light|dark`, drives it
  through its menus (System Events) and by coordinate clicks (`click.swift`;
  the webview exposes no usable AX tree), captures with `screencapture -l`
  and writes `docs/src/assets/shots/<scene>.png` + `<scene>-dark.png`. It
  backs up and restores `~/Library/Application Support/md.marginal/`,
  blanking recents for the run. Quit Marginal first. Pages embed a pair via
  `<Shot name="…" alt="…" />` (`docs/src/components/Shot.astro`, MDX only);
  keep `.shot img` free of `display:` — Starlight's `light:/dark:sl-hidden`
  utilities live in a cascade layer and lose to unlayered rules.
- Pages that need `<Shot>` are `.mdx`; everything else stays `.md`.
- Two app quirks the script works around (worth fixing in the app):
  ⌘⇧K with the editor focused runs CodeMirror's delete-line instead of
  Ask About Selection (the manual carries a caution); and an app started
  from its binary path takes its window off screen ~2 s after any
  LaunchServices activation.

## Workflow

- The site (rebuilt from scratch 2026-09-02, structure modelled on
  inkdrop.app): `index.html`, `pricing.html`, `download.html`, `blog.html`
  (the launch post, source `mark.md`), `404.html`, plus the manual under
  `docs/`.
  Plain HTML/CSS, shared styles in `assets/style.css`; the only external
  request is the download page's GitHub API call, and the only JS is the
  theme switch (`assets/site.js`) and that download logic. Feature screenshots in
  `assets/shots/` are WebP copies of the manual's shots (see README);
  regenerate them when the manual's are reshot. The site is public: the
  password gate (and the hashed directory holding the old design) was
  removed 2026-09-02. `mark.md`, the blog's source, is published as a raw
  file until the deploy excludes it.
- Test param: `?theme=light|dark` forces a theme (and swaps the
  `<picture>` sources) — use for screenshots.
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
