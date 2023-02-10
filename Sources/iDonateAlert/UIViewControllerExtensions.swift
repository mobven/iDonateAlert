//
//  UIViewControllerExtensions.swift
//
//
//  Created by Gizem Fitoz on 5.05.2021.
//

import UIKit

public extension UIViewController {
    func showMessage(
        title: String,
        message: String,
        actionTitle: String,
        action: iDonateAlert.Button.AlertAction? = nil
    ) {
        let alert = iDonateAlert(title: title, message: message)
        alert.addAction(.init(title: actionTitle, type: .destructive, action: action))
        alert.present(over: self)
    }
}
