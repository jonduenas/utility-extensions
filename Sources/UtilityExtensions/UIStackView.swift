//
//  File.swift
//  
//
//  Created by Jon Duenas on 8/31/22.
//

import UIKit

public extension UIStackView {
    /// Fully removes subview from UIStackView by passing the subview in to
    /// `removeArrangeSubview(_:)` and calling `.removeFromSuperview()`
    /// on the subview.
    func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }

    /// Calls `removeFully(view:)` on all subviews contained in `arrangedSubviews`.
    func removeFullyAllArrangedSubviews() {
        arrangedSubviews.forEach { view in
            removeFully(view: view)
        }
    }
}
