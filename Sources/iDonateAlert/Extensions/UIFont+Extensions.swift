//
//  UIFont+Extensions.swift
//  iDonateAlert
//
//  Created by Rashid Ramazanov on 11.02.2023.
//

import Foundation
import UIKit

extension UIFont {
    static func regular(_ size: CGFloat) -> UIFont {
        UIFont(name: "HelveticaNeue", size: size)!
    }
    static func medium(_ size: CGFloat) -> UIFont {
        UIFont(name: "HelveticaNeue-Medium", size: size)!
    }
    static func bold(_ size: CGFloat) -> UIFont {
        UIFont(name: "HelveticaNeue-Bold", size: size)!
    }
}
