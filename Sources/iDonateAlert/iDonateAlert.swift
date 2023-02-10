//
//  iDonateAlert.swift
//  iDonateAlert
//
//  Created by Rashid Ramazanov on 10.02.2023.
//

import Foundation
import UIKit

public final class iDonateAlert {
    // swiftlint:disable nesting
    public struct Button {
        var title: String
        var type: Button.ActionType
        var defaultTitleColor: UIColor?
        var action: AlertAction?
        var borderColor: UIColor?
        var backgroundColor: UIColor?

        public init(
            title: String,
            type: Button.ActionType,
            titleColor: UIColor? = .primary,
            borderColor: UIColor? = .clear,
            backgroundColor: UIColor? = .clear,
            action: AlertAction? = nil
        ) {
            self.title = title
            self.type = type
            defaultTitleColor = titleColor
            self.borderColor = borderColor
            self.backgroundColor = backgroundColor
            self.action = action
        }

        public enum ActionType {
            case `default`, destructive, custom
        }

        public typealias AlertAction = (Button) -> Void
    }

    // swiftlint:enable nesting

    var icon: UIImage?
    var title: String?
    var message: String?
    var titleFont: UIFont?
    var buttons: [Button] = []
    var attributedTitle: NSAttributedString?
    var attributedMessage: NSAttributedString?

    public init(
        icon: UIImage? = nil,
        title: String,
        message: String,
        titleFont: UIFont? = nil
    ) {
        self.icon = icon
        self.title = title
        self.message = message
        self.titleFont = titleFont
    }
    
    public init(
        icon: UIImage? = nil,
        attributedTitle: NSAttributedString? = nil,
        attributedMessage: NSAttributedString? = nil
    ) {
        self.icon = icon
        self.attributedTitle = attributedTitle ?? defaultAttributedTitle()
        self.attributedMessage = attributedMessage ?? defaultAttributedMessage()
    }

    public func addAction(_ button: Button) {
        buttons.append(button)
    }

    public func present(over viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let controller = UIStoryboard(name: "Alert", bundle: .module)
            .instantiateInitialViewController() as? AlertViewController else {
            fatalError("AlertViewController could not be initialized")
        }
        controller.alertIcon = icon
        controller.alertTitle = title
        controller.alertMessage = message
        controller.titleFont = titleFont
        controller.alertButtons = buttons
        controller.attributedTitle = attributedTitle
        controller.attributedMessage = attributedMessage
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        viewController.present(controller, animated: animated, completion: completion)
    }
    
    private func defaultAttributedTitle() -> NSAttributedString {
        let title = NSMutableAttributedString()
        // TODO: prepare
        return title
    }
    
    private func defaultAttributedMessage() -> NSAttributedString {
        let message = NSMutableAttributedString()
        // TODO: prepare
        return message
    }
}

