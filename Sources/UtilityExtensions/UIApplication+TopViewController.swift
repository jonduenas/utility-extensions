//
//  UIApplication+TopViewController.swift
//  
//
//  Created by Jon Duenas on 9/1/22.
//

import UIKit

public extension UIApplication {
    @available(iOS 13.0, *)
    var topWindow: UIWindow? {
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first(where: \.isKeyWindow)
    }

    @available(iOS 13.0, *)
    func topViewController(controller: UIViewController? = UIApplication.shared.topWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

