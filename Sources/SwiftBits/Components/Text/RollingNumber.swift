import SwiftUI

/// A formatted number with native, vertical odometer transitions.
/// Supply `.percent` or a precision/grouping configuration through `format`.
@available(iOS 26.0, macOS 26.0, *)
public struct RollingNumber: View {
    private let value: Double
    private let format: FloatingPointFormatStyle<Double>
    private let animation: Animation
    private let percentDigits: Int?
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init(_ value: Double, format: FloatingPointFormatStyle<Double> = .number, animation: Animation = .snappy(duration: 0.45)) {
        self.value = value
        self.format = format
        self.animation = animation
        self.percentDigits = nil
    }

    /// Formats a fractional value as a percentage (for example, 0.42 becomes 42%).
    public init(percent value: Double, decimalPlaces: Int = 0, animation: Animation = .snappy(duration: 0.45)) {
        self.value = value
        self.format = .number.precision(.fractionLength(min(max(decimalPlaces, 0), 10)))
        self.animation = animation
        self.percentDigits = min(max(decimalPlaces, 0), 10)
    }

    public var body: some View {
        Text(formatted)
            .monospacedDigit()
            .contentTransition(.numericText(value: value))
            .animation(reduceMotion ? nil : animation, value: value)
            .accessibilityLabel(formatted)
    }

    private var formatted: String {
        if let percentDigits {
            return value.formatted(FloatingPointFormatStyle<Double>.Percent(locale: format.locale).precision(.fractionLength(percentDigits)))
        }
        return value.formatted(format)
    }
}
