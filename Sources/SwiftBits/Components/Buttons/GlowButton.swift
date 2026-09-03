import SwiftUI

/// A button with a configurable animated glow and native pressed feedback.
public struct GlowButton<Label: View>: View {
    private let action: () -> Void
    private let tint: Color
    private let cornerRadius: CGFloat
    private let glowRadius: CGFloat
    private let label: Label

    public init(
        tint: Color = .accentColor,
        cornerRadius: CGFloat = 16,
        glowRadius: CGFloat = 14,
        action: @escaping () -> Void,
        @ViewBuilder label: () -> Label
    ) {
        self.tint = tint
        self.cornerRadius = cornerRadius
        self.glowRadius = glowRadius
        self.action = action
        self.label = label()
    }

    public var body: some View {
        Button(action: action) {
            label
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(
            GlowButtonStyle(
                tint: tint,
                cornerRadius: cornerRadius,
                glowRadius: glowRadius
            )
        )
    }
}

private struct GlowButtonStyle: ButtonStyle {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.isEnabled) private var isEnabled
    let tint: Color
    let cornerRadius: CGFloat
    let glowRadius: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(tint.gradient)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .shadow(
                color: tint.opacity(configuration.isPressed ? 0.25 : 0.55),
                radius: configuration.isPressed ? glowRadius * 0.4 : glowRadius
            )
            .opacity(isEnabled ? 1 : 0.5)
            .scaleEffect(configuration.isPressed && !reduceMotion ? 0.97 : 1)
            .animation(reduceMotion ? nil : .spring(response: 0.22, dampingFraction: 0.72), value: configuration.isPressed)
            .sensoryFeedback(.impact(flexibility: .soft), trigger: configuration.isPressed) { _, isPressed in isPressed }
    }
}

public extension GlowButton where Label == Text {
    init(
        _ titleKey: LocalizedStringKey,
        tint: Color = .accentColor,
        cornerRadius: CGFloat = 16,
        glowRadius: CGFloat = 14,
        action: @escaping () -> Void
    ) {
        self.init(tint: tint, cornerRadius: cornerRadius, glowRadius: glowRadius, action: action) {
            Text(titleKey)
        }
    }

    init(
        _ title: some StringProtocol,
        tint: Color = .accentColor,
        cornerRadius: CGFloat = 16,
        glowRadius: CGFloat = 14,
        action: @escaping () -> Void
    ) {
        self.init(tint: tint, cornerRadius: cornerRadius, glowRadius: glowRadius, action: action) {
            Text(title)
        }
    }
}
