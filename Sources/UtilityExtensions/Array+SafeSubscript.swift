//
//  Array+SafeSubscript.swift
//  
//
//  Created by Jon Duenas on 9/1/22.
//

import Foundation

public extension Array {
    /// Returns the Element at the index if it exists, and if not returns nil.
    subscript (safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
