//
//  Localizer.swift
//  Localizer
//
//  Created by Rashid Ramazanov on 29.12.2020.
//  Copyright © 2020 Mobven. All rights reserved.
//

import Foundation

/// Singleton Localizer class.
final class Localizer {
    /// Current Localizer instance.
    static let current = Localizer()
    
    var locale: Locale
    
    init() {
        if #available(iOS 13.0, *) {
            locale = Locale.current
        } else {
            locale = Localizer.getLanguage() == "en" ? .en : .tr
        }
    }

    static func getLanguage() -> String {
        if let currentLanguage = UserDefaults.standard.object(forKey: "CurrentLanguageKey") as? String {
            return currentLanguage
        }
        return defaultLanguage()
    }

    static func availableLanguages() -> [String] {
        var availableLanguages = Bundle.main.localizations
        // Removing "Base" from array
        if let indexOfBase = availableLanguages.firstIndex(of: "Base") {
            availableLanguages.remove(at: indexOfBase)
        }
        return availableLanguages
    }

    private static func defaultLanguage() -> String {
        var defaultLanguage = String()
        guard let preferredLanguage = Bundle.main.preferredLocalizations.first else {
            return "tr"
        }
        let availableLanguages: [String] = Localizer.availableLanguages()
        if availableLanguages.contains(preferredLanguage) {
            defaultLanguage = preferredLanguage
        } else {
            defaultLanguage = "tr"
        }
        return defaultLanguage
    }
}

/// Localization based string extension.
extension String {
    /// Returns localized text with the current locale.
    var localized: String {
        let bundle = Bundle.module
        if let path = bundle.path(forResource: Localizer.current.locale.code(), ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: self, value: nil, table: nil)
        } else if let path = bundle.path(forResource: "Base", ofType: "lproj"),
                  let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: self, value: nil, table: nil)
        }
        return self
    }

    /// Returns localizedUppercase text with the current locale.
    var localizedWithUppercase: String {
        localized.uppercased(with: Localizer.current.locale)
    }

    /// Returns localizedLowercase text with the current locale.
    var localizedWithLowercase: String {
        localized.lowercased(with: Localizer.current.locale)
    }

    /// Returns localizedCapitalized text with the current locale.
    var localizedWithCapitalization: String {
        localized.capitalized(with: Localizer.current.locale)
    }

    /// Returns localized text with the current locale.
    /// - parameter arguments: Arguments used for string formatting.
    /// Check String.init(format:arguments:) for details
    func localized(with arguments: String...) -> String {
        var string = localized
        for index in 0 ..< arguments.count {
            string = string.replacingOccurrences(of: "{\(index + 1)}", with: "%\(index + 1)$@")
        }
        return String(format: string, arguments: arguments)
    }

    func localizedPath(ofType ext: String?) -> String? {
        Bundle.module.path(forResource: self, ofType: ext)
    }
}
