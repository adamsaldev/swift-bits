import SwiftUI

/// A centered empty-state message with caller-owned recovery actions.
@available(iOS 26.0, macOS 26.0, *)
public struct EmptyState<Actions: View>: View {
    private let title: String
    private let systemImage: String
    private let message: String
    private let actions: Actions

    public init(_ title: String, systemImage: String, message: String,
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

@available(iOS 26.0, macOS 26.0, *)
public extension EmptyState where Actions == EmptyView {
    init(_ title: String, systemImage: String, message: String) {
        self.init(title, systemImage: systemImage, message: message) { EmptyView() }
    }
}
