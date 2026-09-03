import SwiftUI

/// A full-bleed `MeshGradient` whose interior control points drift on a slow loop.
///
/// Pass nine colours for the 3×3 mesh; other counts are cycled to fill it. The drift
/// freezes under Reduce Motion, leaving a static gradient. The view is decorative and is
/// hidden from VoiceOver — put it behind your content with `.background`.
@available(iOS 18.0, macOS 15.0, *)
public struct MeshGradientBackground: View {
    private let colors: [Color]
    private let speed: Double
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init(colors: [Color] = [.indigo, .purple, .blue,
                                   .teal, .indigo, .cyan,
                                   .blue, .mint, .indigo],
                speed: Double = 1) {
        let palette = colors.isEmpty ? [Color.indigo] : colors
        self.colors = (0..<9).map { palette[$0 % palette.count] }
        self.speed = speed.isFinite ? min(max(speed, 0), 8) : 1
    }

    public var body: some View {
        TimelineView(.animation(paused: reduceMotion || speed == 0)) { context in
            let time = reduceMotion ? 0 : context.date.timeIntervalSinceReferenceDate * speed
            MeshGradient(width: 3, height: 3, points: points(at: time), colors: colors)
        }
        .ignoresSafeArea()
        .accessibilityHidden(true)
    }

    private func points(at time: Double) -> [SIMD2<Float>] {
        func drift(_ seed: Double, _ base: SIMD2<Float>, _ amplitude: Float) -> SIMD2<Float> {
            let x = base.x + amplitude * Float(sin(time + seed))
            let y = base.y + amplitude * Float(cos(time * 0.9 + seed))
            return SIMD2(min(max(x, 0), 1), min(max(y, 0), 1))
        }
        return [
            SIMD2(0, 0), drift(0.4, SIMD2(0.5, 0), 0.10), SIMD2(1, 0),
            drift(1.3, SIMD2(0, 0.5), 0.10), drift(2.1, SIMD2(0.5, 0.5), 0.16), drift(3.0, SIMD2(1, 0.5), 0.10),
            SIMD2(0, 1), drift(3.8, SIMD2(0.5, 1), 0.10), SIMD2(1, 1)
        ]
    }
}
