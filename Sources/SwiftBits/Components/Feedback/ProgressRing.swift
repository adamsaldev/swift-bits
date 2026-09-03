import SwiftUI

/// Determinate progress with a custom center label and one accessible percentage value.
/// Values outside `0...1` are clamped; NaN is treated as zero.
@available(iOS 26.0, macOS 26.0, *)
public struct ProgressRing<Label: View>: View {
    private let value: Double
    private let tint: Color
    private let lineWidth: CGFloat
    private let accessibilityTitle: String
    private let label: Label
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init(value: Double, tint: Color = .accentColor, lineWidth: CGFloat = 8,
                accessibilityLabel: String = "Progress", @ViewBuilder label: () -> Label) {
        self.value = SwiftBitsAnimation.clampedProgress(value)
        self.tint = tint
        self.lineWidth = lineWidth.isFinite ? min(max(lineWidth, 1), 32) : 8
        self.accessibilityTitle = accessibilityLabel
        self.label = label()
    }

    public var body: some View {
        ZStack {
            Circle().strokeBorder(.quaternary, lineWidth: lineWidth)
            Circle().inset(by: lineWidth / 2)
                .trim(from: 0, to: value)
                .stroke(tint.gradient, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
            label.padding(lineWidth + 4)
        }
        .aspectRatio(1, contentMode: .fit)
        .animation(reduceMotion ? nil : .smooth, value: value)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityTitle)
        .accessibilityValue(value.formatted(.percent.precision(.fractionLength(0))))
    }
}

@available(iOS 26.0, macOS 26.0, *)
public extension ProgressRing where Label == Text {
    init(value: Double, tint: Color = .accentColor, lineWidth: CGFloat = 8,
         accessibilityLabel: String = "Progress") {
        self.init(value: value, tint: tint, lineWidth: lineWidth, accessibilityLabel: accessibilityLabel) {
            Text(SwiftBitsAnimation.clampedProgress(value), format: .percent.precision(.fractionLength(0)))
                .font(.headline).monospacedDigit()
        }
    }
}
