# First collection

Eight reusable components for iOS 26 and macOS 26. Import `SwiftUI` and `SwiftBits` to use the following snippets inside a view. The interactive ``SwiftBitsGallery`` includes all eight examples.

## Text

```swift
ScrambleText("Hello, SwiftBits", duration: 0.8)
    .font(.title.monospaced())

RollingNumber(score, format: .number.precision(.fractionLength(2)))
    .font(.largeTitle)
RollingNumber(percent: completion, decimalPlaces: 1)
```

`ScrambleText` replays when its text or configuration changes, preserves whitespace, and cancels its work when removed. VoiceOver reads the final text. Reduce Motion immediately displays the final value. A custom alphabet can be provided with `characters:`; an empty alphabet disables scrambling.

`RollingNumber` uses SwiftUI's native vertical numeric transition, including direction changes and changing digit counts. The number format controls grouping, precision, and locale. The percentage initializer accepts a fraction: 0.42 displays as 42%. Reduce Motion updates without animation.

## Buttons

```swift
HoldToConfirmButton("Hold to delete", duration: 1.5, tint: .red) {
    deleteSelection()
}

// Declare: @State private var saveState = MorphingButton.State.idle
MorphingButton("Save", state: saveState) {
    saveState = .loading
    // Set .success or .failure when your asynchronous operation finishes.
}
```

A hold completes only once per gesture. Releasing early, moving outside the button, disabling the control, leaving the screen, or backgrounding the app cancels it. VoiceOver and keyboard users activate twice to confirm; the armed state expires after five seconds. Hold progress is functional feedback and continues with Reduce Motion enabled.

`MorphingButton` reserves space for every configured label so loading and results do not shift the surrounding layout. Loading and success disable activation; failure permits retry. The caller owns asynchronous work, error handling, and resetting the state. Customize `loadingTitle`, `successTitle`, and `failureTitle` for localization.

## Cards

```swift
SpotlightCard(color: .purple, radius: 160) {
    Text("Move across this card").padding()
}

// Declare: @State private var expanded = false
ExpandableCard(isExpanded: $expanded) {
    Text("Order details").font(.headline)
} detail: {
    Text("Your order is ready for collection.")
    Button("Close") { expanded = false }
}
```

Cards use standard material and adapt to Reduce Transparency. The spotlight follows pointer hover or a simultaneous drag gesture; avoid using it where a custom drag interaction must exclusively own touches. Reduce Motion disables the moving highlight. The expandable card expands in place and removes hidden details from accessibility navigation. Its summary is a native button; place nested controls in the detail closure. Expansion respects Reduce Motion.

## Skeleton layouts

```swift
SkeletonView(isLoading: isLoading) {
    HStack {
        Image(systemName: "person.crop.circle.fill")
        VStack(alignment: .leading) {
            Text(name ?? "Placeholder name")
            Text(subtitle ?? "A representative subtitle")
        }
    }
}
```

Supply representative content while loading so SwiftUI can measure the intended layout. Native redaction creates text and image placeholders; it does not infer arbitrary custom drawing, canvas paths, or asynchronously missing content. Provide placeholder shapes for those layouts yourself. Loading content is noninteractive and exposed as one customizable “Loading” accessibility element. Shimmer stops under Reduce Motion; `shimmer: false` also disables it.

## Shared collapsing header

```swift
// Declare: @State private var selection = "Feed"
CollapsingHeader(
    tabs: ["Feed", "Saved"],
    selection: $selection,
    expandedHeight: 180,
    collapsedHeight: 64
) { progress in
    Text("Library")
        .font(progress < 0.5 ? .largeTitle : .headline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.background)
} tabLabel: { tab in
    Label(tab, systemImage: tab == "Feed" ? "list.bullet" : "bookmark")
} content: { tab in
    LazyVStack {
        ForEach(0..<50) { row in
            Text("\(tab) row \(row)").padding()
        }
    }
}
```

The container owns a native tab view and a vertical scroll view for each tab. Pass unique, stable tab IDs and a selection present in that list. Do not nest another vertical scroll view in the content closure. Each tab retains its own scroll position and offset baseline. The shared header collapses with downward scroll deltas and restores immediately on upward movement. Selecting a tab at the top restores the expanded header. Overscroll is clamped; equal heights produce a fixed header. Header height follows scrolling directly without added animation. Choose heights that fit your header at the Dynamic Type sizes your app supports.
