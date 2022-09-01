//
//  ClosedRange+Clamp.swift
//  
//
//  Created by Jon Duenas on 9/1/22.
//

import Foundation

public extension ClosedRange {
    /// If the value is outside the bounds of the ClosedRange, returns the nearest bound. Otherwise, returns the value.
    func clamp(value: Bound) -> Bound {
        return lowerBound > value ? lowerBound
        : upperBound < value ? upperBound
        : value
    }
}

public extension Comparable {
    /// If self is outside the bounds of `limits`, returns the nearest bound. Otherwise, returns self.
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return limits.clamp(value: self)
    }
}
