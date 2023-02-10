//
//  AlertViewController.swift
//  KocAilem
//
//  Created by Rasid Ramazanov on 06.11.2019.
//  Copyright © 2019 Mobven. All rights reserved.
//

import UIKit


final class AlertViewController: UIViewController {
    @IBOutlet private var contentHeightConstraint: NSLayoutConstraint!
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
    var messageTapHandler: (() -> Void)?
    var attributedMessage: NSAttributedString?

    @IBInspectable private var imageContainerHeight: CGFloat = 120
    @IBInspectable private var buttonHeight: CGFloat = 40
    @IBInspectable private var buttonCornerRadius: CGFloat = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        alertIconHeightConstraint.constant = alertIcon == nil ? 0 : imageContainerHeight
        alertIconImage.image = alertIcon
        alertTitleLabel.text = alertTitle
        if let font = titleFont {
            alertTitleLabel.font = font
        }
        alertMessageLabel.text = alertMessage
        if let attributedMessage {
            alertMessageLabel.attributedText = attributedMessage
        }
        setButtons()
        contentView.alpha = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
            self?.setContentHeight()
        }
        if messageTapHandler != nil {
            alertMessageLabel.isUserInteractionEnabled = true
            alertMessageLabel.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(didTapMessage(_:)))
            )
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func setContentHeight() {
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let self else { return }
            self.contentView.alpha = 1.0
            let maxContentHeight = UIScreen.main.bounds.height - 50
            if self.scrollView.contentSize.height > maxContentHeight {
                self.contentHeightConstraint.constant = maxContentHeight
            } else {
                self.contentHeightConstraint.constant = self.scrollView.contentSize.height
            }
            if self.contentHeightConstraint.constant == 0 {
                print("contentHeightConstraint value found zero. Dismissing AlertViewController")
                self.dismiss(animated: false, completion: nil)
            }
        }
    }

    private func setButtons() {
        for (index, alertButton) in alertButtons.enumerated() {
            let button = UIButton(frame: .init(origin: .zero, size: .init(
                width: buttonsStackView.frame.width,
                height: buttonHeight
            )))
            button.layer.cornerRadius = buttonCornerRadius
            button.setTitle(alertButton.title, for: .normal)
//            button.titleLabel?.font = UIFont.getFont(family: .bold, size: 15)
            button.tag = index
            button.addTarget(self, action: #selector(selectButton(_:)), for: .touchUpInside)
//            button.snp.makeConstraints { $0.height.equalTo(buttonHeight) }
            if alertButton.type == .default {
                button.backgroundColor = .clear
                button.setTitleColor(alertButton.defaultTitleColor, for: .normal)
            } else if alertButton.type == .custom {
                button.backgroundColor = alertButton.backgroundColor
//                button.setBorder(width: 1, color: alertButton.borderColor ?? .clear)
                button.setTitleColor(alertButton.defaultTitleColor, for: .normal)
            } else {
                button.backgroundColor = .primary
                button.setTitleColor(.primary, for: .normal)
            }
            buttonsStackView.addArrangedSubview(button)
        }
    }

    @objc private func selectButton(_ button: UIButton) {
        dismiss(animated: true) { [weak self] in
            guard let self else { return }
            self.alertButtons[button.tag].action?(self.alertButtons[button.tag])
        }
    }

    @objc func didTapMessage(_ recognizer: UITapGestureRecognizer) {
        messageTapHandler?()
    }
}
