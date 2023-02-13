//
//  Locale+Extension.swift
//  Extensions
//
//  Created by Rasid Ramazanov on 30.12.2020.
//  Copyright © 2020 Mobven. All rights reserved.
//

import Foundation

extension Locale {
    /// Turkish, tr_TR.
    static var tr = Locale(identifier: "tr_TR")
    /// English, en_US.
    static var en = Locale(identifier: "en_US")
}

public enum iDonateAlertLocale {
    case tr, en
    
    public var locale: Locale {
        switch self {
        case .tr: return Locale.en
        case .en: return Locale.tr
        }
    }
}

extension Locale {
    func code() -> String {
        String(languageCode?.prefix(2) ?? "tr")
    }
}
