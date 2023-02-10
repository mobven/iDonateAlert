//
//  Locale+Extension.swift
//  Extensions
//
//  Created by Rasid Ramazanov on 30.12.2020.
//  Copyright © 2020 Mobven. All rights reserved.
//

import Foundation

public extension Locale {
    /// Turkish, tr_TR.
    static var turkish = Locale(identifier: "tr_TR")
    /// English, en_US.
    static var english = Locale(identifier: "en_US")

    /// Language code for Turkish, tr-TR
    static var turkishLanguageCode: String = "tr-TR"
}

extension Locale {
    func code() -> String {
        String(languageCode?.prefix(2) ?? "tr")
    }
}
