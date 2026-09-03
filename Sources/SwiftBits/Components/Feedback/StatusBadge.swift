import SwiftUI

/// A compact informational label. Status is communicated by text and symbol, never color alone.
@available(iOS 26.0, macOS 26.0, *)
public struct StatusBadge: View {
    private let title: String
    private let systemImage: String
    private let tint: Color

    public init(_ title: String, systemImage: String = "circle.fill", tint: Color = .accentColor) {
        self.title = title
        self.systemImage = systemImage
        self.tint = tint
    }

    public var body: some View {
        Label(title, systemImage: systemImage)
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(tint.opacity(0.12), in: .capsule)
            .overlay(Capsule().strokeBorder(tint.opacity(0.4)))
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(title)
    }
}
