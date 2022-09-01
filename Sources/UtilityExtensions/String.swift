//
//  String.swift
//  
//
//  Created by Jon Duenas on 8/31/22.
//

import Foundation

public extension String {
    /// Splits the String by all occurrences of the chosen character and returns the count of elements.
    func count(splitBy character: Character) -> Int {
        let splitString = self.split(separator: character)
        return splitString.count
    }

    func slice(from: String, to: String) -> String? {
        guard let rangeFrom = range(of: from)?.upperBound else { return nil }
        guard let rangeTo = self[rangeFrom...].range(of: to)?.lowerBound else { return nil }
        return String(self[rangeFrom..<rangeTo])
    }
}

// MARK: Localized Strings

// this allows any `enum MyEnum: String` to use .localized property
extension RawRepresentable where RawValue == String {
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

protocol LocalizableWithPrefix: RawRepresentable where RawValue == String {
    var localizablePrefix: String { get }
}

extension LocalizableWithPrefix {
    var localized: String {
        return NSLocalizedString("\(localizablePrefix)_\(self.rawValue)", comment: "")
    }

    func localized(arg: Int) -> String {
        return String(format: self.localized, arguments: [arg])
    }

    /// Allows string interpolation with Localizable.strings file.
    /// - parameter arg: The string that will replace "%@" in the localized value.
    func localized(arg: String) -> String {
        return String(format: self.localized, arguments: [arg])
    }

    /// Allows string interpolation with Localizable.strings file.
    /// - parameter arg: The array of strings that will replace "%@" in the localized value.
    func localized(arg: [String]) -> String {
        return String(format: self.localized, arguments: arg)
    }
}
