import SnapshotTesting
import SwiftUI
import XCTest
@testable import SwiftBits

/// Visual regression snapshots for the components whose resting state is deterministic
/// (no running animation, no time or pointer input). Rendered through `NSHostingView` on
/// macOS.
///
/// Reference images are committed under `__Snapshots__/`. A new Xcode or macOS version can
/// shift antialiasing enough to trip the comparison; `precision` is deliberately loose. To
/// refresh after an intentional visual change, set `isRecording = true` locally, run once,
/// review the diff, then set it back.
@MainActor
final class SnapshotTests: XCTestCase {
    private let strategy = Snapshotting<NSView, NSImage>.image(precision: 0.95, perceptualPrecision: 0.95)

    private func host(_ view: some View) -> NSView {
        let root = view
            .frame(width: 300, height: 150)
            .padding(24)
            .background(Color(white: 0.97))
        let hosting = NSHostingView(rootView: root)
        hosting.frame = CGRect(x: 0, y: 0, width: 348, height: 198)
        hosting.layoutSubtreeIfNeeded()
        return hosting
    }

    func testGlowButton() {
        assertSnapshot(of: host(GlowButton("Create something", tint: .indigo) { }), as: strategy)
    }

    func testStatusBadge() {
        assertSnapshot(of: host(StatusBadge("Synced", systemImage: "checkmark.circle.fill", tint: .green)), as: strategy)
    }

    func testFilterChipSelected() {
        assertSnapshot(of: host(FilterChip("Favorites", systemImage: "star", isSelected: .constant(true), tint: .orange)), as: strategy)
    }

    func testProgressRing() {
        assertSnapshot(of: host(ProgressRing(value: 0.72, tint: .indigo).frame(width: 120, height: 120)), as: strategy)
    }

    func testEmptyState() {
        assertSnapshot(of: host(EmptyState("No saved components", systemImage: "bookmark",
                                           message: "Save a component to find it here later.")), as: strategy)
    }
}
