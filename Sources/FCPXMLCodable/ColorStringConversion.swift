//
//  ColorStringConversion.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation

#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit
    /// :nodoc:
    public typealias Color = UIColor
#elseif os(macOS)
    import Cocoa
    /// :nodoc:
    public typealias Color = NSColor
#endif

extension String {

    var colorValue: Color {
        let components = self.components(separatedBy: " ")
        guard components.count == 4 else { return .clear }
        let red = Double(components[0]) ?? 0
        let green = Double(components[1]) ?? 0
        let blue = Double(components[2]) ?? 0
        let alpha = Double(components[3]) ?? 0
        return Color(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }

}

extension Color {

    #if os(iOS) || os(tvOS) || os(watchOS)
    var stringValue: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return "\(red) \(green) \(blue) \(alpha)"
    }
    #elseif os(macOS)
    var stringValue: String {
        let color = self.usingColorSpace(.sRGB) ?? self
        return "\(color.redComponent) \(color.greenComponent) \(color.blueComponent) \(color.alphaComponent)"
    }
    #endif

}
