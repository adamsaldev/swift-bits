# Component contract

Use this checklist to add components without redesigning the package infrastructure.

## File and API

- One public component per file; group by purpose, not by release date.
- New components target iOS 26 and macOS 26 with an availability annotation. Preserve `GlowButton` and shimmer's existing iOS 17/macOS 14 availability.
- Prefer `Binding` for caller-owned state and `@ViewBuilder` for arbitrary content. Never launch network requests or persist data inside a visual component.
- Supply sensible defaults. Accept caller-localized strings. Keep implementation details private.
- Sanitize numeric inputs that can produce invalid geometry or unbounded work.
- Use `.task(id:)` for cancellable work; handle cancellation and disappearing views.

```swift
import SwiftUI

/// Explains the visible behavior and any important caller responsibilities.
@available(iOS 26.0, macOS 26.0, *)
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
| `Sources/SwiftBits/SwiftBits.docc` | API topics and usage guides |
| `Tests/SwiftBitsTests` | Deterministic behavior tests |
| `Assets/README` | Logo assets |
| `Preview` | Browser playground; the only preview surface |
| `docs` | Maintainer and contribution guides |
| `scripts` | Repeatable local validation |

The browser playground is the only preview surface. Add new component demos there and document differences from native behavior. SwiftUI source remains authoritative for the library implementation.
