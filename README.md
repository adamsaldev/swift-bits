<div align="center">
<br />
<br />
  <picture>
    <source media="(prefers-color-scheme: light)" srcset="Assets/README/swift-bits-logo-light.svg">
    <source media="(prefers-color-scheme: dark)" srcset="Assets/README/swift-bits-logo-dark.svg">
    <img src="Assets/README/swift-bits-logo-light.svg" alt="SwiftBits logo" width="400">
  </picture>
<br />
<br />
  Drop-in motion and visual flair for SwiftUI.
  <br />
  Animated text, tactile buttons, and eye-catching surfaces &mdash; small APIs, native rendering, no dependencies.

  <br />
  <br />

<a href="https://github.com/adamsaldev/swift-bits/stargazers"><img alt="GitHub Stars" src="https://img.shields.io/github/stars/adamsaldev/swift-bits?style=for-the-badge&logo=github&label=Stars"></a>
<a href="https://github.com/adamsaldev/swift-bits/blob/main/LICENSE"><img alt="MIT License" src="https://img.shields.io/badge/License-MIT-22C55E?style=for-the-badge"></a>
<a href="https://github.com/adamsaldev/swift-bits/actions/workflows/ci.yml"><img alt="Build Status" src="https://img.shields.io/github/actions/workflow/status/adamsaldev/swift-bits/ci.yml?branch=main&style=for-the-badge&logo=githubactions&logoColor=white&label=Build"></a>
<img alt="Swift 6" src="https://img.shields.io/badge/Swift-6.0-F05138?style=for-the-badge&logo=swift&logoColor=white">

  <br />
  <br />

  <a href="Sources/SwiftBits/SwiftBits.docc/FirstCollection.md">📖 Documentation</a> ·
  <a href="#start-in-a-minute">⚡ Quick Start</a> ·
  <a href="#components">🧩 Components</a> ·
  <a href="#browser-playground">▶ Browser Playground</a>
</div>

<br />

## Motion and flair, the SwiftUI way

