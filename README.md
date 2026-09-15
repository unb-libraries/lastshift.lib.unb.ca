# lastshift.lib.unb.ca

UNB Libraries' presentation of *Last Shift: The Story of a Mill Town*, Tony Tremblay and Ellen Rose's
documentary on the 2008 closure of Dalhousie, New Brunswick's pulp and paper mill — a small, static
Nuxt 4 site with no backend, API, or database.

## Getting started

Copy `.env` values as needed first — `NUXT_PORT` and `NUXT_SITE_URI` drive the dev server's
host/port, public URL, and Vite HMR websocket (defaults to `localhost:3000` if unset).

### Run with Docker

Requires only [Docker](https://www.docker.com) — the container brings its own Node and pnpm.

```bash
docker compose up
```

This bind-mounts `app/`, `public/`, `nuxt.config.ts`, `package.json`, and `pnpm-lock.yaml`
into the container and runs `pnpm dev` inside it, exposing `NUXT_PORT` (3112 by default) and
its HMR websocket on `NUXT_PORT * 10` (31120). Once you have pnpm on the host,
`pnpm container:start` is the same command.

### Run locally

Requires [Node.js](https://nodejs.org) `^20.19 || >=22.12` (Vite 7's floor — the Docker
images use Node 26) and [pnpm](https://pnpm.io) 11.10.0.

```bash
pnpm install
pnpm dev
```

pnpm is most easily installed through Corepack, which picks up the version pinned by
`packageManager` in `package.json`:

```bash
corepack enable pnpm
```

If the Node.js your system provides is older than the range above, install a current
release with a version manager such as [fnm](https://github.com/Schniz/fnm),
[nvm](https://github.com/nvm-sh/nvm), [Volta](https://volta.sh), or
[mise](https://mise.jdx.dev) rather than replacing the system package.

### Configuration

Settings are defined in `nuxt.config.ts`. `NUXT_PORT` and `NUXT_SITE_URI` are read from
`.env` for local development; in production they're set directly as container environment
variables in the `Dockerfile`.

## Development

| Command | Description |
| --- | --- |
| `pnpm dev` | Start the dev server |
| `pnpm build` | Production build (SSR output) |
| `pnpm generate` | Static site generation — this is what the production Docker image uses |
| `pnpm preview` | Preview a production build locally |
| `pnpm lint` / `pnpm lint:fix` | ESLint (`@antfu/eslint-config`) over the whole repo |

Husky git hooks enforce code quality on commit: `pre-commit` runs `lint-staged` (ESLint
`--fix` on staged files), `commit-msg` runs `commitlint` against Conventional Commits,
restricted to the types in `commitlint.config.ts` (`feat`, `fix`, `perf`, `refactor`,
`test`, `ops`, `docs`).

There is no test setup configured in this repo.

### Structure

- `app/pages/*.vue` — file-based routes. Each sets its section title via
  `definePageMeta({ title: '...' })`; `app/layouts/default.vue` reads that off `route.meta.title`
  to drive both the document `<title>` and the on-page title bar, so it's declared once per page.
- `app/layouts/landing.vue` — the `/` home page's full-bleed cover layout (background image, film
  title, "ENTER" link into `/the-project`). Set via `definePageMeta({ layout: 'landing' })` in
  `app/pages/index.vue`.
- `app/layouts/default.vue` — the shell for every other page: fixed top bar (wordmark, Contact/Order),
  banner, title bar, section sidebar nav, and `<slot />` for page content.
- `app/components/SiteFooter.vue` — shared footer (UNB Libraries logo, copyright), used by both layouts.
- `app/error.vue` — the 404/error page. It renders through `default.vue` too, passing `title="404"`
  explicitly as a prop since an error page has no route-level `definePageMeta` to read from.
- `app/assets/css/main.css` — Tailwind CSS v4 theme tokens (`@theme`) for the site's dark, wood-grain
  palette (cream text, tan headings, sage links), plus the background-image-driven chrome classes
  (`site-header`, `page-banner`, `site-footer`, etc.) as Tailwind components. No `tailwind.config.js`
  — v4 uses CSS-based config.
- `app/pages/images.vue` — a plain array of `{ file, caption }` entries backing a list of mill and
  town photos.
- `app/pages/comments.vue` — viewer testimonials, kept as a data array of `{ quote, author }` rendered
  with `v-html` (content is static and repo-authored, not user input).
- `public/images/` — banner/background images (`header-image.png`, `cover.png`, `footer-image.png`,
  `sticky-nav.png`, `columnBG.png`, `woodgranetexture.jpg`) and the photo gallery originals referenced
  by `app/pages/images.vue`.

### Analytics

The Google Analytics `gtag.js` snippet (property `G-TYVCV8FXG1`) is wired up globally in
`nuxt.config.ts`'s `app.head`, so it's declared once and applies to every page.

## Deployment

`.github/workflows/deployment-workflow.yaml` calls the shared pipeline in
[`unb-libraries/github-workflows`](https://github.com/unb-libraries/github-workflows): build
the image, push it to GHCR, then `kubectl set image` on the Kubernetes deployment. A push to
`dev` deploys to the `dev` namespace as `dev-lastshift.lib.unb.ca`; the `prod` branch still
holds the Jekyll build and deploys prod on its own workflow.

The `Dockerfile` runs `pnpm generate` in a throw-away stage and serves the result from
[`ghcr.io/unb-libraries/nuxt-ssg`](https://github.com/unb-libraries/docker-nuxt-ssg), which
carries the nginx configuration for a generated Nuxt site. `scripts/verify-generate.mjs`
fails the build if any route was not prerendered — this site has no content collection, so
that script lists the routes directly and needs editing when a page is added.

Because the site is generated statically, any change to pages or content requires a
rebuild to take effect in production — there is no server-side rendering at runtime.

## Entry points

- `/` — landing page: film title over a full-bleed cover image, with an "ENTER" link into `/the-project`.
- `/the-project` — background on the film and the 2008 mill closure.
- `/credits` — cast, crew, and acknowledgements.
- `/trailer` — embedded YouTube clip.
- `/images` — gallery of mill and town photographs.
- `/comments` — viewer testimonials.
- `/post-screening` — discussion questions for use after a screening.
- `/reading` — bibliography (Dalhousie, New Brunswick, deindustrialization).
- `/links` — related external sites.
- `/contact` — general contact info.
- `/order` — how to order a copy of the film.
