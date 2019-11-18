//
//  TrimRect.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

/// /// Defines the trim values of a crop adjustment.
public struct TrimRect: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case parameters = "param"
        case left, top, right, bottom
    }
    
    /// The parameters associated with the trim rect.
    public var parameters: [Parameter] = []
    
    /// The left value of the trim rect.
    public var left: Double
    
    /// The top value of the trim rect.
    public var top: Double
    
    /// The right value of the trim rect.
    public var right: Double
    
    /// The bottom value of the trim rect.
    public var bottom: Double
    
    /// Initializes a new trim rect.
    /// - Parameter left: The left value of the trim rect.
    /// - Parameter top: The top value of the trim rect.
    /// - Parameter right: The right value of the trim rect.
    /// - Parameter bottom: The bottom value of the trim rect.
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
        parameters = try container.decode([Parameter].self, forKey: .parameters)
    }

}

extension TrimRect: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .parameters:
            return .element
        default:
            return .attribute
        }
    }

}
