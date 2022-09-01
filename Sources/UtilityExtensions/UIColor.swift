//
//  UIColor.swift
//  
//
//  Created by Jon Duenas on 8/31/22.
//

import UIKit

public extension UIColor {
    convenience init(hex: String?, or defaultColor: UIColor) {
        if let hex = hex,
            let colorFromHex = UIColor(hex: hex) {
            self.init(cgColor: colorFromHex.cgColor)
        } else {
            self.init(cgColor: defaultColor.cgColor)
        }
    }

    convenience init?(hex: String) {
        let red, green, blue, alpha: CGFloat
        var hexColor = hex

        // remove pound if it's provided
        if hexColor.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            hexColor = String(hex[start...])
        }

        // assume alpha of 1 if hex does not include alpha value
        if hexColor.count == 6 {
            hexColor.append("FF")
        }

        // hex must have 8 characters
        guard hexColor.count == 8 else { return nil }

        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0

        if scanner.scanHexInt64(&hexNumber) {
            red = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            green = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            blue = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            alpha = CGFloat(hexNumber & 0x000000ff) / 255

            self.init(red: red, green: green, blue: blue, alpha: alpha)
            return
        } else {
            return nil
        }
    }

    /// Takes 8 Bit RGB values from 0-255 instead of CGFloat percentages
    convenience init(red8Bit: Int, green8Bit: Int, blue8Bit: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(red8Bit) / 255, green: CGFloat(green8Bit) / 255, blue: CGFloat(blue8Bit) / 255, alpha: alpha)
    }
}
