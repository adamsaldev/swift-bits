import SwiftUI

/// A compact summary that expands in place to reveal interactive detail content.
/// Keep summary content descriptive; put nested controls in `detail`.
@available(iOS 26.0, macOS 26.0, *)
public struct ExpandableCard<Summary: View, Detail: View>: View {
    @Binding private var isExpanded: Bool
    private let summary: Summary
    private let detail: Detail
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency

    public init(isExpanded: Binding<Bool>, @ViewBuilder summary: () -> Summary, @ViewBuilder detail: () -> Detail) {
        self._isExpanded = isExpanded
        self.summary = summary()
        self.detail = detail()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button { isExpanded.toggle() } label: {
                HStack {
                    summary.frame(maxWidth: .infinity, alignment: .leading)
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .accessibilityHidden(true)
                }
                .padding(20)
                .frame(minHeight: 44)
                .contentShape(.rect)
            }
            .buttonStyle(.plain)
            .accessibilityValue(isExpanded ? "Expanded" : "Collapsed")
            .accessibilityHint(isExpanded ? "Collapse details" : "Expand details")
            if isExpanded {
                detail.padding([.horizontal, .bottom], 20)
                    .transition(reduceMotion ? .identity : .opacity.combined(with: .move(edge: .top)))
            }
        }
        .background {
            if reduceTransparency { Rectangle().fill(.background) }
            else { Rectangle().fill(.regularMaterial) }
        }
        .clipShape(.rect(cornerRadius: 24))
        .overlay(RoundedRectangle(cornerRadius: 24).strokeBorder(.primary.opacity(0.12)))
        .animation(reduceMotion ? nil : .spring(response: 0.4, dampingFraction: 0.85), value: isExpanded)
    }
}
