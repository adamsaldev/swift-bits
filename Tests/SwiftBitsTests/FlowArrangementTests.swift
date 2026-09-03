import XCTest
@testable import SwiftBits

final class FlowArrangementTests: XCTestCase {
    func testWrapsUsingTallestItemAndRowSpacing() {
        let result = FlowArrangement(sizes: [.init(width: 40, height: 20), .init(width: 50, height: 30), .init(width: 20, height: 10)], width: 100, spacing: 8, rowSpacing: 12)
        XCTAssertEqual(result.frames.map(\.origin), [.zero, .init(x: 48, y: 0), .init(x: 0, y: 42)])
        XCTAssertEqual(result.size, .init(width: 100, height: 52))
    }

    func testExactFitStaysOnOneRow() {
        let result = FlowArrangement(sizes: [.init(width: 40, height: 20), .init(width: 52, height: 20)], width: 100, spacing: 8, rowSpacing: 12)
        XCTAssertEqual(result.size.height, 20)
    }

    func testUnspecifiedWidthUsesIntrinsicSingleRow() {
        let result = FlowArrangement(sizes: [.init(width: 40, height: 20), .init(width: 50, height: 30)], width: nil, spacing: 8, rowSpacing: 12)
        XCTAssertEqual(result.size, .init(width: 98, height: 30))
    }

    func testEmptyLayoutHasNoPhantomRow() {
        XCTAssertEqual(FlowArrangement(sizes: [], width: 100, spacing: 8, rowSpacing: 12).size, .init(width: 100, height: 0))
    }

    func testOversizedFirstItemDoesNotCreateEmptyRow() {
        let result = FlowArrangement(sizes: [.init(width: 120, height: 30)], width: 100, spacing: 8, rowSpacing: 12)
        XCTAssertEqual(result.frames.first?.origin, .zero)
        XCTAssertEqual(result.size.height, 30)
    }
}
