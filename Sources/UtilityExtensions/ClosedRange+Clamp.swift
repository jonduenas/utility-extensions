//
//  ClosedRange+Clamp.swift
//  
//
//  Created by Jon Duenas on 9/1/22.
//

import Foundation

extension ClosedRange {
    func clamp(value: Bound) -> Bound {
        return lowerBound > value ? lowerBound : (upperBound < value ? upperBound : value)
    }
}
