<div align="center">
<br />
<br />
  <picture>
    <source media="(prefers-color-scheme: light)" srcset="Assets/README/swift-bits-logo-light.svg">
    <source media="(prefers-color-scheme: dark)" srcset="Assets/README/swift-bits-logo-dark.svg">
    <img src="Assets/README/swift-bits-logo-light.svg" alt="SwiftBits logo" width="600">
  </picture>
<br />
<br />
  <strong>Expressive SwiftUI components, effects, and interaction patterns.</strong>
  <br />
  <sub>Built to help Swift developers add polish without rebuilding every animation from scratch.</sub>

  <br />
  <br />

  <a href="https://github.com/adamsaldev/swift-bits/stargazers"><img alt="GitHub stars" src="https://img.shields.io/github/stars/adamsaldev/swift-bits?style=flat-square"></a>
  <a href="https://github.com/adamsaldev/swift-bits/blob/main/LICENSE"><img alt="MIT License" src="https://img.shields.io/badge/license-MIT-blue?style=flat-square"></a>
  <a href="https://github.com/adamsaldev/swift-bits/actions/workflows/ci.yml"><img alt="CI status" src="https://img.shields.io/github/actions/workflow/status/adamsaldev/swift-bits/ci.yml?branch=main&style=flat-square&label=build"></a>
  <img alt="Swift 6" src="https://img.shields.io/badge/Swift-6.0-F05138?style=flat-square&logo=swift&logoColor=white">

  <br />
  <br />

  <a href="Sources/SwiftBits/SwiftBits.docc/FirstCollection.md">📖 Documentation</a> ·
  <a href="#start-in-a-minute">⚡ Quick Start</a> ·
  <a href="#components">🧩 Components</a>
</div>

<br />

<div align="center">
  <img src="Assets/README/showcase.png" alt="Native SwiftUI components: glowing and morphing buttons, rolling numbers, progress ring, filter chips, expandable card, and empty state" width="1200">
  <br />
  <sub>Rendered from the actual SwiftUI components. No mockups, no external dependencies.</sub>
</div>

## Small details. Remarkable interfaces.

**SwiftBits is a native SwiftUI component library for expressive apps.** Compose animated text, tactile controls, useful feedback, and flexible containers with small, readable APIs. Own your state, bring your content, and customize the result.

- **14 components + 1 effect.** From a glowing call to action to a complete empty state.
- **SwiftUI all the way down.** Bindings, view builders, semantic styles, and native controls.
- **A working gallery.** Try the components locally, then copy a focused example into your app.
- **Built to grow.** Organized source, DocC guides, deterministic tests, and a documented component contract.

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
    .package(url: "https://github.com/adamsaldev/swift-bits.git", branch: "main")
],
targets: [
    .target(
        name: "YourApp",
        dependencies: [.product(name: "SwiftBits", package: "swift-bits")]
    )
]
```

The project is currently an **untagged MVP**. Pin a commit for reproducible integration; switch to a semantic version after the first release is published. The demo executable is a development tool and is not needed by your app.

</details>

## Components

### Actions & selection

| Component | What it does | Guide |
| --- | --- | --- |
| [`GlowButton`](Sources/SwiftBits/Components/Buttons/GlowButton.swift) | Tinted glow with pressed and disabled feedback | [Quick start](#start-in-a-minute) |
| [`HoldToConfirmButton`](Sources/SwiftBits/Components/Buttons/HoldToConfirmButton.swift) | Cancellable hold, plus keyboard and VoiceOver confirmation | [Buttons](Sources/SwiftBits/SwiftBits.docc/FirstCollection.md#buttons) |
| [`MorphingButton`](Sources/SwiftBits/Components/Buttons/MorphingButton.swift) | Idle, loading, success, and retry states | [Buttons](Sources/SwiftBits/SwiftBits.docc/FirstCollection.md#buttons) |
| [`FilterChip`](Sources/SwiftBits/Components/Controls/FilterChip.swift) | Binding-driven selection with a visible checkmark | [Filters](Sources/SwiftBits/SwiftBits.docc/EverydayComponents.md#selectable-filters) |

### Text & feedback

| Component | What it does | Guide |
| --- | --- | --- |
| [`ScrambleText`](Sources/SwiftBits/Components/Text/ScrambleText.swift) | Resolves scrambled characters into your text | [Text](Sources/SwiftBits/SwiftBits.docc/FirstCollection.md#text) |
| [`RollingNumber`](Sources/SwiftBits/Components/Text/RollingNumber.swift) | Localized numeric transitions | [Text](Sources/SwiftBits/SwiftBits.docc/FirstCollection.md#text) |
| [`ProgressRing`](Sources/SwiftBits/Components/Feedback/ProgressRing.swift) | Animated determinate progress with custom center content | [Progress](Sources/SwiftBits/SwiftBits.docc/EverydayComponents.md#progress) |
| [`StatusBadge`](Sources/SwiftBits/Components/Feedback/StatusBadge.swift) | Compact status with semantic text and a symbol | [Status](Sources/SwiftBits/SwiftBits.docc/EverydayComponents.md#status) |
| [`EmptyState`](Sources/SwiftBits/Components/Feedback/EmptyState.swift) | Clear empty-state messaging and recovery actions | [Empty states](Sources/SwiftBits/SwiftBits.docc/EverydayComponents.md#empty-states) |

### Containers, layout & effects

| Component | What it does | Guide |
| --- | --- | --- |
| [`SpotlightCard`](Sources/SwiftBits/Components/Cards/SpotlightCard.swift) | Pointer and touch-following radial highlight | [Cards](Sources/SwiftBits/SwiftBits.docc/FirstCollection.md#cards) |
| [`ExpandableCard`](Sources/SwiftBits/Components/Cards/ExpandableCard.swift) | In-place expansion with interactive detail content | [Cards](Sources/SwiftBits/SwiftBits.docc/FirstCollection.md#cards) |
| [`SkeletonView`](Sources/SwiftBits/Components/Loading/SkeletonView.swift) | Layout-preserving loading placeholders | [Loading](Sources/SwiftBits/SwiftBits.docc/FirstCollection.md#skeleton-layouts) |
| [`CollapsingHeader`](Sources/SwiftBits/Components/Scrolling/CollapsingHeader.swift) | Shared header over independently scrolling tabs | [Scrolling](Sources/SwiftBits/SwiftBits.docc/FirstCollection.md#shared-collapsing-header) |
| [`FlowLayout`](Sources/SwiftBits/Layouts/FlowLayout.swift) | Wrapping rows for tags and filters, including RTL | [Layout](Sources/SwiftBits/SwiftBits.docc/EverydayComponents.md#wrapping-layout) |
| [`.shimmer()`](Sources/SwiftBits/Modifiers/ShimmerModifier.swift) | Optional animated light sweep over any view | [Example below](#compose-your-own) |

## Compose your own

```swift
// Inside an iOS 26+ / macOS 26+ view:
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

