// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';
import markdoc from '@astrojs/markdoc';

// The manual is served at https://marginal.md/docs/ next to the hand-baked
// marketing pages; `base` prefixes every link and asset accordingly.
export default defineConfig({
  site: 'https://marginal.md',
  base: '/docs',
  integrations: [
    starlight({
      title: 'Marginal',
      description: 'The Marginal user manual.',
      logo: { src: './src/assets/marginal-icon.svg', alt: '' },
      favicon: '/favicon.svg',
      customCss: ['./src/styles/custom.css'],
      social: [{ icon: 'external', label: 'marginal.md', href: 'https://marginal.md/' }],
      editLink: {
        baseUrl: 'https://github.com/zebra-rs/marginal.github.io/edit/main/docs/',
      },
      sidebar: [
        { label: 'Start here', items: [{ autogenerate: { directory: 'start' } }] },
        { label: 'Coding agents', items: [{ autogenerate: { directory: 'agents' } }] },
        { label: 'Files', items: [{ autogenerate: { directory: 'files' } }] },
        { label: 'Writing', items: [{ autogenerate: { directory: 'writing' } }] },
        { label: 'AI', items: [{ autogenerate: { directory: 'ai' } }] },
        { label: 'Output', items: [{ autogenerate: { directory: 'output' } }] },
        { label: 'More', items: [{ autogenerate: { directory: 'more' } }] },
        { label: 'Reference', items: [{ autogenerate: { directory: 'reference' } }] },
      ],
    }),
    markdoc(),
  ],
});
