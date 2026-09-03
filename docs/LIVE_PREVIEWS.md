# Live component previews

A preview is real HTML, CSS, and JavaScript running inside a card-sized frame. The gallery and Framer use the same standalone preview pages. No screenshot, image, or video generation is involved.

## Source layout

```text
Sources/SwiftBits/                   Native Swift package (unchanged)
Preview/
  components/<slug>/
    component.json                  Name, description, category, source path
    preview.html                    Demo markup fragment, including controls
    preview.css                     This demo's styling
    preview.js                      This demo's behavior
    snippet.swift                   Complete copyable SwiftUI example
  shared/frame.css                  Shared embed sizing and accessibility rules
  gallery.html                      Gallery shell; cards are generated
  styles.css                        Gallery styling only
  playground.js                     Gallery search, sorting, and copy actions
  public/                           Generated output; ignored by Git
scripts/build_previews.py            Dependency-free static builder
```

The native code remains in the Swift package's existing folders. Each `component.json` connects a web preview to its native source file; no duplicated Swift implementations need maintaining.

## Build and run

Requires Python 3.10+; Node.js is additionally required for validation. No npm packages are needed.

```sh
python3 scripts/build_previews.py
python3 -m http.server 4173 --directory Preview/public
```

Open `http://localhost:4173/` for the gallery or `http://localhost:4173/previews/glow-button/` for one isolated live card. After editing component files, rebuild and refresh. The build validates metadata before replacing its generated directory and removes obsolete routes.

After building, `Preview/index.html` also opens the gallery directly from disk. The old `Preview/swiftbits-standalone.html`, if present, is an exported snapshot from before this structure; it is not an authoring source or publishing input.

```sh
python3 -m unittest discover -s Tests/preview -v
```

This validates the catalog, source/snippet exports, isolated document IDs, JavaScript syntax, gallery embeds, deterministic builds, and removal of stale output. It does not replace visual or interaction checks when developing a demo.

## Add a component

1. Implement and document the native Swift component as described in `COMPONENT_GUIDE.md`.
2. Create `Preview/components/<slug>/` with the five files listed above. Copy a similar existing component as a starting point.
3. Set a unique kebab-case `slug`, unique `name`, unique integer `order`, `description`, valid `category`, repository-relative `source`, `aspectRatio: "4 / 3"`, and `previewKind: "live-html"` in `component.json`.
4. Use a markup fragment in `preview.html`, normally a `.stage` wrapper. Put all demo controls inside that fragment. JavaScript runs only in this preview's document, so it must not refer to gallery controls or other components.
5. Add component-specific styles to `preview.css`. Size against the embedded frame, not the full website. Preview width is typically 250–400 pixels. Keep interactions keyboard-accessible and respect reduced motion. Keep assets self-contained; the current previews require no external resources.
6. Put a complete SwiftUI `View` example, with required state and imports, in `snippet.swift`.
7. Build and validate. The gallery and catalog discover the component automatically; do not manually register it in another list.

Valid categories are `text`, `controls`, `cards`, `layout`, and `feedback`. `order` controls the gallery's curated ordering; the current “Latest” tab reverses it, rather than inferring release dates. All components are currently free.

## Published bundle

The builder creates:

| Path | Purpose |
| --- | --- |
| `index.html` | Complete gallery with live iframe cards |
| `previews/<slug>/index.html` | Self-contained HTML/CSS/JavaScript preview |
| `snippets/<slug>.swift` | Complete copyable SwiftUI example |
| `sources/<slug>.swift` | Native source file exported from the package |
| `catalog.json` | Machine-readable metadata, paths, snippets, preview revisions |
| `catalog.csv` | The same core fields for CMS import or processing |

Catalog paths are relative to the publishing root, making the bundle work under a GitHub project subpath or another static host. Resolve them with `new URL(component.previewPath, baseURL)`, where `baseURL` ends with `/`. The `revision` is a hash of the built live preview, so integrations can detect changes. `schemaVersion` is currently `1`.

## Connect the live cards to Framer

Use the hosted preview URL as the source of an iframe in your Framer card. A preview fills the frame and includes its own controls; Framer owns the outside title, metadata, and Copy action. Give the frame a 4:3 ratio and clip it to a 19px radius.

Example embed markup (replace the example domain with the actual publishing URL):

```html
<iframe
  src="https://YOUR-PREVIEW-HOST/previews/glow-button/"
  title="GlowButton interactive preview"
  loading="lazy"
  sandbox="allow-scripts"
  style="display:block;width:100%;aspect-ratio:4/3;border:0;border-radius:19px"
></iframe>
```

The iframe runs the actual preview code. It does not embed the gallery or render an image. Keep it pointer-interactive instead of placing a link overlay over the entire frame. A frame sandbox with `allow-scripts` is sufficient for these demos, which do not need parent-page access or storage.

For CMS-driven cards, use the catalog fields for the slug, name, category, description, preview URL, and Swift snippet. CSV/JSON paths must be resolved against your deployment URL before using them as Framer URL fields. Bind the card's iframe source to that preview URL. Host caching may briefly delay updates after deployment; existing open pages need a refresh.

Publishing new preview code updates the existing URLs. Adding a new card or changing its metadata also requires updating Framer's CMS. This repository exports those inputs but does not yet authenticate to or automatically write to Framer; that connection can be added after the Framer project is connected.

## Publish through GitHub

The `Live component previews` workflow validates pull requests and uploads a downloadable bundle. Pushes to `main` also publish the bundle to GitHub Pages.

One-time repository setup: in **Settings → Pages → Build and deployment**, choose **GitHub Actions**. Then push the committed changes, or run the workflow manually. The deployment job reports the actual Pages URL. Appending `previews/<slug>/` gives a component's stable live preview URL.

The workflow follows [GitHub's custom Pages workflow](https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages). It deploys only the generated preview bundle, never the repository root. It does not publish the Framer website. No Framer API key is required for hosting the live cards.
