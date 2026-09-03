import XCTest
@testable import SwiftBits

final class AnimationMathTests: XCTestCase {
    func testNonFiniteProgressCannotProduceInvalidGeometry() {
        XCTAssertEqual(SwiftBitsAnimation.clampedProgress(.nan), 0)
        XCTAssertEqual(SwiftBitsAnimation.clampedProgress(.infinity), 1)
        XCTAssertEqual(SwiftBitsAnimation.clampedProgress(-.infinity), 0)
    }

    func testProgressIsClampedToUnitRange() {
        XCTAssertEqual(SwiftBitsAnimation.clampedProgress(-0.5), 0)
        XCTAssertEqual(SwiftBitsAnimation.clampedProgress(0.4), 0.4)
        XCTAssertEqual(SwiftBitsAnimation.clampedProgress(1.5), 1)
    }
}
