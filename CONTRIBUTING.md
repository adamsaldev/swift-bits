# Contributing to SwiftBits

SwiftBits is a collection of small, composable SwiftUI building blocks. Keep each component focused on one useful interaction and make its public API understandable from a short example.

## Work locally

Use Xcode 26+ and Swift 6. The native gallery needs macOS 26+.

```sh
git clone https://github.com/adamsaldev/swift-bits.git
cd swift-bits
swift test
swift run SwiftBitsDemo
```

For a standard macOS app bundle with Dock integration, run `scripts/run-demo.sh`.

Open `Package.swift` in Xcode for canvas previews and documentation. For iOS, embed `SwiftBitsGallery()` in an iOS 26+ app. The gallery is a library view; the executable is a macOS development tool.

## Add a component

1. Read [the component contract](docs/COMPONENT_GUIDE.md).
2. Add one public view in the appropriate `Sources/SwiftBits/Components/` category, or a reusable layout in `Layouts/`.
3. Add an interactive example to `SwiftBitsGallery.swift` with useful state controls.
4. Document its initializer, usage, ownership, accessibility behavior, and limitations in DocC. Link the symbol from `SwiftBits.md` and add it to the README catalog.
5. Test meaningful logic and edge cases. Check the UI using the [accessibility review](docs/ACCESSIBILITY.md).
6. Run `scripts/validate.sh`, update `CHANGELOG.md`, and open a pull request.

Use four-space indentation, descriptive names, semantic colors, and native controls. Avoid third-party dependencies and unrelated formatting changes. Public API changes should explain migration in the changelog. During the 0.x phase, breaking changes require a minor version increment.

## Report a problem

Use the bug template with a minimal SwiftUI reproduction, OS/Xcode versions, and expected behavior. Component proposals should explain the use case and proposed API. Credit any adapted source and preserve its license.
