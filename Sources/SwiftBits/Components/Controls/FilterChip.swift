import SwiftUI

/// A selectable, wrapping-friendly filter with native button and selection semantics.
public struct FilterChip: View {
    private let title: Text
    private let systemImage: String?
    private let tint: Color
    @Binding private var isSelected: Bool
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.isEnabled) private var isEnabled

    public init(_ titleKey: LocalizedStringKey, systemImage: String? = nil,
                isSelected: Binding<Bool>, tint: Color = .accentColor) {
        self.init(title: Text(titleKey), systemImage: systemImage, isSelected: isSelected, tint: tint)
    }

    public init(_ title: some StringProtocol, systemImage: String? = nil,
                isSelected: Binding<Bool>, tint: Color = .accentColor) {
        self.init(title: Text(title), systemImage: systemImage, isSelected: isSelected, tint: tint)
    }

    private init(title: Text, systemImage: String?, isSelected: Binding<Bool>, tint: Color) {
        self.title = title
        self.systemImage = systemImage
        self._isSelected = isSelected
        self.tint = tint
    }

    public var body: some View {
        Button { isSelected.toggle() } label: {
            HStack(spacing: 6) {
                if isSelected { Image(systemName: "checkmark").accessibilityHidden(true) }
                else if let systemImage { Image(systemName: systemImage).accessibilityHidden(true) }
                title
            }
            .font(.subheadline.weight(.medium))
            .padding(.horizontal, 14)
            .frame(minHeight: 44)
            .background(isSelected ? tint.opacity(0.16) : Color.secondary.opacity(0.08), in: .capsule)
            .overlay(Capsule().strokeBorder(isSelected ? tint : Color.secondary.opacity(0.35)))
            .contentShape(.capsule)
        }
        .buttonStyle(.plain)
        .opacity(isEnabled ? 1 : 0.5)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
        .animation(reduceMotion ? nil : .snappy(duration: 0.2), value: isSelected)
        .sensoryFeedback(.selection, trigger: isSelected)
    }
}
