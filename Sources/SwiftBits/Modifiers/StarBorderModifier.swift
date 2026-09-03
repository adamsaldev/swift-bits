import SwiftUI

public extension View {
    /// Draws a rounded border lit by a slowly rotating gradient around the receiver.
    ///
    /// The border is decorative and does not change the receiver's accessibility. The
    /// rotation stops under Reduce Motion, leaving a static gradient stroke.
    func starBorder(cornerRadius: CGFloat = 16, lineWidth: CGFloat = 2,
                    colors: [Color] = [.blue, .purple, .pink, .blue],
                    duration: TimeInterval = 6) -> some View {
        modifier(StarBorderModifier(
            cornerRadius: cornerRadius.isFinite ? max(cornerRadius, 0) : 16,
            lineWidth: lineWidth.isFinite ? min(max(lineWidth, 0.5), 24) : 2,
            colors: colors.isEmpty ? [.accentColor] : colors,
            duration: duration.isFinite ? min(max(duration, 0.5), 120) : 6
        ))
    }
}

private struct StarBorderModifier: ViewModifier {
    let cornerRadius: CGFloat
    let lineWidth: CGFloat
    let colors: [Color]
    let duration: TimeInterval
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content.overlay {
            let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            Group {
                if reduceMotion {
                    shape.strokeBorder(AngularGradient(colors: colors, center: .center), lineWidth: lineWidth)
                } else {
                    TimelineView(.animation) { context in
                        let turns = context.date.timeIntervalSinceReferenceDate / duration
                        let angle = Angle.degrees(turns.truncatingRemainder(dividingBy: 1) * 360)
                        shape.strokeBorder(
                            AngularGradient(colors: colors, center: .center, angle: angle),
                            lineWidth: lineWidth
                        )
                    }
                }
            }
            .accessibilityHidden(true)
        }
    }
}
