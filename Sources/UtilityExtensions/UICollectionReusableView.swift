//
//  UICollectionReusableView.swift
//  
//
//  Created by Jon Duenas on 8/31/22.
//

import UIKit

public extension UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    static var elementKind: String {
        return "\(String(describing: self))-element-kind"
    }
}
