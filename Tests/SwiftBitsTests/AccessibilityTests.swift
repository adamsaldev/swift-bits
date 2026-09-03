import SwiftUI
import ViewInspector
import XCTest
@testable import SwiftBits

/// Structural accessibility checks with ViewInspector. These assert the contract the
/// components promise (labels, values, tap behaviour) without rendering pixels.
@MainActor
final class AccessibilityTests: XCTestCase {
    func testStatusBadgeExposesTitleAsItsAccessibilityLabel() throws {
        let badge = StatusBadge("Synced", systemImage: "checkmark.circle.fill", tint: .green)
        let label = try badge.inspect().find(ViewType.Label.self)
        XCTAssertEqual(try label.accessibilityLabel().string(), "Synced")
        XCTAssertNoThrow(try badge.inspect().find(text: "Synced"))
    }

    func testFilterChipTogglesItsBindingWhenTapped() throws {
        var selected = false
        let binding = Binding(get: { selected }, set: { selected = $0 })
        let chip = FilterChip("Favorites", systemImage: "star", isSelected: binding)

        try chip.inspect().find(ViewType.Button.self).tap()
        XCTAssertTrue(selected)
    }

    func testFilterChipHidesItsDecorativeSymbolFromVoiceOver() throws {
        let chip = FilterChip("Favorites", systemImage: "star", isSelected: .constant(false))
        let image = try chip.inspect().find(ViewType.Image.self)
        XCTAssertTrue(try image.accessibilityHidden())
    }

    func testProgressRingClampsValueAndFormatsAccessiblePercentage() throws {
        let hundredPercent = 1.0.formatted(.percent.precision(.fractionLength(0)))
        let zeroPercent = 0.0.formatted(.percent.precision(.fractionLength(0)))

        let ring = ProgressRing(value: 1.8, accessibilityLabel: "Upload")
        XCTAssertNoThrow(try ring.inspect().find(where: { (try? $0.accessibilityLabel().string()) == "Upload" }))
        XCTAssertNoThrow(try ring.inspect().find(where: { (try? $0.accessibilityValue().string()) == hundredPercent }))

        let nanRing = ProgressRing(value: .nan)
        XCTAssertNoThrow(try nanRing.inspect().find(where: { (try? $0.accessibilityValue().string()) == zeroPercent }))
    }

    func testEmptyStateShowsTitleMessageAndHidesTheSymbol() throws {
        let state = EmptyState("Nothing here", systemImage: "tray", message: "Add an item to get started.")
        XCTAssertNoThrow(try state.inspect().find(text: "Nothing here"))
        XCTAssertNoThrow(try state.inspect().find(text: "Add an item to get started."))
        XCTAssertTrue(try state.inspect().find(ViewType.Image.self).accessibilityHidden())
    }

    func testSkeletonViewAnnouncesLoadingWhileKeepingPlaceholderLayout() throws {
        let skeleton = SkeletonView(isLoading: true) { Text("Placeholder name") }
        XCTAssertNoThrow(try skeleton.inspect().find(where: { (try? $0.accessibilityLabel().string()) == "Loading" }))
        XCTAssertNoThrow(try skeleton.inspect().find(text: "Placeholder name"))
    }

    func testSkeletonViewPassesContentThroughWhenNotLoading() throws {
        let skeleton = SkeletonView(isLoading: false) { Text("Ada Lovelace") }
        XCTAssertNoThrow(try skeleton.inspect().find(text: "Ada Lovelace"))
        XCTAssertThrowsError(try skeleton.inspect().find(where: { (try? $0.accessibilityLabel().string()) == "Loading" }))
    }

    func testScrambleTextKeepsFinalStringAsItsAccessibleLabel() throws {
        let scramble = ScrambleText("Launch")
        XCTAssertEqual(try scramble.inspect().find(ViewType.Text.self).accessibilityLabel().string(), "Launch")
    }

    func testShinyTextIsOneAccessibleElementWithTheFullString() throws {
        let shiny = ShinyText("Now shipping")
        XCTAssertNoThrow(try shiny.inspect().find(where: {
            (try? $0.accessibilityLabel().string()) == "Now shipping"
        }))
    }

    func testStarBorderKeepsContentAndItsAccessibility() throws {
        let bordered = Text("Bordered").starBorder()
        XCTAssertNoThrow(try bordered.inspect().find(text: "Bordered"))
    }

    func testClickSparkDoesNotDisturbContent() throws {
        let sparkly = Text("Tap me").clickSpark()
        XCTAssertNoThrow(try sparkly.inspect().find(text: "Tap me"))
    }

    func testHoldToConfirmButtonProvidesAConfirmationHint() throws {
        let button = HoldToConfirmButton("Delete") { }
        XCTAssertNoThrow(try button.inspect().find(ViewType.Button.self))
        XCTAssertNoThrow(try button.inspect().find(where: {
            (try? $0.accessibilityHint().string()) == "Activate twice to confirm, or touch and hold."
        }))
    }
}
