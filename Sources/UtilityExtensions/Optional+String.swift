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
}
