# First collection

Five reusable components for iOS 26 and macOS 26. Import `SwiftUI` and `SwiftBits` to use the following snippets inside a view. The repository’s browser playground demonstrates approximations of these five components.

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

```

A hold completes only once per gesture. Releasing early, moving outside the button, disabling the control, leaving the screen, or backgrounding the app cancels it. VoiceOver and keyboard users activate twice to confirm; the armed state expires after five seconds. Hold progress is functional feedback and continues with Reduce Motion enabled.

## Cards

```swift
SpotlightCard(color: .purple, radius: 160) {
    Text("Move across this card").padding()
}

```

Spotlight cards use standard material and adapt to Reduce Transparency. The spotlight follows pointer hover or a simultaneous drag gesture; avoid using it where a custom drag interaction must exclusively own touches. Reduce Motion disables the moving highlight.

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
