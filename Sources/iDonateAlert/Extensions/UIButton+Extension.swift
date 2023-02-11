//
//  UIButton+Extension.swift
//  Localizer
//
//  Created by Rashid Ramazanov on 29.12.2020.
//  Copyright © 2020 Mobven. All rights reserved.
//

import Foundation
import UIKit

struct AssociatedKey {
    static var textKey: UInt8 = 0
    static var placeholderKey: UInt8 = 1
}

public extension UIButton {
    @IBInspectable var localizedTitleKey: String {
        get {
            objc_getAssociatedObject(self, &AssociatedKey.textKey) as? String ?? ""
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.textKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            setTitle(newValue.localized, for: .normal)
        }
    }
}
