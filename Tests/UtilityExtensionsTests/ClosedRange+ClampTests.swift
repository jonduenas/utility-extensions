//
//  ClosedRange+ClampTests.swift
//  
//
//  Created by Jon Duenas on 9/1/22.
//

import XCTest
@testable import UtilityExtensions

class ClosedRange_ClampTests: XCTestCase {
    func test_clampValue_insideRangeReturnsValue() {
        let range = 0...10
        let clamped = range.clamp(value: 5)

        XCTAssertEqual(clamped, 5)
    }

    func test_clampValue_outsideRangeReturnsBounds() {
        let range = 0...10
        let clampedLower = range.clamp(value: -8)
        let clampedHigher = range.clamp(value: 50)

        XCTAssertEqual(clampedLower, 0)
        XCTAssertEqual(clampedHigher, 10)
    }

    func test_clampedInt_insideRangeReturnsSelf() {
        let value = 8
        let clamped = value.clamped(to: 0...10)

        XCTAssertEqual(value, clamped)
    }

    func test_clampedInt_outsideRangeReturnsBounds() {
        let upperValue = 123
        let clampedUpper = upperValue.clamped(to: 0...10)

        XCTAssertEqual(clampedUpper, 10)

        let lowerValue = -321
        let clampedLower = lowerValue.clamped(to: 0...10)

        XCTAssertEqual(clampedLower, 0)
    }
}
