import XCTest
@testable import SwiftBits

final class HeaderScrollMathTests: XCTestCase {
    func testDownwardScrollCollapsesAndClamps() {
        XCTAssertEqual(HeaderScrollMath.collapse(current: 20, previousOffset: 100, offset: 150, range: 116), 70)
        XCTAssertEqual(HeaderScrollMath.collapse(current: 100, previousOffset: 150, offset: 250, range: 116), 116)
    }

    func testUpwardScrollRestoresBeforeReachingTop() {
        XCTAssertEqual(HeaderScrollMath.collapse(current: 116, previousOffset: 500, offset: 450, range: 116), 66)
        XCTAssertEqual(HeaderScrollMath.collapse(current: 20, previousOffset: 500, offset: 450, range: 116), 0)
    }

    func testTopAndZeroRangeAlwaysRestore() {
        XCTAssertEqual(HeaderScrollMath.collapse(current: 116, previousOffset: 400, offset: 0, range: 116), 0)
        XCTAssertEqual(HeaderScrollMath.collapse(current: 0, previousOffset: 0, offset: 100, range: 0), 0)
    }

    func testUnchangedOffsetDoesNotShiftSharedHeader() {
        XCTAssertEqual(HeaderScrollMath.collapse(current: 64, previousOffset: 200, offset: 200, range: 116), 64)
    }
}
