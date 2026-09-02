/// Small, testable helpers shared by animated components.
public enum SwiftBitsAnimation {
    /// Constrains an animation progress value to the closed range `0...1`.
    public static func clampedProgress(_ value: Double) -> Double {
        min(max(value, 0), 1)
    }
}
