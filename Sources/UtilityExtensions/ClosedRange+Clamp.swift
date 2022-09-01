//
//  ClosedRange+Clamp.swift
//  
//
//  Created by Jon Duenas on 9/1/22.
//

import Foundation

extension ClosedRange {
    func clamp(value: Bound) -> Bound {
        return lowerBound > value ? lowerBound
        : upperBound < value ? upperBound
        : value
    }
}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return limits.clamp(value: self)
    }
}
