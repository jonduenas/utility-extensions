//
//  UIButton+MenuConfig.swift
//  
//
//  Created by Jon Duenas on 9/1/22.
//

import UIKit

public extension UIButton {
    struct MenuButtonConfig {
        let title: String
        var isSelected: Bool = false
        let action: () -> Void
    }

    /// Configures a  `UIMenu` for the button that presents when tapped and allows a single selected element. If targeting
    /// iOS 13 and earlier, use the `configureMenuButton(actions:presentActionSheet:)` instead to support
    /// showing the menu as a `UIAlertController` action sheet instead.
    /// 
    /// - Parameter actions: An array of `MenuButtonConfig` mapped to `UIMenuElement` and passed into
    ///   the `UIMenu` initializer's `children` parameter.
    @available(iOS 14.0, *)
    func configureMenuButton(actions: [MenuButtonConfig]) {
        configureMenu(actions: actions)
        if #available(iOS 15.0, *) {
            self.changesSelectionAsPrimaryAction = true
        }
    }

    /// Configures a  `UIMenu` for the button that presents when tapped and allows a single selected element. On iOS versions
    /// 13 and earlier, presents as an action sheet with no current selection indicator visible.
    ///
    /// - Parameters:
    ///    - actions: An array of `MenuButtonConfig` mapped to `UIMenuElement` and passed into
    ///      the `UIMenu` initializer's `children` parameter.
    ///    - presentActionSheet: A closure only used to present a `UIAlertController.actionSheet`
    ///      instead of a `UIMenu` on iOS devices using iOS 13 and earlier. The provided `UIAlertController`
    ///      should be presented by the parent view controller inside the closure.
    func configureMenuButton(actions: [MenuButtonConfig], presentActionSheet: @escaping (UIAlertController?) -> Void) {
        if #available(iOS 14.0, *) {
            configureMenu(actions: actions)
            if #available(iOS 15.0, *) {
                self.changesSelectionAsPrimaryAction = true
            }
        } else {
            self.presentActionSheet = presentActionSheet
            configureActionSheet(actions: actions)
        }
    }

    @available(iOS 14.0, *)
    private func configureMenu(actions: [MenuButtonConfig]) {
        let menuItems = actions.map { config -> UIMenuElement in
            let action = UIAction(title: config.title) { [weak self] _ in
                config.action()
                if #available(iOS 15.0, *) {
                    // iOS 15 changes the button title automatically with changesSelectionAsPrimaryAction = true
                    return
                } else {
                    // iOS 14 only. Need to manually set the title to the selected item.
                    self?.setTitle(config.title, for: .normal)
                }
            }
            if config.isSelected {
                action.state = .on
            } else {
                action.state = .off
            }
            return action
        }
        let menu: UIMenu = {
            if #available(iOS 15, *) {
                return UIMenu(title: "", options: .singleSelection, children: menuItems)
            } else {
                return UIMenu(title: "", options: .displayInline, children: menuItems)
            }
        }()
        self.menu = menu
        self.showsMenuAsPrimaryAction = true
    }
}

// MARK: iOS 13 Action Sheet

extension UIButton {
    private var actionSheet: UIAlertController? {
        get {
            return objc_getAssociatedObject(self, &UIButtonActionSheetAssociatedObjectHandle) as? UIAlertController
        }
        set {
            objc_setAssociatedObject(self, &UIButtonActionSheetAssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var presentActionSheet: ((UIAlertController?) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &UIButtonPresentActionSheetObjectHandle) as? ((UIAlertController?) -> Void)
        }
        set {
            objc_setAssociatedObject(self, &UIButtonPresentActionSheetObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
    }

    private func configureActionSheet(actions: [MenuButtonConfig]) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actions.forEach { config in
            let alertAction = UIAlertAction(title: config.title, style: .default) { [weak self] _ in
                config.action()
                self?.setTitle(config.title, for: .normal)
            }
            alertController.addAction(alertAction)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        self.actionSheet = alertController
        self.addTarget(self, action: #selector(actionSheetSelectorTapped(_:)), for: .touchUpInside)
    }

    /// Only used for showing action sheet on iOS 13
    @objc private func actionSheetSelectorTapped(_ sender: UIButton) {
        if #available(iOS 14.0, *) {
            return
        }

        guard let actionSheet = actionSheet else {
            return
        }

        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = self
            popoverController.sourceRect = CGRect(x: self.bounds.midX, y: self.bounds.midY, width: 0, height: 0)
        }

        self.presentActionSheet?(actionSheet)
    }
}

private var UIButtonActionSheetAssociatedObjectHandle: UInt8 = 0
private var UIButtonPresentActionSheetObjectHandle: UInt8 = 0
