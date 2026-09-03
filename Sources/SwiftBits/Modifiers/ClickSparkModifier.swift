import SwiftUI

public extension View {
    /// Emits a short burst of sparks from the point the receiver is tapped.
    ///
    /// The effect is purely decorative: it never blocks touches, adds nothing to the
    /// accessibility tree, and is skipped entirely under Reduce Motion.
    func clickSpark(color: Color = .accentColor, count: Int = 8,
                    radius: CGFloat = 24, duration: TimeInterval = 0.4) -> some View {
        modifier(ClickSparkModifier(
            color: color,
            count: min(max(count, 1), 60),
            radius: radius.isFinite ? min(max(radius, 1), 400) : 24,
            duration: duration.isFinite ? min(max(duration, 0.05), 3) : 0.4
        ))
    }
}

private struct ClickSparkModifier: ViewModifier {
    let color: Color
    let count: Int
    let radius: CGFloat
    let duration: TimeInterval
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var bursts: [Burst] = []

    private struct Burst: Identifiable {
        let id = UUID()
        let origin: CGPoint
        let start: Date
    }

    func body(content: Content) -> some View {
        content
            .overlay {
                if !reduceMotion {
                    TimelineView(.animation(paused: bursts.isEmpty)) { context in
                        Canvas { canvas, _ in
                            for burst in bursts {
                                let progress = context.date.timeIntervalSince(burst.start) / duration
                                guard progress >= 0, progress <= 1 else { continue }
                                let eased = 1 - pow(1 - progress, 3)
                                for spark in 0..<count {
                                    let angle = Double(spark) / Double(count) * 2 * .pi
                                    let unit = CGPoint(x: cos(angle), y: sin(angle))
                                    var path = Path()
                                    path.move(to: point(burst.origin, unit, radius * eased * 0.55))
                                    path.addLine(to: point(burst.origin, unit, radius * eased))
                                    canvas.stroke(path, with: .color(color.opacity(1 - progress)),
                                                  style: StrokeStyle(lineWidth: 2, lineCap: .round))
                                }
                            }
                        }
                        .onChange(of: context.date) { _, now in
                            bursts.removeAll { now.timeIntervalSince($0.start) > duration }
                        }
                    }
                    .allowsHitTesting(false)
                    .accessibilityHidden(true)
                }
            }
            .simultaneousGesture(
                DragGesture(minimumDistance: 0).onEnded { value in
                    guard !reduceMotion else { return }
                    bursts.append(Burst(origin: value.location, start: .now))
                }
            )
    }

    private func point(_ origin: CGPoint, _ unit: CGPoint, _ distance: CGFloat) -> CGPoint {
        CGPoint(x: origin.x + unit.x * distance, y: origin.y + unit.y * distance)
    }
}
