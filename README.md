# marginal.md

The Marginal marketing site, served by GitHub Pages at **https://marginal.md**
(CNAME in this repo; DNS apex A/AAAA → GitHub Pages).

## Layout

- `index.html`, `pricing.html`, `download.html`, `blog.html`, `404.html` — the site:
  hand-baked static HTML, no framework; the only external request is the
  download page asking the GitHub API for the latest release. Shared styles
  in `assets/style.css` (tokens mirror the app's `marginal-light` /
  `marginal-dark` themes; the vermilion comes from the app icon).
  `assets/top.png` is the hero screenshot; `assets/shots/` holds the WebP
  feature screenshots (`cwebp -q 82 -resize 1600 0` over app screenshots;
  `reader*` comes from `docs/src/assets/shots/`), plus `agent-list.png`, a
  crop of `top.png`. The site is
  public (the password gate was removed 2026-09-02); `design-v2/` holds
  old design canvases and is not published.
- `docs/` — the **user manual**, an [Astro](https://astro.build) +
  [Starlight](https://starlight.astro.build) project. Pages are Markdown in
  `docs/src/content/docs/` (Markdoc `.mdoc` works too); the build is static
  and is served at **https://marginal.md/docs/**. See `docs/README.md`.
- `assets/og.png` is generated from `assets/og-source.svg`
  (`rsvg-convert -w 1200 -h 630`), the favicon/touch icons from
  `assets/marginal-icon.svg`.

## Editing

Edit the static pages directly; there is no build step for them. Keep
claims in step with the product — pricing is $10/mo or $96/yr with a 14-day
no-card trial, a lapsed subscription means read-only (never locked files),
and AI runs on the customer's own API key (Anthropic, OpenAI, Google, xAI,
or Alibaba Cloud; never a license gate). See `design/BACKEND.md` §8 in the
backend repo. `?theme=light|dark` on any page forces a theme for
screenshots.

For the manual, add or edit pages under `docs/src/content/docs/`; each needs
a `title:` frontmatter line. `pnpm --dir docs dev` serves it with hot reload
and `pnpm --dir docs build` writes `docs/dist/`.

## Deploying

`.github/workflows/deploy.yml` builds the manual on every push to `main`,
copies the hand-baked pages next to it, and publishes the result through
GitHub Pages — the repository's Pages source must be set to **GitHub
Actions**. `./run.sh` serves the site locally on port 8090.
