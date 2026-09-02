import SwiftUI

/// A button whose caller controls idle, loading, success, and failure states.
@available(iOS 26.0, macOS 26.0, *)
public struct MorphingButton: View {
    public enum State: String, Sendable, CaseIterable {
        case idle, loading, success, failure
    }

    private let title: String
    private let state: State
    private let tint: Color
    private let action: () -> Void
    private let loadingTitle: String
    private let successTitle: String
    private let failureTitle: String
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init(_ title: String, state: State, tint: Color = .accentColor,
                loadingTitle: String = "Loading", successTitle: String = "Done", failureTitle: String = "Try again",
                action: @escaping () -> Void) {
        self.title = title
        self.state = state
        self.tint = tint
        self.loadingTitle = loadingTitle
        self.successTitle = successTitle
        self.failureTitle = failureTitle
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            ZStack {
                // Reserve the largest label, including localized result strings.
                ForEach(State.allCases, id: \.self) { candidate in
                    Label(label(for: candidate), systemImage: "checkmark.circle.fill").hidden()
                }
                HStack {
                    if state == .loading { ProgressView().controlSize(.small) }
                    if state == .success { Image(systemName: "checkmark.circle.fill") }
                    if state == .failure { Image(systemName: "exclamationmark.circle.fill") }
                    Text(label(for: state))
                }
                .id(state)
                .transition(.opacity.combined(with: .scale(scale: reduceMotion ? 1 : 0.9)))
            }
            .fontWeight(.semibold)
            .padding(.horizontal, 16)
            .frame(minHeight: 44)
            .background(tint.opacity(0.15), in: RoundedRectangle(cornerRadius: state == .loading ? 22 : 14))
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
        .disabled(state == .loading || state == .success)
        .animation(reduceMotion ? nil : .snappy, value: state)
        .accessibilityLabel(label(for: state))
    }

    private func label(for state: State) -> String {
        switch state {
        case .idle: title
        case .loading: loadingTitle
        case .success: successTitle
        case .failure: failureTitle
        }
    }
}
