# Component contract

Use this checklist to add components without redesigning the package infrastructure.

## File and API

- One public component per file; group by purpose, not by release date.
- New components target the package deployment floor (iOS 17 / macOS 14). Add an `@available` annotation only when a component genuinely needs a newer API, and gate the smallest possible surface.
- Prefer `Binding` for caller-owned state and `@ViewBuilder` for arbitrary content. Never launch network requests or persist data inside a visual component.
- Supply sensible defaults. Keep implementation details private.
- User-visible labels are `LocalizedStringKey` (add a `some StringProtocol` overload when runtime strings are a realistic need). The library's own default and internal strings live in `Sources/SwiftBits/Resources/Localizable.xcstrings` and are rendered with `Text(_:bundle: .module)`.
- Add haptics with `.sensoryFeedback` for discrete, meaningful moments (selection, success). Keep them subtle and never on continuous change.
- Sanitize numeric inputs that can produce invalid geometry or unbounded work.
- Use `.task(id:)` for cancellable work; handle cancellation and disappearing views.

```swift
import SwiftUI

/// Explains the visible behavior and any important caller responsibilities.
public struct ExampleComponent<Content: View>: View {
    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        content.padding()
    }
}
```

## Completion checklist

- [ ] Public symbol has a documentation comment and a DocC topic link.
- [ ] Usage snippet includes any required state, frame, or environment values.
- [ ] Browser playground shows the normal, empty, disabled, and failure states that apply.
- [ ] Accessibility review includes motion, text size, contrast, and keyboard behavior.
- [ ] Labels are `LocalizedStringKey`; any new internal strings are added to `Localizable.xcstrings`.
- [ ] Haptics, if any, fire only on discrete meaningful transitions.
- [ ] Tests cover reusable logic, boundary conditions, and regressions rather than matching implementation line-for-line.
- [ ] README catalog and changelog are updated.
- [ ] macOS tests, iOS compilation, and DocC validation pass.

## Repository map

| Location | Owns |
| --- | --- |
| `Sources/SwiftBits/Components` | Public views grouped by purpose |
| `Sources/SwiftBits/Layouts` | Reusable layout primitives |
| `Sources/SwiftBits/Modifiers` | Effects on caller-owned views |
| `Sources/SwiftBits/Utilities` | Small shared helpers |
| `Sources/SwiftBits/Resources` | `Localizable.xcstrings` for the library's own strings |
| `Sources/SwiftBits/SwiftBits.docc` | API topics and usage guides |
| `Tests/SwiftBitsTests` | Deterministic behavior tests |
| `Assets/README` | Logo assets |
| `Preview/components/<slug>` | Live preview HTML, CSS, JavaScript, metadata, and Swift snippet |
| `docs` | Maintainer and contribution guides |
| `scripts` | Repeatable local validation |

The gallery and individual live embed pages are built from `Preview/components/<slug>/`. Each component owns its markup, styles, behavior, metadata, and snippet. Run `python3 scripts/build_previews.py` to regenerate `Preview/public/`; never edit generated files. Follow [the live preview contract](LIVE_PREVIEWS.md) for adding components and embedding them in Framer.
