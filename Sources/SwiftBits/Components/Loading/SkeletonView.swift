import SwiftUI

/// Redacts the supplied layout while loading, preserving its sizing and spacing.
/// Supply representative placeholder content so SwiftUI can measure the final layout.
/// Custom shapes and images can opt into placeholders with `.redacted(reason: .placeholder)`.
@available(iOS 26.0, macOS 26.0, *)
public struct SkeletonView<Content: View>: View {
    private let isLoading: Bool
    private let shimmer: Bool
    private let loadingLabel: String
    private let content: Content
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init(isLoading: Bool = true, shimmer: Bool = true, loadingLabel: String = "Loading",
                @ViewBuilder content: () -> Content) {
        self.isLoading = isLoading
        self.shimmer = shimmer
        self.loadingLabel = loadingLabel
        self.content = content()
    }

    public var body: some View {
        if isLoading {
            content
                .redacted(reason: .placeholder)
                .shimmer(active: shimmer && !reduceMotion)
                .disabled(true)
                .allowsHitTesting(false)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(loadingLabel)
        } else {
            content
        }
    }
}
