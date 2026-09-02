import SwiftUI

/// A material card with a radial highlight that follows hover or touch locations.
@available(iOS 26.0, macOS 26.0, *)
public struct SpotlightCard<Content: View>: View {
    private let color: Color
    private let radius: CGFloat
    private let cornerRadius: CGFloat
    private let content: Content
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency
    @State private var location: CGPoint?

    public init(color: Color = .accentColor, radius: CGFloat = 180, cornerRadius: CGFloat = 24,
                @ViewBuilder content: () -> Content) {
        self.color = color
        self.radius = radius.isFinite ? max(radius, 1) : 180
        self.cornerRadius = cornerRadius
        self.content = content()
    }

    public var body: some View {
        content
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                if reduceTransparency { Rectangle().fill(.background) }
                else { Rectangle().fill(.regularMaterial) }
            }
            .overlay {
                GeometryReader { proxy in
                    if let location, !reduceMotion {
                        RadialGradient(colors: [color.opacity(0.25), .clear],
                                       center: UnitPoint(x: location.x / max(proxy.size.width, 1),
                                                         y: location.y / max(proxy.size.height, 1)),
                                       startRadius: 0, endRadius: radius)
                    }
                }
                .allowsHitTesting(false)
                .accessibilityHidden(true)
            }
            .clipShape(.rect(cornerRadius: cornerRadius))
            .overlay(RoundedRectangle(cornerRadius: cornerRadius).strokeBorder(.primary.opacity(0.12)))
            .onContinuousHover { phase in
                switch phase {
                case .active(let point): location = point
                case .ended: location = nil
                }
            }
            .simultaneousGesture(DragGesture(minimumDistance: 0)
                .onChanged { location = $0.location }
                .onEnded { _ in location = nil })
    }
}
