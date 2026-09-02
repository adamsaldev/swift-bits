import XCTest
@testable import SwiftBits

final class AnimationMathTests: XCTestCase {
    func testProgressIsClampedToUnitRange() {
        XCTAssertEqual(SwiftBitsAnimation.clampedProgress(-0.5), 0)
        XCTAssertEqual(SwiftBitsAnimation.clampedProgress(0.4), 0.4)
        XCTAssertEqual(SwiftBitsAnimation.clampedProgress(1.5), 1)
    }
}
