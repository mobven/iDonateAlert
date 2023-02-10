//
//  UIImage+Extensions.swift
//  iDonateAlert
//
//  Created by Rashid Ramazanov on 10.02.2023.
//

import Foundation
import UIKit

extension UIImage {
    convenience init?(named: String, in bundle: Bundle = .module) {
        if #available(iOS 13.0, *) {
            self.init(named: named, in: bundle, compatibleWith: .current)
        } else {
            self.init(named: named, in: bundle, compatibleWith: nil)
        }
    }
}
