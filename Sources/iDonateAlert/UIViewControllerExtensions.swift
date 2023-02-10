//
//  UIViewControllerExtensions.swift
//
//
//  Created by Gizem Fitoz on 5.05.2021.
//

import UIKit

public extension UIViewController {
    func showErrorMessage(_ error: Error) {
        showMessage(title: "warning".localized, message: error.localizedDescription, actionTitle: "ok".localized)
    }

    func showErrorMessage(_ message: String) {
        showMessage(title: "warning".localized, message: message, actionTitle: "ok".localized)
    }

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
