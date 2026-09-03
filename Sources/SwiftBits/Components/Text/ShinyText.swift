import SwiftUI

/// Text with a soft specular highlight that sweeps across it on a loop.
///
/// The sweep pauses under Reduce Motion and the text stays fully legible either way.
/// VoiceOver reads the string as a single element.
public struct ShinyText: View {
    private let content: Text
    private let base: Color
    private let highlight: Color
    private let duration: TimeInterval
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init(_ titleKey: LocalizedStringKey, base: Color = .secondary,
                highlight: Color = .primary, duration: TimeInterval = 2.4) {
        self.init(content: Text(titleKey), base: base, highlight: highlight, duration: duration)
    }

    public init(_ title: some StringProtocol, base: Color = .secondary,
                highlight: Color = .primary, duration: TimeInterval = 2.4) {
        self.init(content: Text(title), base: base, highlight: highlight, duration: duration)
    }

    private init(content: Text, base: Color, highlight: Color, duration: TimeInterval) {
        self.content = content
        self.base = base
        self.highlight = highlight
        self.duration = duration.isFinite ? min(max(duration, 0.2), 30) : 2.4
    }

    public var body: some View {
        content
            .foregroundStyle(base)
            .overlay {
                if !reduceMotion {
                    TimelineView(.animation) { context in
                        let elapsed = context.date.timeIntervalSinceReferenceDate
                        let phase = elapsed.truncatingRemainder(dividingBy: duration) / duration
                        content
                            .foregroundStyle(highlight)
                            .mask {
                                GeometryReader { proxy in
                                    let width = proxy.size.width
                                    let band = max(width * 0.35, 1)
                                    LinearGradient(colors: [.clear, .white, .clear],
                                                   startPoint: .leading, endPoint: .trailing)
                                        .frame(width: band)
                                        .offset(x: -band + phase * (width + band))
                                }
                            }
                    }
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(content)
    }
}
