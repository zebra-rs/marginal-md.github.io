# marginal.md

The Marginal marketing site, served by GitHub Pages at **https://marginal.md**
(CNAME in this repo; DNS apex A/AAAA → GitHub Pages).

## Layout

- `index.html`, `download.html` — the live site: hand-baked static HTML, no
  framework, no external requests. Shared styles in `assets/site.css`
  (design tokens mirror the app's `marginal-light`/`marginal-dark` themes;
  ink/vermilion/cream come from the app icon).
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

`./run.sh` serves the site locally on port 8090.
