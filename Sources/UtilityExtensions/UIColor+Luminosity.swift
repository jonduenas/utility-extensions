//
//  UIColor+Luminosity.swift
//  
//
//  Created by Jon Duenas on 8/31/22.
//  Source: https://medium.com/trinity-mirror-digital/adjusting-uicolor-luminosity-in-swift-4168e3c4cdf1

import UIKit

// Fantastic explanation of how it works
// http://www.niwa.nu/2013/05/math-behind-colorspace-conversions-rgb-hsl/
fileprivate extension CGFloat {
    /// If color value is less than 1, add 1 to it. If temp color value is greater than 1, subtract 1 from it
    func convertToColorChannel() -> CGFloat {
        let min: CGFloat = 0
        let max: CGFloat = 1
        let modifier: CGFloat = 1
        if self < min {
            return self + modifier
        } else if self > max {
            return self - max
        } else {
            return self
        }
    }

    /// Formula to convert the calculated color from color multipliers
    /// - Parameter temp1: Temp variable one (calculated from luminosity)
    /// - Parameter temp2: Temp variable two (calculated from temp1 and luminosity)
    func convertToRGB(temp1: CGFloat, temp2: CGFloat) -> CGFloat {
       if 6 * self < 1 {
           return temp2 + (temp1 - temp2) * 6 * self
       } else if 2 * self < 1 {
           return temp1
       } else if 3 * self < 2 {
           return temp2 + (temp1 - temp2) * (0.666 - self) * 6
       } else {
           return temp2
       }
   }
}

public extension UIColor {
    /// Converts the UIColor to HSLA, sets the Luminance to the new value, then converts back to RGBA.
    /// Returns self if unable to convert. All color values are clamped between 0 and 1 values, so extended
    /// RGB color spaces are not supported.
    /// - Parameter newLuminosity: New luminosity, between 0 and 1 (percentage)
    /// - Returns: If convertible, the new UIColor. If not, returns self.
    func withLuminosity(_ newLuminosity: CGFloat) -> UIColor {
        // Convert RGB to HSL
        let coreColor = CIColor(color: self)
        var red = coreColor.red
        var green = coreColor.green
        var blue = coreColor.blue
        let alpha = coreColor.alpha

        red = red.clamped(to: 0...1)
        green = green.clamped(to: 0...1)
        blue = blue.clamped(to: 0...1)

        // Luminosity
        guard let minRGB = [red, green, blue].min(),
              let maxRGB = [red, green, blue].max() else {
            return self
        }
        var luminosity = (minRGB + maxRGB) / 2

        // Saturation
        var saturation: CGFloat = 0
        if luminosity <= 0.5 {
            saturation = (maxRGB - minRGB)/(maxRGB + minRGB)
        } else if luminosity > 0.5 {
            saturation = (maxRGB - minRGB)/(2.0 - maxRGB - minRGB)
        }

        // Hue
        var hue: CGFloat = 0
        if red == maxRGB {
            hue = (green - blue) / (maxRGB - minRGB)
        } else if green == maxRGB {
            hue = 2.0 + ((blue - red) / (maxRGB - minRGB))
        } else if blue == maxRGB {
            hue = 4.0 + ((red - green) / (maxRGB - minRGB))
        }

        // The Hue value needs to be multiplied by 60 to convert it to degrees on the color circle
        // If Hue becomes negative you need to add 360, because a circle has 360 degrees.
        if hue < 0 {
            hue += 360
        } else {
            hue = hue * 60
        }

        // Now that we have HSL values, we can set new L
        luminosity = newLuminosity

        // Convert new HSL back to RGB
        if saturation == 0 {
            return UIColor(red: 1.0 * luminosity, green: 1.0 * luminosity, blue: 1.0 * luminosity, alpha: alpha)
        }

        var temporaryVariableOne: CGFloat = 0
        if luminosity < 0.5 {
            temporaryVariableOne = luminosity * (1 + saturation)
        } else {
            temporaryVariableOne = luminosity + saturation - luminosity * saturation
        }

        let temporaryVariableTwo = 2 * luminosity - temporaryVariableOne

        let convertedHue = hue / 360

        let tempRed = (convertedHue + 0.333).convertToColorChannel()
        let tempGreen = convertedHue.convertToColorChannel()
        let tempBlue = (convertedHue - 0.333).convertToColorChannel()

        let newRed = tempRed.convertToRGB(temp1: temporaryVariableOne, temp2: temporaryVariableTwo)
        let newGreen = tempGreen.convertToRGB(temp1: temporaryVariableOne, temp2: temporaryVariableTwo)
        let newBlue = tempBlue.convertToRGB(temp1: temporaryVariableOne, temp2: temporaryVariableTwo)

        return UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: alpha)
    }

    /// Converts the UIColor to HSLA, sets the Luminance darker, then converts back to RGBA.
    /// Returns self if unable to convert. All color values are clamped between 0 and 1 values, so extended
    /// RGB color spaces are not supported.
    /// - Parameter percent: The percent value (between 0 and 1) to darken the current Luminance.
    /// Defaults to 0.1.
    /// - Returns: If convertible, the new UIColor. If not, returns self.
    func darker(by percent: CGFloat = 0.1) -> UIColor {
        return self.withLuminosity(0.5 - percent)
    }

    /// Converts the UIColor to HSLA, sets the Luminance lighter, then converts back to RGBA.
    /// Returns self if unable to convert. All color values are clamped between 0 and 1 values, so extended
    /// RGB color spaces are not supported.
    /// - Parameter percent: The percent value (between 0 and 1) to lighten the current Luminance.
    /// Defaults to 0.1.
    /// - Returns: If convertible, the new UIColor. If not, returns self.
    func lighter(by percent: CGFloat = 0.1) -> UIColor {
        return self.withLuminosity(0.5 + percent)
    }
}
