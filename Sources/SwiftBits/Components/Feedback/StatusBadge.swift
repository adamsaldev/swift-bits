import SwiftUI

/// A compact informational label. Status is communicated by text and symbol, never color alone.
public struct StatusBadge: View {
    private let title: Text
    private let systemImage: String
    private let tint: Color

    public init(_ titleKey: LocalizedStringKey, systemImage: String = "circle.fill", tint: Color = .accentColor) {
        self.init(title: Text(titleKey), systemImage: systemImage, tint: tint)
    }

    public init(_ title: some StringProtocol, systemImage: String = "circle.fill", tint: Color = .accentColor) {
        self.init(title: Text(title), systemImage: systemImage, tint: tint)
    }

    private init(title: Text, systemImage: String, tint: Color) {
        self.title = title
        self.systemImage = systemImage
        self.tint = tint
    }

    public var body: some View {
        Label { title } icon: { Image(systemName: systemImage) }
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(tint.opacity(0.12), in: .capsule)
            .overlay(Capsule().strokeBorder(tint.opacity(0.4)))
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(title)
    }
}
