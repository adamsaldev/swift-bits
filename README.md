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
  Expressive SwiftUI components, effects, and interaction patterns.
  <br />
  Built to help Swift developers add polish without rebuilding every animation from scratch.

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

## Small details. Remarkable interfaces.

**SwiftBits is a native SwiftUI component library for expressive apps.** Compose animated text, tactile controls, useful feedback, and flexible containers with small, readable APIs. Own your state, bring your content, and customize the result.

- **11 components + 1 effect.** From a glowing call to action to a complete empty state.
- **SwiftUI all the way down.** Bindings, view builders, semantic styles, and native controls.
- **A browser playground.** Explore interactive component demos with no Xcode setup.
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

The project is currently an **untagged MVP**. Pin a commit for reproducible integration; switch to a semantic version after the first release is published.

</details>

## Components

### Actions & selection

| Component | What it does | Guide |
| --- | --- | --- |
| [`GlowButton`](Sources/SwiftBits/Components/Buttons/GlowButton.swift) | Tinted glow with pressed and disabled feedback | [Quick start](#start-in-a-minute) |
| [`HoldToConfirmButton`](Sources/SwiftBits/Components/Buttons/HoldToConfirmButton.swift) | Cancellable hold, plus keyboard and VoiceOver confirmation | [Buttons](Sources/SwiftBits/SwiftBits.docc/FirstCollection.md#buttons) |
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
| [`SkeletonView`](Sources/SwiftBits/Components/Loading/SkeletonView.swift) | Layout-preserving loading placeholders | [Loading](Sources/SwiftBits/SwiftBits.docc/FirstCollection.md#skeleton-layouts) |
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

## Browser playground

The [browser playground](Preview/index.html) is the project's only preview surface. Clone the repository and open `Preview/index.html` in your browser—no build, server, or Xcode required.

```sh
git clone https://github.com/adamsaldev/swift-bits.git
cd swift-bits
open Preview/index.html
```

The playground currently contains interactive approximations of five components. SwiftUI source remains authoritative for native rendering and behavior.

## Requirements

| Surface | Minimum OS | Build toolchain |
| --- | --- | --- |
| Full collection | iOS 26 / macOS 26 | Xcode 26+, Swift 6 |
| `GlowButton` & `.shimmer()` | iOS 17 / macOS 14 | Xcode 26+ to build the current package |

The package retains its lower deployment floor for existing adopters; newer APIs are explicitly availability-gated. There are **no third-party package dependencies**.

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
Preview/              Browser playground (the only preview)
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
