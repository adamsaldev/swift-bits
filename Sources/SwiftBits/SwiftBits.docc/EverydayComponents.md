# Everyday components

Compose filtering, progress, status, and empty states with five focused building blocks. All require iOS 26 or macOS 26. Import `SwiftUI` and `SwiftBits` in each file.

## Selectable filters

`FilterChip` owns no selection model: the binding is the source of truth. Use multiple independent bindings for multiple selection, or derive bindings from a single selected ID for exclusive selection. Disabled chips cannot change selection. Selected chips display a checkmark and expose the selected accessibility trait.

```swift
@State private var favoritesOnly = false
@Environment(\.layoutDirection) private var layoutDirection

var body: some View {
    FlowLayout(layoutDirection: layoutDirection) {
        FilterChip("Favorites", systemImage: "star", isSelected: $favoritesOnly)
        StatusBadge("New", systemImage: "sparkles", tint: .orange)
    }
}
```

## Wrapping layout

`FlowLayout` measures each child's intrinsic size, wraps rows to the proposed width, and uses the tallest item in a row to place the next. `spacing` controls horizontal gaps; `rowSpacing` controls vertical gaps. It is non-lazy and intended for small collections such as tags, not thousands of cells.

Pass the environment's `layoutDirection` for right-to-left placement. Each row aligns at its leading edge. An oversized item receives the available width and may wrap its own text. Avoid `.fixedSize(horizontal: true, vertical: false)` when content needs to wrap.

## Progress

```swift
ProgressRing(value: 0.72, tint: .indigo, accessibilityLabel: "Upload")
    .frame(width: 120, height: 120)

ProgressRing(value: completion, accessibilityLabel: "Course completion") {
    VStack {
        Text("Lesson 4").font(.headline)
        Text("of 6").foregroundStyle(.secondary)
    }
}
.frame(width: 160, height: 160)
```

The value is a fraction, not a percentage. Out-of-range values are clamped; NaN becomes zero. The ring exposes its name and a localized percentage as one accessibility element. Custom center content is decorative to VoiceOver; put essential context in `accessibilityLabel`. Use a native `ProgressView` for indeterminate work. Give the ring enough space for its center label at your supported Dynamic Type sizes. Reduce Motion disables animated transitions.

## Status

```swift
StatusBadge("Synced", systemImage: "checkmark.circle.fill", tint: .green)
StatusBadge("Needs attention", systemImage: "exclamationmark.triangle", tint: .orange)
```

Badges are informational, not interactive. Primary text remains semantic; tint colors the background and border. Choose a meaningful title because the decorative symbol is omitted from the combined accessibility label.

## Empty states

```swift
EmptyState("No saved components", systemImage: "bookmark",
           message: "Save a component to find it here later.") {
    Button("Browse components") { showCatalog = true }
        .buttonStyle(.borderedProminent)
}
```

Omit the trailing closure for an informational state. The caller owns navigation and recovery actions. Text wraps, the symbol is decorative, and actions retain native button semantics. All strings accept caller-localized values, for example `String(localized: "No saved components")`.
