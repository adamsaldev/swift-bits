import SwiftUI

/// A shared header over native tabs, each with its own retained vertical scroll view.
/// Scroll down to collapse and up to restore. `header` receives collapse progress in 0...1.
/// Supply unscrolled content: this component owns the ScrollView for each tab.
@available(iOS 26.0, macOS 26.0, *)
public struct CollapsingHeader<ID: Hashable, Header: View, TabLabel: View, Content: View>: View {
    private let tabs: [ID]
    @Binding private var selection: ID
    private let expandedHeight: CGFloat
    private let collapsedHeight: CGFloat
    private let header: (Double) -> Header
    private let tabLabel: (ID) -> TabLabel
    private let content: (ID) -> Content
    @State private var collapse: CGFloat = 0
    @State private var offsets: [ID: CGFloat] = [:]

    public init(tabs: [ID], selection: Binding<ID>, expandedHeight: CGFloat = 180, collapsedHeight: CGFloat = 64,
                @ViewBuilder header: @escaping (Double) -> Header,
                @ViewBuilder tabLabel: @escaping (ID) -> TabLabel,
                @ViewBuilder content: @escaping (ID) -> Content) {
        self.tabs = tabs
        self._selection = selection
        let expanded = expandedHeight.isFinite ? max(expandedHeight, 0) : 180
        self.expandedHeight = expanded
        self.collapsedHeight = collapsedHeight.isFinite ? min(max(collapsedHeight, 0), expanded) : min(64, expanded)
        self.header = header
        self.tabLabel = tabLabel
        self.content = content
    }

    public var body: some View {
        TabView(selection: $selection) {
            ForEach(tabs, id: \.self) { tab in
                ScrollView {
                    content(tab)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .onScrollGeometryChange(for: CGFloat.self) { geometry in
                    // Ignore overscroll at either end, which should not move the header.
                    let maximum = max(0, geometry.contentSize.height + geometry.contentInsets.top + geometry.contentInsets.bottom - geometry.containerSize.height)
                    return min(max(0, geometry.contentOffset.y + geometry.contentInsets.top), maximum)
                } action: { _, offset in
                    let previous = offsets[tab] ?? offset
                    offsets[tab] = offset
                    guard selection == tab else { return }
                    collapse = HeaderScrollMath.collapse(current: collapse, previousOffset: previous,
                                                         offset: offset, range: range)
                }
                .tag(tab)
                .tabItem { tabLabel(tab) }
            }
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            header(range > 0 ? Double(collapse / range) : 0)
                .frame(maxWidth: .infinity)
                .frame(height: expandedHeight - collapse)
                .clipped()
        }
        .onChange(of: selection) { _, selected in
            // A tab at the top must never inherit a collapsed header from another tab.
            if (offsets[selected] ?? 0) <= 0 { collapse = 0 }
        }
        .onChange(of: range) { _, newRange in collapse = min(collapse, newRange) }
    }

    private var range: CGFloat { expandedHeight - collapsedHeight }
}

internal enum HeaderScrollMath {
    static func collapse(current: CGFloat, previousOffset: CGFloat, offset: CGFloat, range: CGFloat) -> CGFloat {
        guard offset > 0 else { return 0 }
        return min(max(current + offset - previousOffset, 0), max(range, 0))
    }
}
