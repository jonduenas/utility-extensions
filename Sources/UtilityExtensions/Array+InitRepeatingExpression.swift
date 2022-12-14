//
//  Array+InitRepeatingExpression.swift
//  
//
//  Created by Jon Duenas on 8/30/22.
//  Source: https://nemecek.be/blog/60/implementing-loadingshimmer-with-diffable-data-source#extension-for-cleaner-usage


import Foundation

public extension Array {
    /// Creates array by repeating an expression that creates an element and adds to the array for a set amount of times.
    /// Different from init(repeating:count:) that repeats the same exact element. For example, creating an element using UUID(),
    /// this initializer would create new unique UUIDs each time the amount of the count, while init(repeating:count:) would create
    /// one UUID and repeat the same one for the count amount.
    ///
    /// - Parameters:
    ///    - expression: A closure that creates and returns an individual element to be inserted into the Array.
    ///    - count: The amount of times the expression should be repeated and inserted into the array.
    init(repeatingExpression expression: @autoclosure (() -> Element), count: Int) {
        var temp = [Element]()
        for _ in 0..<count {
            temp.append(expression())
        }
        self = temp
    }
}
