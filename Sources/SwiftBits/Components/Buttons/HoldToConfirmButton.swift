import SwiftUI

/// Fires once after a continuous hold; releasing early or leaving the control cancels it.
/// VoiceOver and keyboard activation use an explicit second activation to confirm.
@available(iOS 26.0, macOS 26.0, *)
public struct HoldToConfirmButton: View {
    private let title: String
    private let duration: TimeInterval
    private let tint: Color
    private let action: () -> Void
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.scenePhase) private var scenePhase
    @State private var holding = false
    @State private var progress = 0.0
    @State private var completed = false
    @State private var armed = false
    @State private var cancelledTouch = false

    public init(_ title: String = "Hold to confirm", duration: TimeInterval = 1.2,
                tint: Color = .accentColor, action: @escaping () -> Void) {
        self.title = title
        self.duration = duration.isFinite ? min(max(duration, 0.1), 60) : 1.2
        self.tint = tint
        self.action = action
    }

    public var body: some View {
        Button {
            guard !holding, !completed else { return }
            if armed { armed = false; action() } else { armed = true }
        } label: {
            Text(armed ? "Activate again to confirm" : title)
                .fontWeight(.semibold)
                .padding(.horizontal, 20)
                .frame(minHeight: 44)
                .background {
                    GeometryReader { proxy in
                        tint.opacity(0.3).frame(width: proxy.size.width * progress)
                    }
                }
                .background(tint.opacity(0.12))
                .clipShape(.rect(cornerRadius: 14))
                .contentShape(.rect)
                .overlay {
                    GeometryReader { proxy in
                        Color.clear.contentShape(.rect)
                            .gesture(DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    guard isEnabled, !completed, !cancelledTouch else { return }
                                    let inside = CGRect(origin: .zero, size: proxy.size).contains(value.location)
                                    if inside && !holding { armed = false; holding = true }
                                    if !inside { cancelledTouch = true; cancel() }
                                }
                                .onEnded { _ in cancel(); cancelledTouch = false })
                    }
                    .accessibilityHidden(true)
                }
        }
        .buttonStyle(.plain)
        .accessibilityValue(armed ? "Awaiting confirmation" : "")
        .accessibilityHint("Activate twice to confirm, or touch and hold.")
        .task(id: holding) {
            guard holding else { return }
            let clock = ContinuousClock()
            let start = clock.now
            while !Task.isCancelled && holding && isEnabled && scenePhase == .active {
                let elapsed = start.duration(to: clock.now)
                progress = min(1, Double(elapsed.components.seconds) / duration + Double(elapsed.components.attoseconds) / 1e18 / duration)
                if progress >= 1 {
                    completed = true
                    action()
                    return
                }
                do { try await Task.sleep(for: .milliseconds(16)) } catch { return }
            }
        }
        .task(id: armed) {
            guard armed else { return }
            do { try await Task.sleep(for: .seconds(5)) } catch { return }
            armed = false
        }
        .onChange(of: isEnabled) { _, enabled in if !enabled { cancel(); armed = false } }
        .onChange(of: scenePhase) { _, phase in if phase != .active { cancel(); armed = false } }
        .onDisappear { cancel(); armed = false }
    }

    private func cancel() {
        holding = false
        completed = false
        progress = 0
    }
}
