import SwiftUI

/// A centered empty-state message with caller-owned recovery actions.
///
/// `title` and `message` are `LocalizedStringKey`; string literals are looked up in the
/// caller's bundle and interpolation is supported (for example `"No results for \(query)"`).
public struct EmptyState<Actions: View>: View {
    private let title: LocalizedStringKey
    private let systemImage: String
    private let message: LocalizedStringKey
    private let actions: Actions

    public init(_ title: LocalizedStringKey, systemImage: String, message: LocalizedStringKey,
                @ViewBuilder actions: () -> Actions) {
        self.title = title
        self.systemImage = systemImage
        self.message = message
        self.actions = actions()
    }

    public var body: some View {
        VStack(spacing: 12) {
            Image(systemName: systemImage)
                .font(.largeTitle)
                .foregroundStyle(.secondary)
                .accessibilityHidden(true)
            Text(title).font(.title3.bold()).accessibilityAddTraits(.isHeader)
            Text(message).foregroundStyle(.secondary)
            actions.padding(.top, 4)
        }
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
        .padding(24)
    }
}

public extension EmptyState where Actions == EmptyView {
    init(_ title: LocalizedStringKey, systemImage: String, message: LocalizedStringKey) {
        self.init(title, systemImage: systemImage, message: message) { EmptyView() }
    }
}
