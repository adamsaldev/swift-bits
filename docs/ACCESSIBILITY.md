# Accessibility review

SwiftBits uses semantic text styles and native buttons, exposes meaningful labels, and respects Reduce Motion for decorative transitions. These implementation choices do not replace testing inside the app that adopts a component.

## Manual review before a release

Open `Preview/index.html` to review the browser demos with keyboard navigation and browser accessibility tools. Browser behavior does not establish native accessibility compliance. When validating the library in a consuming app, review the following:

- Light and dark appearances; Increase Contrast; Reduce Transparency.
- Default and largest accessibility text sizes. No truncated essential text or unreachable actions.
- Reduce Motion: scrambling resolves immediately, decorative shimmer stops, and animated selection/progress transitions stop. Hold progress remains functional feedback.
- VoiceOver: logical reading order, one announcement per informational element, selection state on chips, and accessible confirmation on hold buttons.
- Keyboard: focus and activation on every interactive control. Hold confirmation uses two activations.
- Disabled controls: no action or mutation; state is visible.
- Haptics: `FilterChip`, `HoldToConfirmButton`, and `GlowButton` play `.sensoryFeedback` on discrete transitions only; confirm nothing fires on continuous drag or rapid value change.
- Right-to-left: pass the environment layout direction to `FlowLayout`; check long localized labels.

## Release review log

### 0.1.0 — 2026-09-03 (code-level audit)

Static pass over every component against the checklist above. On-device VoiceOver and touch verification by a person is still recommended before a `1.0`.

- **Reduce Motion / Reduce Transparency:** all decorative animation is gated; `SpotlightCard` swaps material for an opaque background. Pass.
- **Dynamic Type:** semantic font styles throughout; no fixed heights that clip text. `frame(minHeight: 44)` grows. Pass, with the existing caveat that fixed-size `ProgressRing` frames must leave room for the center label.
- **VoiceOver:** informational views collapse to one element with an explicit label; decorative symbols and overlays are hidden; `FilterChip` exposes `.isSelected`; `HoldToConfirmButton` exposes an armed value, a hint, and a keyboard/VoiceOver double-activation path. Pass.
- **Keyboard:** all interactive controls are `Button`s. Pass.
- **Disabled state:** action and mutation are blocked everywhere. Fixed in this release — `HoldToConfirmButton` now also dims to 0.5 opacity like the other buttons.
- **RTL:** `FlowLayout` mirrors placement; other components rely on automatic mirroring. Pass.
- **Caller responsibilities (unchanged):** `GlowButton` renders white text on the tint gradient, so callers must pass a tint with enough contrast; all labels are `LocalizedStringKey`, so callers own their translations.

## Caller responsibilities

Supply localized strings and meaningful accessibility names. Choose tint colors with sufficient contrast in the app's environment. Give fixed-size progress rings enough room for larger text.

## Validation scope

Automated tests cover layout arithmetic and numeric boundaries. The browser playground approximates native interactions. Full VoiceOver, touch, and device accessibility certification remains a manual release check; unit tests do not establish it.
