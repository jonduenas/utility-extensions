//
//  Optional+String.swift
//  
//
//  Created by Jon Duenas on 8/30/22.
//

import Foundation

public extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        switch self {
        case .none: return true
        case .some(let str):
            return str.isEmpty
        }
    }

    func unwrappedNotEmpty(or defaultString: String) -> String {
        switch self {
        case .none:
            return defaultString
        case .some(let string):
            if string.isEmpty {
                return defaultString
            } else {
                return string
            }
        }
    }
}
