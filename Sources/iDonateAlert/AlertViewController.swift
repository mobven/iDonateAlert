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
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
            button.layer.backgroundColor = alertButton.backgroundColor?.cgColor
            button.setTitleColor(alertButton.defaultTitleColor, for: .normal)
            button.setImage(alertButton.image, for: .normal)
            buttonsStackView.addArrangedSubview(button)
        }
    }

    @objc private func selectButton(_ button: UIButton) {
        let config = SFSafariViewController.Configuration()
        let safariViewController = SFSafariViewController(url: alertButtons[button.tag].url, configuration: config)
        safariViewController.modalPresentationStyle = .fullScreen
        present(safariViewController, animated: true)
    }
}
