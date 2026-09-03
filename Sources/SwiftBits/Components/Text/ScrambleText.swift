import SwiftUI

/// Resolves a temporary scramble into readable text. Changes to `text` replay the effect.
///
/// The effect operates on resolved characters, so `text` is a plain `String`. Pass an
/// already-localized value, for example `ScrambleText(String(localized: "Welcome"))`.
/// VoiceOver reads the final text, not the scramble.
public struct ScrambleText: View {
    private let text: String
    private let duration: TimeInterval
    private let characters: [Character]
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var displayed = ""

    public init(_ text: String, duration: TimeInterval = 0.8, characters: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") {
        self.text = text
        self.duration = duration.isFinite ? min(max(duration, 0), 60) : 0.8
        self.characters = Array(characters)
    }

    public var body: some View {
        Text(displayed.isEmpty ? text : displayed)
            .accessibilityLabel(text)
            .task(id: Configuration(text: text, duration: duration, characters: characters, reduced: reduceMotion)) {
                guard !reduceMotion, duration > 0, !characters.isEmpty else {
                    displayed = text
                    return
                }
                let source = Array(text)
                let frames = max(1, Int(duration * 30))
                for frame in 0...frames {
                    guard !Task.isCancelled else { return }
                    let resolved = source.count * frame / frames
                    displayed = String(source.enumerated().map { index, character in
                        index < resolved || character.isWhitespace ? character : characters.randomElement()!
                    })
                    if frame < frames {
                        do { try await Task.sleep(for: .seconds(duration / Double(frames))) }
                        catch { return }
                    }
                }
            }
    }

    private struct Configuration: Equatable {
        let text: String
        let duration: TimeInterval
        let characters: [Character]
        let reduced: Bool
    }
}
