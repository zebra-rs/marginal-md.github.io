# Marginal manual

The user manual for [Marginal](https://marginal.md), built with
[Astro](https://astro.build) and [Starlight](https://starlight.astro.build)
and served at **https://marginal.md/docs/**.

## Writing

Pages live in `src/content/docs/`. Each page is a Markdown file with a
`title:` frontmatter line; the sidebar groups in `astro.config.mjs` pick up
files from their directories automatically.

Plain `.md` is the default and supports GitHub-flavored Markdown, task lists,
footnotes, `> [!TIP]`-style alerts, and Starlight's `:::tip` asides. A page
that needs tabs, steps, or cards can use the `.mdoc` extension and
[Markdoc tags](https://starlight.astro.build/guides/authoring-content/#markdoc)
instead.

## Commands

Run from this directory (or from the repo root with `pnpm --dir docs …`):

```sh
pnpm install     # once
pnpm dev         # http://localhost:4321/docs/ with hot reload
pnpm build       # static output in dist/
pnpm preview     # serve dist/ the way GitHub Pages will
```

## Deploying

`.github/workflows/deploy.yml` at the repo root builds this project on every
push to `main` and publishes it, together with the hand-baked marketing pages,
through GitHub Pages.
