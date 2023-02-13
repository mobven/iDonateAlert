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
        var url: URL
        var borderColor: UIColor?
        var backgroundColor: UIColor?
        
        /// Button initializer
        /// - Parameters:
        ///   - title: Sets the text that appears on the button
        ///   - image: If we want the image to appear on the button, we can set its asset
        ///   - titleColor: To give color to the text that appears on the button
        ///   - borderColor: It is used to give the border color to the button. Gets a value of type CGColor
        ///   - backgroundColor: It is used to give a background color to the button
        ///   - url: The Url to show on SafariViewController when the button is pressed.
        public init(
            title: String?,
            image: UIImage?,
            titleColor: UIColor? = .baseDonateTextColor,
            borderColor: UIColor? = .clear,
            backgroundColor: UIColor? = .clear,
            url: URL
        ) {
            self.title = title
            self.image = image
            defaultTitleColor = titleColor
            self.borderColor = borderColor
            self.backgroundColor = backgroundColor
            self.url = url
        }
    }

    // swiftlint:enable nesting

    var icon: UIImage?
    var title: String?
    var message: String?
    var titleFont: UIFont?
    var buttons: [Button] = []
    var attributedTitle: NSAttributedString?
    var attributedMessage: NSAttributedString?
    
    /// - Parameters:
    ///   - locale: Locale of the alert.
    ///   - icon: The Icon that is desired to appear on the screen. If no icon is entered initially, a custom icon will appear.
    ///   - title: It is the title that appears on the homepage. It cannot be nil.
    ///   - message: The message to be displayed on the screen is defined here.
    ///   - titleFont: To set the font. If it is nil, system font will be used.
    public init(
        locale: iDonateAlertLocale = .tr,
        icon: UIImage? = nil,
        title: String,
        message: String,
        titleFont: UIFont? = nil
    ) {
        Localizer.current.locale = locale.locale
        self.icon = icon ?? UIImage(named: "heart", in: .module)
        self.title = title
        self.message = message
        self.titleFont = titleFont
        self.buttons = [.ahbap, .afad, .kizilay]
    }
    
    /// With this initializer, only icon and text can be inited
    /// - Parameters:
    ///   - locale: Locale of the alert.
    ///   - icon: The Icon that is desired to appear on the screen is defined. If no icon is entered initially, a custom icon will appear.
    ///   - attributedTitle: to add attribution to the title that appears on the screen
    ///   - attributedMessage: to add attributes to the message that appears on the screen
    public init(
        locale: iDonateAlertLocale = .tr,
        icon: UIImage? = nil,
        attributedTitle: NSAttributedString? = nil,
        attributedMessage: NSAttributedString? = nil
    ) {
        Localizer.current.locale = locale.locale
        self.icon = icon ?? UIImage(named: "heart", in: .module)
        self.attributedTitle = attributedTitle ?? defaultAttributedTitle()
        self.attributedMessage = attributedMessage ?? defaultAttributedMessage()
        self.buttons = [.ahbap, .afad, .kizilay]
    }
    
    ///Deletes all buttons on the screen
    public func removeAllActions() {
        buttons.removeAll()
    }
    
    /// Adds button to the screen
    public func addAction(_ button: Button) {
        buttons.append(button)
    }
    
    /// Present IDonate alert.
    /// - Parameters:
    ///   - viewController: The controller present IDonate over.
    ///   - animated: Pass true to animate the presentation; otherwise, pass false.
    ///   - completion: The block to execute after the presentation finishes. This block has no return value and takes no parameters. You may specify nil for this parameter.
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

        mutableAttributedString.addAttributes(
            [NSAttributedString.Key.font: UIFont.regular(24)],
            range: NSRange(location: 0, length: mutableAttributedString.string.count)
        )
        
        mutableAttributedString.addAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.baseDonateTextColor,
                NSAttributedString.Key.font: UIFont.bold(24)
            ],
            range: range
        )

        return mutableAttributedString
    }
    
    private func defaultAttributedMessage() -> NSAttributedString {
        let defaultMessage = "alert_default_mesaage".localized
        let mutableAttributedString = NSMutableAttributedString(
            string: defaultMessage, attributes: [
                NSAttributedString.Key.font: UIFont.regular(13)
            ]
        )
        let range = (defaultMessage as NSString).range(of: "default_message_bold".localized)

        mutableAttributedString.addAttribute(
            NSAttributedString.Key.font,
            value: UIFont.bold(13),
            range: range
        )

        return mutableAttributedString
    }
}

public extension iDonateAlert.Button {
    static var ahbap: Self {
        .init(title: nil, image: UIImage(named: "ahbap", in: .module), borderColor: .ahbapGreen, backgroundColor: .ahbapButtonBackgroundColor, url: URL(string: "https://ahbap.org/bagisci-ol")!)
    }
    
    static var afad: Self {
        .init(title: nil, image: UIImage(named: "afad", in: .module), borderColor: .afadBlue, backgroundColor: .afadButtonBackgroundColor, url: URL(string: "https://www.afad.gov.tr/depremkampanyasi2")!)
    }
    
    static var kizilay: Self {
        .init(title: nil, image: UIImage(named: "kizilay", in: .module), borderColor: .kızılayRed, backgroundColor: .kızılayBackgroundColor, url: URL(string: "https://www.kizilay.org.tr/bagis")!)
    }
}
