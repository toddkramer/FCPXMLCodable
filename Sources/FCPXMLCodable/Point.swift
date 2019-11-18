//
//  Point.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation
import CoreGraphics

/// A structure that contains a point in a two-dimensional coordinate system.
public struct Point: XMLRepresentable {
    
    /// The x value of the point.
    public var x: Double
    
    /// The y value of the point.
    public var y: Double
    
    /// The point with location (0,0).
    public static let zero = Point(x: 0, y: 0)
    
    /// Converts the point to a Core Graphics (CGPoint) representation.
    public var cgPointValue: CGPoint {
        return CGPoint(x: x, y: y)
    }
    
    /// Initializes a new point.
    /// - Parameter x: The x value of the point.
    /// - Parameter y: The y value of the point.
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
