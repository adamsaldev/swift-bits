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
- Right-to-left: pass the environment layout direction to `FlowLayout`; check long localized labels.

## Caller responsibilities

Supply localized strings and meaningful accessibility names. Choose tint colors with sufficient contrast in the app's environment. Give fixed-size progress rings and collapsing headers enough room for larger text. Keep controls out of `ExpandableCard` summaries; place them in the detail area.

## Validation scope

Automated tests cover layout arithmetic and numeric boundaries. The browser playground approximates native interactions. Full VoiceOver, touch, and device accessibility certification remains a manual release check; unit tests do not establish it.
