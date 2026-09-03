# Changelog

Notable changes are recorded here. SwiftBits follows semantic versioning; 0.x APIs may evolve between minor releases.

## Unreleased

### Added

- Redesigned browser playground with system typography, responsive component cards, category filters, and search.

- `FilterChip`, `StatusBadge`, `ProgressRing`, and `EmptyState` for everyday interface states.
- `FlowLayout` with wrapping rows, configurable spacing, and right-to-left placement.
- Browser playground as the sole preview surface.
- Everyday component guide, component contract, accessibility review, and release process.
- Layout boundary tests, numeric edge-case tests, iOS compilation, and DocC checks.

### Removed

- Native gallery, Xcode preview, macOS demo executable and launcher, and static README showcase.

### Fixed

- `GlowButton` respects Reduce Motion and visually reflects disabled state.
- Shimmer sanitizes invalid and extreme durations.
- Progress clamping treats NaN as zero to avoid invalid geometry.

### Existing collection

- Animated text, hold-to-confirm and morphing buttons, spotlight and expandable cards, loading skeletons, and shared collapsing headers.
- `GlowButton` and `.shimmer()` retain iOS 17/macOS 14 support; the expanded collection requires iOS 26/macOS 26.
