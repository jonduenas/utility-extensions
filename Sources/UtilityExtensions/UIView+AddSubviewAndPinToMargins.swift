//
//  UIView+AddSubviewAndPinToMargins.swift
//  
//
//  Created by Jon Duenas on 9/1/22.
//

import UIKit

public extension UIView {
    /// Adds a subview to view with new leading, trailing, top, and bottom constraints relative to the view's margins.
    func addSubviewAndPinToMargins(
        _ view: UIView,
        leading: Double = 0,
        trailing: Double = 0,
        top: Double = 0,
        bottom: Double = 0
    ) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: leading),
            view.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: top),
            layoutMarginsGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing),
            layoutMarginsGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)
        ])
    }
}