**SwiftBits is a native SwiftUI library for the expressive parts of an interface** &mdash; the glowing button, the number that rolls, the card that lights up under your cursor, the text that resolves out of noise. Inspired by [React Bits](https://github.com/DavidHDev/react-bits), rebuilt so it renders and animates natively. You own the state and the content; SwiftBits owns the polish.

- **Native rendering, no dependencies.** Real SwiftUI views, bindings, view builders, and semantic styles &mdash; not a wrapper around a canvas.
- **Small APIs.** One expressive idea per component, sensible defaults, `LocalizedStringKey` labels, and haptics where they help.
- **Accessible by default.** Reduce Motion, Reduce Transparency, Dynamic Type, VoiceOver, and keyboard paths are handled, not bolted on.
- **A browser playground.** Explore every component as a live web demo with no Xcode setup, and embed the demos in Framer.

## Start in a minute

Add this repository in **Xcode → File → Add Package Dependencies**, then select the **SwiftBits** library product:

```text
https://github.com/adamsaldev/swift-bits.git
```

```swift
import SwiftUI
import SwiftBits

struct ContentView: View {
    var body: some View {
        GlowButton("Create something", tint: .indigo) {
            // Start your next great idea.
        }
        .padding()
    }
}
```

<details>
<summary><strong>Using a Package.swift manifest?</strong></summary>

Add the dependency to your package and the product to your app target:

```swift
dependencies: [
    .package(url: "https://github.com/adamsaldev/swift-bits.git", from: "0.1.0")
],
targets: [
    .target(
        name: "YourApp",
        dependencies: [.product(name: "SwiftBits", package: "swift-bits")]
    )
]
```

SwiftBits is at **0.1.0**. While the major version is `0`, minor releases may contain breaking API changes; pin with `.upToNextMinor(from: "0.1.0")` if you need that guarantee.

</details>

## Components

### Expressive

| Component | What it does | Guide |
| --- | --- | --- |
| [`ScrambleText`](Sources/SwiftBits/Components/Text/ScrambleText.swift) | Resolves scrambled characters into your text | [Text](Sources/SwiftBits/SwiftBits.docc/FirstCollection.md#text) |
| [`RollingNumber`](Sources/SwiftBits/Components/Text/RollingNumber.swift) | Vertical odometer transitions for localized numbers | [Text](Sources/SwiftBits/SwiftBits.docc/FirstCollection.md#text) |
| [`GlowButton`](Sources/SwiftBits/Components/Buttons/GlowButton.swift) | Tinted glow with pressed, disabled, and haptic feedback | [Quick start](#start-in-a-minute) |
| [`SpotlightCard`](Sources/SwiftBits/Components/Cards/SpotlightCard.swift) | Radial highlight that follows the pointer or touch | [Cards](Sources/SwiftBits/SwiftBits.docc/FirstCollection.md#cards) |
| [`HoldToConfirmButton`](Sources/SwiftBits/Components/Buttons/HoldToConfirmButton.swift) | Cancellable hold with a filling track, plus a keyboard/VoiceOver path | [Buttons](Sources/SwiftBits/SwiftBits.docc/FirstCollection.md#buttons) |
| [`.shimmer()`](Sources/SwiftBits/Modifiers/ShimmerModifier.swift) | Animated light sweep over any view | [Example below](#compose-your-own) |

### Everyday building blocks

| Component | What it does | Guide |
| --- | --- | --- |
| [`FilterChip`](Sources/SwiftBits/Components/Controls/FilterChip.swift) | Binding-driven selection with a checkmark and selection haptic | [Filters](Sources/SwiftBits/SwiftBits.docc/EverydayComponents.md#selectable-filters) |
| [`StatusBadge`](Sources/SwiftBits/Components/Feedback/StatusBadge.swift) | Compact status with semantic text and a symbol | [Status](Sources/SwiftBits/SwiftBits.docc/EverydayComponents.md#status) |
| [`ProgressRing`](Sources/SwiftBits/Components/Feedback/ProgressRing.swift) | Determinate progress with custom center content | [Progress](Sources/SwiftBits/SwiftBits.docc/EverydayComponents.md#progress) |
| [`EmptyState`](Sources/SwiftBits/Components/Feedback/EmptyState.swift) | Empty-state messaging with caller-owned recovery actions | [Empty states](Sources/SwiftBits/SwiftBits.docc/EverydayComponents.md#empty-states) |
| [`SkeletonView`](Sources/SwiftBits/Components/Loading/SkeletonView.swift) | Layout-preserving loading placeholders | [Loading](Sources/SwiftBits/SwiftBits.docc/FirstCollection.md#skeleton-layouts) |
| [`FlowLayout`](Sources/SwiftBits/Layouts/FlowLayout.swift) | Wrapping rows for tags and filters, including RTL | [Layout](Sources/SwiftBits/SwiftBits.docc/EverydayComponents.md#wrapping-layout) |

## Roadmap

SwiftBits is early. The direction is more of the expressive surface, built natively:

- **Animated backgrounds** &mdash; `MeshGradient`-driven aurora and gradient fields, a subtle noise/grain layer.
- **Text effects** &mdash; per-character reveal (`TextRenderer`), blur-in, shiny sweep, split/stagger.
- **Micro-interactions** &mdash; click spark, magnetic hover, animated border, press-scale styles.
- **Toolkit fills** &mdash; toast/overlay presentation, `AsyncButton`, shimmer presets.

Have a request? Open a [component request](.github/ISSUE_TEMPLATE/component_request.yml). Ports from React Bits should credit and preserve the original license.

## Compose your own

```swift
// Inside an iOS 17+ / macOS 14+ view:
@State private var favoritesOnly = true
@Environment(\.layoutDirection) private var layoutDirection

var body: some View {
    VStack(alignment: .leading, spacing: 24) {
        FlowLayout(layoutDirection: layoutDirection) {
            FilterChip("Favorites", systemImage: "star", isSelected: $favoritesOnly)
            StatusBadge("Synced", systemImage: "checkmark.circle", tint: .green)
        }

        ProgressRing(value: 0.72, tint: .indigo, accessibilityLabel: "Upload")
            .frame(width: 120, height: 120)

        RoundedRectangle(cornerRadius: 12)
            .fill(.quaternary)
            .frame(height: 60)
            .shimmer()
    }
    .padding()
}
```

## Browser playground

The [browser playground](Preview/index.html) displays live HTML/CSS/JavaScript demos in thumbnail-sized cards. Every component has an isolated preview that can also be embedded directly in Framer.

```sh
python3 scripts/build_previews.py
python3 -m http.server 4173 --directory Preview/public
```

Open `http://localhost:4173/` for the gallery. Each live card has its own route, such as `http://localhost:4173/previews/glow-button/`. After building, you can also open `Preview/index.html` directly in your browser.

Author each demo in `Preview/components/<slug>/` alongside its metadata and complete SwiftUI snippet. The build produces all 12 live previews, the gallery, JSON/CSV catalogs, and copyable snippets. A GitHub Actions workflow validates these files and publishes them to GitHub Pages after Pages is enabled for the repository.

See [Live previews and Framer integration](docs/LIVE_PREVIEWS.md) for the folder structure, publishing setup, and embed contract. Browser demos approximate native behavior; SwiftUI source remains authoritative.

## Requirements

| Surface | Minimum OS | Build toolchain |
| --- | --- | --- |
| Every component and effect | iOS 17 / macOS 14 | Xcode 26+, Swift 6 |

The whole collection shares one deployment floor. There are **no third-party package dependencies**.

## A repository built to grow

```text
Sources/SwiftBits/
├── Components/       Buttons, cards, controls, feedback, loading, text
├── Layouts/          Composable layout primitives
├── Modifiers/        Effects on existing views
├── Utilities/        Shared, testable helpers
└── SwiftBits.docc/    API topics and practical guides
Tests/                Layout and behavior regression tests
Assets/README/        Logo assets
Preview/              Per-component live web demos, snippets, and gallery
docs/                 Component, accessibility, and release guides
scripts/              Repeatable validation
.github/              CI, issue forms, and PR template
```

**Adding the next component?** Start with the [component contract](docs/COMPONENT_GUIDE.md), add its browser playground example and DocC guide, and run `scripts/validate.sh`. CI runs macOS tests, iOS compilation, and a DocC build.

| For developers | For maintainers |
| --- | --- |
| [First collection guide](Sources/SwiftBits/SwiftBits.docc/FirstCollection.md) | [Contribution workflow](CONTRIBUTING.md) |
| [Everyday components](Sources/SwiftBits/SwiftBits.docc/EverydayComponents.md) | [Component contract](docs/COMPONENT_GUIDE.md) |
| [API topics](Sources/SwiftBits/SwiftBits.docc/SwiftBits.md) | [Release checklist](docs/RELEASING.md) |
| [Accessibility behavior](docs/ACCESSIBILITY.md) | [Changelog](CHANGELOG.md) |

## Credits & license

Created by [Adam Saleh](https://github.com/adamsaldev). Inspired by the creativity of [React Bits](https://github.com/DavidHDev/react-bits), with components built specifically for SwiftUI. Contributions should credit any adapted source and preserve its license.

[MIT licensed](LICENSE). Build something that feels good to use.
