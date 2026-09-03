import SwiftUI

/// Redacts the supplied layout while loading, preserving its sizing and spacing.
/// Supply representative placeholder content so SwiftUI can measure the final layout.
/// Custom shapes and images can opt into placeholders with `.redacted(reason: .placeholder)`.
public struct SkeletonView<Content: View>: View {
    private let isLoading: Bool
    private let shimmer: Bool
    private let loadingLabel: LocalizedStringKey?
    private let content: Content
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    /// `loadingLabel` is the accessibility label announced while loading; when `nil` a
    /// localized "Loading" provided by SwiftBits is used.
    public init(isLoading: Bool = true, shimmer: Bool = true, loadingLabel: LocalizedStringKey? = nil,
                @ViewBuilder content: () -> Content) {
        self.isLoading = isLoading
        self.shimmer = shimmer
        self.loadingLabel = loadingLabel
        self.content = content()
    }

    private var accessibilityText: Text {
        loadingLabel.map { Text($0) } ?? Text("Loading", bundle: .module)
    }

    public var body: some View {
        if isLoading {
            content
                .redacted(reason: .placeholder)
                .shimmer(active: shimmer && !reduceMotion)
                .disabled(true)
                .allowsHitTesting(false)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(accessibilityText)
        } else {
            content
        }
    }
}
