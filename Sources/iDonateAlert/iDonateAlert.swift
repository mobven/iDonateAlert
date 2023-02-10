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
        var title: String?
        var image: UIImage?
        var defaultTitleColor: UIColor?
        var action: AlertAction?
        var borderColor: UIColor?
        var backgroundColor: UIColor?

        public init(
            title: String?,
            image: UIImage?,
            titleColor: UIColor? = .baseDonateTextColor,
            borderColor: UIColor? = .clear,
            backgroundColor: UIColor? = .clear,
            action: AlertAction? = nil
        ) {
            self.title = title
            self.image = image
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
        self.icon = icon ?? UIImage(named: "heart", in: .module)
        self.title = title
        self.message = message
        self.titleFont = titleFont
        self.buttons = [.ahbap, .afad, .kizilay]
    }
    
    public init(
        icon: UIImage? = nil,
        attributedTitle: NSAttributedString? = nil,
        attributedMessage: NSAttributedString? = nil
    ) {
        self.icon = icon ?? UIImage(named: "heart", in: .module)
        self.attributedTitle = attributedTitle ?? defaultAttributedTitle()
        self.attributedMessage = attributedMessage ?? defaultAttributedMessage()
        self.buttons = [.ahbap, .afad, .kizilay]
    }
    
    public func removeAllActions() {
        buttons.removeAll()
    }

    public func addAction(_ button: Button) {
        buttons.append(button)
    }

    public func present(over viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let controller = UIStoryboard(name: "iDonateAlert", bundle: .module)
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
        let defaultMessage = "alert_default_title".localized
        let mutableAttributedString = NSMutableAttributedString(string: defaultMessage)
        let range = (defaultMessage as NSString).range(of: "change_color_title".localized)
        let myFont: UIFont = .systemFont(ofSize: UIFont.systemFontSize);

        mutableAttributedString.addAttributes(
            [NSAttributedString.Key.font: myFont],
            range: NSRange(location: 0, length: mutableAttributedString.string.count)
        )
        
        mutableAttributedString.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: UIColor.baseDonateTextColor,
            range: range
        )

        return mutableAttributedString
    }
    
    private func defaultAttributedMessage() -> NSAttributedString {
        let defaultMessage = "alert_default_mesaage".localized
        let mutableAttributedString = NSMutableAttributedString(string: defaultMessage)
        let range = (defaultMessage as NSString).range(of: "default_message_bold".localized)
        let myFont: UIFont = .systemFont(ofSize: UIFont.systemFontSize);

        mutableAttributedString.addAttribute(
            NSAttributedString.Key.font,
            value: myFont,
            range: range
        )

        return mutableAttributedString
    }
}

public extension iDonateAlert.Button {
    static var ahbap: Self {
        .init(title: nil, image: UIImage(named: "ahbap", in: .module))
    }
    
    static var afad: Self {
        .init(title: nil, image: UIImage(named: "afad", in: .module))
    }
    
    static var kizilay: Self {
        .init(title: nil, image: UIImage(named: "turkkizilayi", in: .module))
    }
}
