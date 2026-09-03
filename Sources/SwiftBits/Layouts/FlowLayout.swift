import SwiftUI

/// Places intrinsic-sized views in leading-aligned rows, wrapping at the proposed width.
/// Useful for tags and filters. Oversized items receive the available row width.
@available(iOS 26.0, macOS 26.0, *)
public struct FlowLayout: Layout {
    public var spacing: CGFloat
    public var rowSpacing: CGFloat
    public var layoutDirection: LayoutDirection

    public init(spacing: CGFloat = 8, rowSpacing: CGFloat = 8,
                layoutDirection: LayoutDirection = .leftToRight) {
        self.spacing = spacing.isFinite ? max(0, spacing) : 8
        self.rowSpacing = rowSpacing.isFinite ? max(0, rowSpacing) : 8
        self.layoutDirection = layoutDirection
    }

    public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        arrangement(width: proposal.width, subviews: subviews).size
    }

    public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = arrangement(width: bounds.width, subviews: subviews)
        for (index, rect) in result.frames.enumerated() {
            let x = layoutDirection == .rightToLeft ? bounds.maxX - rect.maxX : bounds.minX + rect.minX
            subviews[index].place(at: CGPoint(x: x, y: bounds.minY + rect.minY),
                                  anchor: .topLeading, proposal: ProposedViewSize(rect.size))
        }
    }

    private func arrangement(width: CGFloat?, subviews: Subviews) -> FlowArrangement {
        let limit = width.flatMap { $0.isFinite ? max(0, $0) : nil }
        let sizes = subviews.map { view in
            let ideal = view.sizeThatFits(.unspecified)
            if let limit, ideal.width > limit {
                return view.sizeThatFits(ProposedViewSize(width: limit, height: nil))
            }
            return ideal
        }
        return FlowArrangement(sizes: sizes, width: limit, spacing: spacing, rowSpacing: rowSpacing)
    }
}

struct FlowArrangement {
    let frames: [CGRect]
    let size: CGSize

    init(sizes: [CGSize], width: CGFloat?, spacing: CGFloat, rowSpacing: CGFloat) {
        var frames: [CGRect] = []
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0
        var usedWidth: CGFloat = 0
        for item in sizes {
            if x > 0, let width, x + item.width > width {
                x = 0
                y += rowHeight + rowSpacing
                rowHeight = 0
            }
            frames.append(CGRect(origin: CGPoint(x: x, y: y), size: item))
            usedWidth = max(usedWidth, x + item.width)
            rowHeight = max(rowHeight, item.height)
            x += item.width + spacing
        }
        self.frames = frames
        self.size = CGSize(width: width ?? usedWidth, height: sizes.isEmpty ? 0 : y + rowHeight)
    }
}
