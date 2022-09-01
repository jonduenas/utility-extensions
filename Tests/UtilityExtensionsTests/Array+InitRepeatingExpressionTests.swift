//
//  Array+InitRepeatingExpressionTests.swift
//  
//
//  Created by Jon Duenas on 9/1/22.
//

import XCTest
@testable import UtilityExtensions

class Array_InitRepeatingExpressionTests: XCTestCase {
    func test_initRepeatingExpression_UUID() {
        let array = Array(repeatingExpression: UUID(), count: 5)
        let set = Set(array)

        XCTAssertEqual(array.count, 5)
        XCTAssertEqual(array.count, set.count, "Each Element should be unique.")
    }
}
