//
//  UIApplication.swift
//  
//
//  Created by Jon Duenas on 8/31/22.
//

import UIKit

public extension UIApplication {
    @available(iOS 13.0, *)
    var foregroundActiveScene: UIWindowScene? {
        connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
    }
}
