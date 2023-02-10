//
//  Color+Extensions.swift
//  
//
//  Created by Rashid Ramazanov on 10.02.2023.
//

import Foundation
import UIKit

public extension UIColor {
    static var afadBlue: UIColor { UIColor(colorName: "afadBlue") }
    static var afadButtonBackgroundColor: UIColor { UIColor(colorName: "afadButtonBackgroundColor") }
    static var ahbapButtonBackgroundColor: UIColor { UIColor(colorName: "ahbapButtonBackgroundColor") }
    static var baseDonateTextColor: UIColor { UIColor(colorName: "baseDonateTextColor") }
    static var baseTextColor: UIColor { UIColor(colorName: "baseTextColor") }
    static var bsaeBackgroundColor: UIColor { UIColor(colorName: "bsaeBackgroundColor") }
    static var individualButonBorderColor: UIColor { UIColor(colorName: "individualButonBorderColor") }
    static var kızılayBackgroundColor: UIColor { UIColor(colorName: "kızılayBackgroundColor") }
    static var kızılayRed: UIColor { UIColor(colorName: "kızılayRed") }
    
}
public extension UIColor {
    convenience init(colorName: String) {
        if #available(iOS 13.0, *) {
            self.init(named: colorName, in: Bundle.module, compatibleWith: .current)!
        } else {
            self.init(named: colorName, in: Bundle.module, compatibleWith: nil)!
        }
    }
}
