//
//  PanRect.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

/// /// Defines the pan values of a crop adjustment.
public struct PanRect: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case left, top, right, bottom
    }
    
    /// The left value of the pan rect.
    public var left: Double
    
    /// The top value of the pan rect.
    public var top: Double
    
    /// The right value of the pan rect.
    public var right: Double
    
    /// The bottom value of the pan rect.
    public var bottom: Double
    
    /// Initializes a new pan rect.
    /// - Parameter left: The left value of the pan rect.
    /// - Parameter top: The top value of the pan rect.
    /// - Parameter right: The right value of the pan rect.
    /// - Parameter bottom: The bottom value of the pan rect.
    public init(left: Double, top: Double, right: Double, bottom: Double) {
        self.left = left
        self.top = top
        self.right = right
        self.bottom = bottom
    }

    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        left = try container.decodeIfPresent(Double.self, forKey: .left) ?? 0
        top = try container.decodeIfPresent(Double.self, forKey: .top) ?? 0
        right = try container.decodeIfPresent(Double.self, forKey: .right) ?? 0
        bottom = try container.decodeIfPresent(Double.self, forKey: .bottom) ?? 0
    }

}

extension PanRect: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
