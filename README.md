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
  <a href="#quick-start">⚡ Quick Start</a> ·
  <a href="#components">🧩 Components</a>
</div>

<br />

<!-- TODO: Add a wide component showcase GIF or PNG at Assets/README/showcase.png, then uncomment:
<div align="center">
  <img src="Assets/README/showcase.png" alt="SwiftBits component showcase" width="1000" />
</div>

<br />
-->

## ✨ Why SwiftBits?

SwiftBits helps you **build expressive SwiftUI interfaces faster**. Instead of spending hours crafting animations from scratch, start with a reusable component and customize it to fit your app.

> 💬 **Text Animations** · 🎛️ **Buttons & Controls** · 🧩 **Cards & Containers** · 🌀 **Loading & Scrolling**

## 🚀 Features

- **9 components + a shimmer effect** — animated text, interactive buttons, cards, loading placeholders, and scrolling behavior
- **No third-party dependencies** — built entirely with SwiftUI and Apple frameworks
- **Customizable by design** — adjust colors, timing, content, and behavior through Swift APIs or edit the source directly
- **Native SwiftUI composition** — work with views, bindings, and view builders that fit naturally into your app
- **Swift Package Manager ready** — add the repository in Xcode, import SwiftBits, and start building
- **Examples included** — explore the interactive Xcode gallery and follow the component usage guide

## Components

| Component | Category | Purpose | Status |
| --- | --- | --- | --- |
| `GlowButton` | Buttons | Configurable button with glow and pressed feedback | Available |
| `.shimmer()` | Effects | Animated light sweep for loading states | Available |
| `ScrambleText` | Text | Scrambles characters before resolving into text | Available |
| `RollingNumber` | Text | Vertical digit transitions with localized number formatting | Available |
| `HoldToConfirmButton` | Buttons | Continuous hold with cancellation and accessible confirmation | Available |
| `MorphingButton` | Buttons | Idle, loading, success, and failure transitions | Available |
| `SpotlightCard` | Cards | Pointer and touch-following radial highlight | Available |
| `ExpandableCard` | Cards | Animated in-place summary and detail expansion | Available |
| `SkeletonView` | Loading | Layout-preserving redaction and optional shimmer | Available |
| `CollapsingHeader` | Scrolling | Shared collapsing header over independently scrollable tabs | Available |

The eight new components and `SwiftBitsGallery` require **iOS 26+ or macOS 26+**, compiled with Xcode 26+. Existing `GlowButton` and `.shimmer()` retain iOS 17/macOS 14 support.

See [the collection guide](Sources/SwiftBits/SwiftBits.docc/FirstCollection.md) for usage and accessibility notes. Open `SwiftBitsGallery.swift` in Xcode and run its canvas preview to explore all eight components.

## Installation

### Xcode

In Xcode, open **File → Add Package Dependencies** and enter:

```text
https://github.com/adamsaldev/swift-bits.git
```

Add the `SwiftBits` product to your app target, then import it where needed:

```swift
import SwiftBits
```

### Package.swift

```swift
dependencies: [
    .package(
        url: "https://github.com/adamsaldev/swift-bits.git",
        branch: "main"
    )
]
```

> SwiftBits is currently pre-release. Pin to a version instead of `main` after the first tagged release.

## Quick start

### GlowButton

```swift
import SwiftBits
import SwiftUI

struct ContentView: View {
    var body: some View {
        GlowButton("Continue", tint: .purple) {
            print("Tapped")
        }
        .padding()
    }
}
```

### Shimmer

```swift
RoundedRectangle(cornerRadius: 14)
    .fill(.gray.opacity(0.22))
    .frame(height: 80)
    .shimmer()
```

## Package structure

```text
SwiftBits/
├── Package.swift
├── Sources/SwiftBits/
│   ├── Components/       Reusable views grouped by category
│   ├── Modifiers/        Effects applied to existing views
│   ├── Utilities/        Shared animation and layout helpers
│   └── SwiftBits.docc/    API documentation
├── Tests/SwiftBitsTests/  Unit and behavior tests
└── .github/workflows/     Automated build and test checks
```

## 📋 Requirements

- iOS 17+
- macOS 14+
- Swift 6.0+
- Xcode 16+

## 🗺️ Roadmap

- Expand the first collection of animated components
- Build a visual catalog app with live customization controls
- Publish complete DocC documentation
- Add snapshot and accessibility coverage
- Tag the first semantic release

<!-- TODO: Link each roadmap item to a GitHub issue once the issue tracker is organized. -->

## 🤝 Contributing

Ideas, bug reports, and pull requests are welcome. Read [CONTRIBUTING.md](CONTRIBUTING.md) before submitting a change.

When proposing a component, include its intended use case, customization API, accessibility behavior, and a visual preview when possible.

## 👨‍💻 Maintainer

Created and maintained by [Adam Saleh](https://github.com/adamsaldev).

## 💡 Inspiration and credit

SwiftBits is inspired by the creativity and discoverability of projects such as [React Bits](https://github.com/DavidHDev/react-bits), while its components and APIs are implemented specifically for SwiftUI.

If a component is adapted from another open-source project or public example, its source and license should be credited alongside the implementation.

## 📄 License

SwiftBits is available under the [MIT License](LICENSE).