## Explore locally

```sh
git clone https://github.com/adamsaldev/swift-bits.git
cd swift-bits
swift run SwiftBitsDemo
```

For a standard macOS app bundle with Dock integration, run `scripts/run-demo.sh`.

The macOS gallery includes interactive examples of every component. Open `Package.swift` in Xcode to use the canvas, or embed `SwiftBitsGallery()` in an iOS 26+ app. An optional [browser playground](Preview/index.html) approximates the original eight-component collection; native SwiftUI is the source of truth.

To regenerate the README image on macOS 26+:

```sh
swift run SwiftBitsDemo --snapshot Assets/README/showcase.png
```

## Requirements

| Surface | Minimum OS | Build toolchain |
| --- | --- | --- |
| Full collection & gallery | iOS 26 / macOS 26 | Xcode 26+, Swift 6 |
| `GlowButton` & `.shimmer()` | iOS 17 / macOS 14 | Xcode 26+ to build the current package |
| Native demo executable | macOS 26 | Xcode 26+, Swift 6 |

The package retains its lower deployment floor for existing adopters; newer APIs are explicitly availability-gated. There are **no third-party package dependencies**.

## A repository built to grow

```text
Sources/SwiftBits/
├── Components/       Buttons, cards, controls, feedback, loading, scrolling, text
├── Layouts/          Composable layout primitives
├── Modifiers/        Effects on existing views
├── Utilities/        Shared, testable helpers
├── Examples/         Embeddable SwiftBitsGallery
└── SwiftBits.docc/    API topics and practical guides
Examples/             Runnable native demo and showcase renderer
Tests/                Layout and behavior regression tests
Assets/README/        Logos and native showcase
Preview/              Optional browser approximation
docs/                 Component, accessibility, and release guides
scripts/              Repeatable validation
.github/              CI, issue forms, and PR template
```

**Adding the next component?** Start with the [component contract](docs/COMPONENT_GUIDE.md), add its gallery example and DocC guide, and run `scripts/validate.sh`. CI runs macOS tests, iOS compilation, and a DocC build.

| For developers | For maintainers |
| --- | --- |
| [First collection guide](Sources/SwiftBits/SwiftBits.docc/FirstCollection.md) | [Contribution workflow](CONTRIBUTING.md) |
| [Everyday components](Sources/SwiftBits/SwiftBits.docc/EverydayComponents.md) | [Component contract](docs/COMPONENT_GUIDE.md) |
| [API topics](Sources/SwiftBits/SwiftBits.docc/SwiftBits.md) | [Release checklist](docs/RELEASING.md) |
| [Accessibility behavior](docs/ACCESSIBILITY.md) | [Changelog](CHANGELOG.md) |

## Credits & license

Created by [Adam Saleh](https://github.com/adamsaldev). Inspired by the creativity of [React Bits](https://github.com/DavidHDev/react-bits), with components built specifically for SwiftUI. Contributions should credit any adapted source and preserve its license.

[MIT licensed](LICENSE). Build something that feels good to use.
