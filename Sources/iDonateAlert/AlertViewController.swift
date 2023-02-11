//
//  AlertViewController.swift
//  KocAilem
//
//  Created by Rasid Ramazanov on 06.11.2019.
//  Copyright © 2019 Mobven. All rights reserved.
//

import UIKit
import SafariServices


final class AlertViewController: UIViewController {
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var alertIconHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var alertIconImage: UIImageView!
    @IBOutlet private var alertTitleLabel: UILabel!
    @IBOutlet private var alertMessageLabel: UILabel!
    @IBOutlet private var buttonsStackView: UIStackView!
    @IBOutlet weak var rightCornerIcon: UIImageView!
    @IBOutlet weak var leftCornerIcon: UIImageView!
    @IBOutlet weak var singleHeart: UIImageView!
    @IBOutlet weak var dismissButton: UIButton!
    
    var alertIcon: UIImage?
    var alertTitle: String!
    var titleFont: UIFont?
    var alertMessage: String!
    var alertButtons: [iDonateAlert.Button]!
    var attributedTitle: NSAttributedString?
    var attributedMessage: NSAttributedString?

    @IBInspectable private var imageContainerHeight: CGFloat = 120
    @IBInspectable private var buttonHeight: CGFloat = 40
    @IBInspectable private var buttonCornerRadius: CGFloat = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUIForTraitCollection()
        alertIconHeightConstraint.constant = alertIcon == nil ? 0 : imageContainerHeight
        alertIconImage.image = alertIcon
        alertTitleLabel.text = alertTitle
        if let attributedTitle {
            alertTitleLabel.attributedText = attributedTitle
        }
        if let font = titleFont {
            alertTitleLabel.font = font
        }
        alertMessageLabel.text = alertMessage
        if let attributedMessage {
            alertMessageLabel.attributedText = attributedMessage
        }
        setButtons()
        dismissButton.localizedTitleKey = "close"
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    private func setButtons() {
        for (index, alertButton) in alertButtons.enumerated() {
            let button = UIButton(frame: .init(origin: .zero, size: .init(
                width: buttonsStackView.frame.width,
                height: buttonHeight
            )))
            button.layer.cornerRadius = buttonCornerRadius
            button.setTitle(alertButton.title, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(selectButton(_:)), for: .touchUpInside)
            button.layer.borderWidth = 2
            button.layer.cornerRadius = 8
            button.layer.borderColor = alertButton.borderColor?.cgColor
            button.backgroundColor = alertButton.backgroundColor
            button.setTitleColor(alertButton.defaultTitleColor, for: .normal)
            button.setImage(alertButton.image, for: .normal)
            buttonsStackView.addArrangedSubview(button)
            NSLayoutConstraint.activate([button.heightAnchor.constraint(equalToConstant: 52)])
        }
    }

    @objc private func selectButton(_ button: UIButton) {
        let config = SFSafariViewController.Configuration()
        let safariViewController = SFSafariViewController(url: alertButtons[button.tag].url, configuration: config)
        safariViewController.modalPresentationStyle = .fullScreen
        present(safariViewController, animated: true)
    }
    
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateUIForTraitCollection()
    }
    
    private func updateUIForTraitCollection(_ previousTraitCollection: UITraitCollection? = nil) {
        if #available(iOS 13.0, *) {
            guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else {
                return
            }
            if traitCollection.userInterfaceStyle == .light {
                leftCornerIcon.isHidden = false
                rightCornerIcon.isHidden = false
            } else {
                leftCornerIcon.isHidden = true
                rightCornerIcon.isHidden = true
            }

        }
    }
}
