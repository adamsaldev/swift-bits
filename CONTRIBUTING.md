# Contributing to SwiftBits

SwiftBits is a collection of small, composable SwiftUI building blocks. Keep each component focused on one useful interaction and make its public API understandable from a short example.

## Work locally

Use Xcode 26+ and Swift 6 to build the library. Previewing in the browser requires neither.

```sh
git clone https://github.com/adamsaldev/swift-bits.git
cd swift-bits
swift test
python3 scripts/build_previews.py
python3 -m http.server 4173 --directory Preview/public
```

The gallery and embeddable live cards are generated from `Preview/components/`. See [the live preview guide](docs/LIVE_PREVIEWS.md). Open `Package.swift` in Xcode for library development and API documentation.

## Add a component

1. Read [the component contract](docs/COMPONENT_GUIDE.md).
2. Add one public view in the appropriate `Sources/SwiftBits/Components/` category, or a reusable layout in `Layouts/`.
3. Add `component.json`, `preview.html`, `preview.css`, `preview.js`, and `snippet.swift` under `Preview/components/<slug>/`. Build and validate with `python3 -m unittest discover -s Tests/preview -v`. Label any differences from native behavior.
4. Document its initializer, usage, ownership, accessibility behavior, and limitations in DocC. Link the symbol from `SwiftBits.md` and add it to the README catalog.
5. Test meaningful logic and edge cases. Check the UI using the [accessibility review](docs/ACCESSIBILITY.md).
6. Run `scripts/validate.sh`, update `CHANGELOG.md`, and open a pull request.

Use four-space indentation, descriptive names, semantic colors, and native controls. Avoid third-party dependencies and unrelated formatting changes. Public API changes should explain migration in the changelog. During the 0.x phase, breaking changes require a minor version increment.

## Report a problem

Use the bug template with a minimal SwiftUI reproduction, OS/Xcode versions, and expected behavior. Component proposals should explain the use case and proposed API. Credit any adapted source and preserve its license.
