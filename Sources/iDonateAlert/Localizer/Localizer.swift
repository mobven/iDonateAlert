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

    /// Selected language code
    public var languageCode: String {
        if #available(iOS 13.0, *) {
            return String(Bundle.main.preferredLocalizations.first?.prefix(2) ?? "")
        } else {
            return getLanguage()
        }
    }

    public var locale: Locale {
        if #available(iOS 13.0, *) {
            return Locale.current
        } else {
            return getLanguage() == "en" ? .english : .turkish
        }
    }

    fileprivate func getLanguage() -> String {
        if let currentLanguage = UserDefaults.standard.object(forKey: "CurrentLanguageKey") as? String {
            return currentLanguage
        }
        return defaultLanguage()
    }

    public func setLocale(_ locale: Locale) {
        let languageCode = locale.code()
        let selectedLanguage = availableLanguages().contains(languageCode) ? languageCode : defaultLanguage()
        if selectedLanguage != getLanguage() {
            UserDefaults.standard.set(selectedLanguage, forKey: "CurrentLanguageKey")
            UserDefaults.standard.synchronize()
        }
    }

    func availableLanguages() -> [String] {
        var availableLanguages = Bundle.main.localizations
        // Removing "Base" from array
        if let indexOfBase = availableLanguages.firstIndex(of: "Base") {
            availableLanguages.remove(at: indexOfBase)
        }
        return availableLanguages
    }

    private func defaultLanguage() -> String {
        var defaultLanguage = String()
        guard let preferredLanguage = Bundle.main.preferredLocalizations.first else {
            return "tr"
        }
        let availableLanguages: [String] = availableLanguages()
        if availableLanguages.contains(preferredLanguage) {
            defaultLanguage = preferredLanguage
        } else {
            defaultLanguage = "tr"
        }
        return defaultLanguage
    }
}

/// Localization based string extension.
public extension String {
    /// Returns localized text with the current locale.
    var localized: String {
        if #available(iOS 13.0, *) {
            return NSLocalizedString(self, tableName: nil, bundle: Bundle.module, value: "", comment: "")
        } else {
            let bundle = Bundle.module
            if let path = bundle.path(forResource: Localizer.current.getLanguage(), ofType: "lproj"),
               let bundle = Bundle(path: path) {
                return bundle.localizedString(forKey: self, value: nil, table: nil)
            } else if let path = bundle.path(forResource: "Base", ofType: "lproj"),
                      let bundle = Bundle(path: path) {
                return bundle.localizedString(forKey: self, value: nil, table: nil)
            }
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
