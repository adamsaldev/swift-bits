import Foundation
import SwiftUI

private struct ShimmerModifier: ViewModifier {
    let active: Bool
    let duration: TimeInterval

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var phase: CGFloat = -1

    func body(content: Content) -> some View {
        content
            .overlay {
                if active && !reduceMotion {
                    GeometryReader { proxy in
                        LinearGradient(
                            colors: [.clear, .white.opacity(0.55), .clear],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(width: proxy.size.width * 0.55)
                        .rotationEffect(.degrees(20))
                        .offset(x: phase * proxy.size.width * 2)
                    }
                    .mask(content)
                    .allowsHitTesting(false)
                }
            }
            .task(id: active && !reduceMotion) {
                guard active && !reduceMotion else {
                    phase = -1
                    return
                }

                phase = -1
                withAnimation(.linear(duration: duration).repeatForever(autoreverses: false)) {
                    phase = 1
                }
            }
    }
}

public extension View {
    /// Adds an animated light sweep to the receiving view.
    func shimmer(active: Bool = true, duration: TimeInterval = 1.4) -> some View {
        modifier(ShimmerModifier(active: active, duration: duration.isFinite ? min(max(duration, 0.1), 60) : 1.4))
    }
}
