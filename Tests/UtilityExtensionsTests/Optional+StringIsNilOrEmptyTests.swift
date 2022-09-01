//
//  Optional+StringIsNilOrEmptyTests.swift
//  
//
//  Created by Jon Duenas on 9/1/22.
//

import XCTest
@testable import UtilityExtensions

class Optional_StringIsNilOrEmptyTests: XCTestCase {
    func test_isNilOrEmpty_validString() {
        let string: String? = "Test"
        let isNilOrEmpty = string.isNilOrEmpty

        XCTAssertFalse(isNilOrEmpty)
    }

    func test_isNilOrEmpty_nilString() {
        let string: String? = nil
        let isNilOrEmpty = string.isNilOrEmpty

        XCTAssertTrue(isNilOrEmpty)
    }

    func test_isNilOrEmpty_emptyString() {
        let string: String? = ""
        let isNilOrEmpty = string.isNilOrEmpty

        XCTAssertTrue(isNilOrEmpty)
    }
}
