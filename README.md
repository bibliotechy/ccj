# Collaborative Cataloging Japan Static Catalog

This repository now contains an Astro static-site replacement for the original
Rails/Blacklight prototype. Work record pages are generated as static HTML from
the production SQLite database, while `/catalog/` loads a compact JSON index and
runs search, facets, sorting, and pagination in the browser.

The legacy Rails app is still present as migration reference material, but the
default npm scripts build the static Astro site.

## Develop

```
npm install
npm run dev
```

The data build runs before Astro starts. Open the printed localhost URL and use
`/catalog/` for client-side search.

## Build

```
npm run build
```

The build creates:

- `src/data/records.json` for Astro static record pages from `db/prod.db`
- `src/data/artists.json` for Astro static artist pages from `db/prod.db`
- `public/search-index.json` for client-side catalog search
- `public/artist-context.json` for artist context on filtered search pages
- `dist/` with the static site

## Data Source

`scripts/build-data.mjs` reads the production SQLite database. Set
`CATALOG_DB_PATH` to choose a specific database file. Without that variable, the
script looks for `database/prod.db`, then `db/prod.db`, then the deployable
`db/public.db`. It uses the Rails schema tables for works, components, artists,
collections, artist-component joins, and Active Storage artist portraits.

Public facets are derived from artists, decades, collections, media formats,
media types, component types, and viewing restrictions. Run `npm run build:data`
after changing the production database.
