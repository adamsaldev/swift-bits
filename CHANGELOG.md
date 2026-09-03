# Changelog

Notable changes are recorded here. SwiftBits follows semantic versioning; 0.x APIs may evolve between minor releases.

## 0.1.0 — 2026-09-03

First tagged release.

### Components

- **Expressive:** `ScrambleText`, `RollingNumber`, `GlowButton`, `SpotlightCard`, `HoldToConfirmButton`, and the `.shimmer()` modifier.
- **Everyday building blocks:** `FilterChip`, `StatusBadge`, `ProgressRing`, `EmptyState`, `SkeletonView`, and `FlowLayout`.

### Platform

- Single deployment floor of iOS 17 / macOS 14 for the whole collection. (Earlier drafts gated most components to iOS 26 without needing an iOS 26 API; those annotations were removed.)
- No third-party dependencies.

### Localization

- User-visible labels are `LocalizedStringKey`, with `some StringProtocol` overloads on `GlowButton`, `HoldToConfirmButton`, `FilterChip`, and `StatusBadge` for runtime strings.
- The library ships its own strings in `Localizable.xcstrings` (English), resolved via `Bundle.module`.

### Feedback

- `.sensoryFeedback` haptics: `.selection` on `FilterChip` and while arming `HoldToConfirmButton`, `.success` on a completed hold, and a soft impact on `GlowButton` press. Haptics degrade to nothing on unsupported hardware.

### Accessibility

- Reduce Motion, Reduce Transparency, Dynamic Type, VoiceOver labels/traits/values, and keyboard activation paths across the collection.
- `GlowButton` respects Reduce Motion and reflects its disabled state.
- `HoldToConfirmButton` dims when disabled, matching the other buttons.
- `ProgressRing` clamps out-of-range values and treats NaN as zero to avoid invalid geometry.
- `.shimmer()` sanitizes invalid and extreme durations and stops under Reduce Motion.

### Tooling

- Browser playground: component-owned HTML/CSS/JS demos, isolated embed pages, a gallery, JSON/CSV catalogs, and native source exports from one no-dependency build, validated in CI and published to GitHub Pages. Framer embed contract documented.
- Component contract, everyday-component guide, accessibility review, and release checklist.
- Layout-arithmetic and numeric edge-case tests; CI runs macOS tests, iOS compilation, and a DocC build with warnings as errors.
