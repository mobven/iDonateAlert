//
//  AlertSelectionViewController.swift
//  KocAilem
//
//  Created by Rasid Ramazanov on 06.11.2019.
//  Copyright © 2019 Mobven. All rights reserved.
//

import Foundation
import UIKit

public final class AlertSelection {
    public struct Option {
        var title: String
        var isSelected: Bool

        public init(title: String, isSelected: Bool = false) {
            self.title = title
            self.isSelected = isSelected
        }
    }

    // swiftlint:disable nesting
    public struct Button {
        var title: String
        var type: Button.ActionType
        var action: AlertAction?

        public init(title: String, type: Button.ActionType, action: AlertAction? = nil) {
            self.title = title
            self.type = type
            self.action = action
        }

        public enum ActionType {
            case `default`, destructive, unColor
        }

        public typealias AlertAction = (Int) -> Void
    }

    // swiftlint:enable nesting

    public enum RadioAlignment {
        case leading, trailing
    }

    var title: String
    var radioAlignment: RadioAlignment
    var optionsSpacing: CGFloat
    var options: [Option] = []
    var buttons: [Button] = []

    public init(title: String, optionsSpacing: CGFloat = 20, radioAlignment: RadioAlignment = .trailing) {
        self.title = title
        self.optionsSpacing = optionsSpacing
        self.radioAlignment = radioAlignment
    }

    public func addOption(_ option: Option) {
        options.append(option)
    }

    public func addAction(_ button: Button) {
        buttons.append(button)
    }

    public func present(over viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let controller = UIStoryboard(name: "Alert", bundle: .module)
            .instantiateViewController(withIdentifier: "AlertSelectionViewController")
            as? AlertSelectionViewController else {
            fatalError("AlertViewController could not be initialized")
        }
        controller.alertTitle = title
        controller.radioAlignment = radioAlignment
        controller.optionsSpacing = optionsSpacing
        controller.alertOptions = options
        controller.alertButtons = buttons
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        viewController.present(controller, animated: animated, completion: completion)
    }
}

final class AlertSelectionViewController: UIViewController {
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var alertTitleLabel: UILabel!
    @IBOutlet private var optionsStackView: UIStackView!
    @IBOutlet private var buttonsStackView: UIStackView!

    fileprivate var alertTitle: String!
    fileprivate var radioAlignment: AlertSelection.RadioAlignment!
    fileprivate var optionsSpacing: CGFloat!
    fileprivate var alertOptions: [AlertSelection.Option]!
    fileprivate var alertButtons: [AlertSelection.Button]!

    @IBInspectable private var buttonHeight: CGFloat = 40
    @IBInspectable private var buttonCornerRadius: CGFloat = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        alertTitleLabel.text = alertTitle
        contentView.backgroundColor = .baseDonateTextColor
        alertTitleLabel.textColor = .baseDonateTextColor
        setOptions()
        animatePresentation()
        setButtons()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func animatePresentation() {
        contentView.alpha = 0
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let self else { return }
            self.contentView.alpha = 1.0
        }
    }

    private func setOptions() {
        optionsStackView.spacing = optionsSpacing
        for (index, alertOption) in alertOptions.enumerated() {
            let button = UIButton()
            button.setTitleColor(UIColor.baseDonateTextColor, for: .normal)
            button.contentHorizontalAlignment = .leading

            button.setTitle(alertOption.title, for: .normal)
//            button.titleLabel?.font = UIFont.getFont(family: .regular, size: 17)
            button.titleLabel?.numberOfLines = 0

            button.setImage(UIImage(named: "unselectedRadioButton"), for: .normal)
            button.setImage(UIImage(named: "selectedRadioButton"), for: .selected)
            button.setImage(UIImage(named: "selectedRadioButton"), for: .highlighted)
            button.setImage(UIImage(named: "selectedRadioButton"), for: .focused)
            button.isSelected = alertOption.isSelected

            if radioAlignment == .trailing {
                button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -25, bottom: 0, right: 0)
                button.imageEdgeInsets = UIEdgeInsets(
                    top: 0,
                    left: optionsStackView.bounds.width - 25,
                    bottom: 0,
                    right: 0
                )
            } else {
                button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: -15)
                button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
            button.tag = index
            button.addTarget(self, action: #selector(selectOption(_:)), for: .touchUpInside)
            optionsStackView.addArrangedSubview(button)
        }
    }

    @objc private func selectOption(_ button: UIButton) {
        for option in optionsStackView.arrangedSubviews {
            guard let optionButton = option as? UIButton else { continue }
            optionButton.isSelected = optionButton.tag == button.tag
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

            switch alertButton.type {
            case .destructive:
                button.backgroundColor = UIColor.baseDonateTextColor
                button.setTitleColor(.baseDonateTextColor, for: .normal)
            case .unColor:
                button.backgroundColor = .baseDonateTextColor
                button.setTitleColor(.baseDonateTextColor, for: .normal)
            default:
                button.backgroundColor = .baseDonateTextColor
                button.setTitleColor(UIColor.baseDonateTextColor, for: .normal)
            }

            buttonsStackView.addArrangedSubview(button)
        }
    }

    @objc private func selectButton(_ button: UIButton) {
        dismiss(animated: true) { [weak self] in
            guard let index = self?.optionsStackView.arrangedSubviews.firstIndex(
                where: { ($0 as? UIButton)?.isSelected == true }
            ) else { return }
            self?.alertButtons[button.tag].action?(index)
        }
    }
}
