# marginal.md

The Marginal marketing site, served by GitHub Pages at **https://marginal.md**
(CNAME in this repo; DNS apex A/AAAA → GitHub Pages).

## Layout

- `index.html`, `download.html` — the live site: hand-baked static HTML, no
  framework, no external requests. Shared styles in `assets/site.css`
  (design tokens mirror the app's `marginal-light`/`marginal-dark` themes;
  ink/vermilion/cream come from the app icon).
- `docs/` — the **user manual**, an [Astro](https://astro.build) +
  [Starlight](https://starlight.astro.build) project. Pages are Markdown in
  `docs/src/content/docs/` (Markdoc `.mdoc` works too); the build is static
  and is served at **https://marginal.md/docs/**. See `docs/README.md`.
- `design/` — the **Claude Design canvas export** the static pages were baked
  from (`Marginal Site.dc.html`, `Marginal Download.dc.html` + `support.js`
  runtime + `_ds/` design system). Not served as the site (robots.txt
  excludes it); kept as the design source. The canvas itself lives in
  claude.ai/design; the "Marginal" design-system project there carries the
  tokens and `guidelines/brand.md`.
- `assets/og.png` is generated from `assets/og-source.svg`
  (`rsvg-convert -w 1200 -h 630`), the favicon/touch icons from
  `assets/marginal-icon.svg`.

## Editing

Edit the static pages directly for copy and factual changes; re-export the
canvas into `design/` when the visual design is reworked in Claude Design,
then re-bake by hand. Keep claims in step with the product — pricing is
$10/mo or $96/yr with a 14-day no-card trial, a lapsed subscription means
read-only (never locked files), and AI runs on the customer's own Anthropic
key (never a license gate). See `design/BACKEND.md` §8 in the backend repo.

For the manual, add or edit pages under `docs/src/content/docs/`; each needs
a `title:` frontmatter line. `pnpm --dir docs dev` serves it with hot reload
and `pnpm --dir docs build` writes `docs/dist/`.

## Deploying

`.github/workflows/deploy.yml` builds the manual on every push to `main`,
copies the hand-baked pages next to it, and publishes the result through
GitHub Pages — the repository's Pages source must be set to **GitHub
Actions**. `./run.sh` serves the site locally on port 8090.
