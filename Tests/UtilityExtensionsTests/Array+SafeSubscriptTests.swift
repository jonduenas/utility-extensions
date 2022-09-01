//
//  Array+SafeSubscriptTests.swift
//  
//
//  Created by Jon Duenas on 9/1/22.
//

import XCTest
@testable import UtilityExtensions

class Array_SafeSubscriptTests: XCTestCase {
    func test_safeSubscript_ReturnsValidElement() {
        let array = [5, 10, 15, 20]
        let element = array[safe: 2]

        XCTAssertNotNil(element)
        XCTAssertEqual(element, 15)
    }

    func test_safeSubscript_ReturnsNilOutsideRange() {
        let array = [5, 10, 15, 20]
        let element = array[safe: 5]

        XCTAssertNil(element)
    }
}
