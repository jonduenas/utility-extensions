//
//  UITraitEnvironment+isCompactWidth.swift
//  
//
//  Created by Jon Duenas on 9/1/22.
//

import UIKit

public extension UITraitEnvironment {
    /// Checks if the current environment `horizontalSizeClass` is `.compact`
    var isCompactWidth: Bool {
        return traitCollection.horizontalSizeClass == .compact
    }
}
