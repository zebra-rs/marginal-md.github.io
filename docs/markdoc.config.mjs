import { defineMarkdocConfig } from '@astrojs/markdoc/config';
import starlightMarkdoc from '@astrojs/starlight-markdoc';

// Pages are plain Markdown (`.md`) by default. A page that needs Starlight's
// tabs, steps, or cards can use the `.mdoc` extension and Markdoc tags
// instead — see https://starlight.astro.build/guides/authoring-content/#markdoc
export default defineMarkdocConfig({
  extends: [starlightMarkdoc()],
});
