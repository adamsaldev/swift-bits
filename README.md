# SwiftBits

Expressive, reusable SwiftUI components built as a native Swift Package.

> SwiftBits is in early development. The first stable release will focus on a
> small collection of polished, accessible components rather than a large set
> of one-off effects.

## Requirements

- iOS 17+
- macOS 14+
- Swift 6.0+

## Installation

In Xcode, select **File → Add Package Dependencies**, then enter this repository's
GitHub URL. Add `SwiftBits` to your app target and import it:

```swift
import SwiftBits
```

## Components

### GlowButton

```swift
GlowButton("Continue", tint: .purple) {
    print("Tapped")
}
```

### Shimmer

```swift
RoundedRectangle(cornerRadius: 12)
    .fill(.gray.opacity(0.25))
    .frame(height: 72)
    .shimmer()
```

## Repository structure

```text
Sources/SwiftBits/
├── Components/       Reusable views grouped by category
├── Modifiers/        Native-feeling View extensions
├── Utilities/        Shared animation and layout helpers
└── SwiftBits.docc/    API documentation
```

Tests live in `Tests/SwiftBitsTests`. A visual component catalog app is planned
for the next milestone.

## Roadmap

- AnimatedCounter
- GlassCard
- SkeletonView
- CollapsingHeader
- Interactive component catalog app
- Accessibility and snapshot-test coverage

## License

SwiftBits is available under the MIT License.
