//
//  UIViewController.swift
//  
//
//  Created by Jon Duenas on 9/1/22.
//

import UIKit
import SafariServices

public extension UIViewController {
    /// Creates a `UIAlertController` with the preferred style of `.alert` and passes it in to the
    /// view controller's `present(:animated:)` method. If `actions` is left empty, a default action
    /// with the title "OK" is used.
    @MainActor
    func presentAlert(
        title: String?,
        message: String?,
        animated: Bool = true,
        actions: [UIAlertAction] = []
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        if actions.isEmpty {
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
        } else {
            actions.forEach { alert.addAction($0) }
        }

        present(alert, animated: animated)
    }

    /// Creates a new SFSafariViewController and passes it in to `present(:animated:completion:)`
    @MainActor
    func presentInSafariViewController(
        url: URL,
        animated: Bool = true,
        delegate: SFSafariViewControllerDelegate? = nil,
        completion: (() -> Void)? = nil
    ) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = delegate
        present(safariVC, animated: animated, completion: completion)
    }

    /// Creates a `UITapGestureRecognizer` with the view controller's root view as the target that calls the action `endEditing(_:)`.
    func setupHideKeyboardOnTap() {
        let tapRecognizer = UITapGestureRecognizer(
            target: view,
            action: #selector(view.endEditing(_:))
        )
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
}
