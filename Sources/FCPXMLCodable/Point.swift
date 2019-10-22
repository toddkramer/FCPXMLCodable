//
//  Point.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation
import CoreGraphics

public struct Point: XMLRepresentable {

    public var x: Double
    public var y: Double

    public static let zero = Point(x: 0, y: 0)

    public var cgPointValue: CGPoint {
        return CGPoint(x: x, y: y)
    }

    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }

    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        let components = string.components(separatedBy: " ")
        if components.count == 2, let first = components.first, let second = components.last,
            let firstValue = Double(first), let secondValue = Double(second) {
            self.x = firstValue
            self.y = secondValue
        } else {
            self  = .zero
        }
    }

    /// :nodoc:
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode("\(x) \(y)")
    }

}
