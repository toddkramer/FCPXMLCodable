//
//  Transform.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct Transform: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case parameters = "param"
        case isEnabled = "enabled"
        case position, scale, rotation, anchor
    }
    
    /// The parameters associated with the transform adjustment.
    public var parameters: [Parameter] = []
    
    /// A Boolean value indicating whether the transform adjustment is enabled.
    public var isEnabled: Bool = true
    
    /// The position of the transform adjustment.
    public var position: Point
    
    /// The scale of the transform adjustment.
    public var scale: Point
    
    /// The rotation of the transform adjustment.
    public var rotation: Double
    
    /// The anchor point of the transform adjustment.
    public var anchor: Point
    
    /// Initializes a new transform adjustment.
    /// - Parameter position: The position of the transform adjustment.
    /// - Parameter scale: The scale of the transform adjustment.
    /// - Parameter rotation: The rotation of the transform adjustment.
    /// - Parameter anchor: The anchor point of the transform adjustment.
    public init(position: Point, scale: Point, rotation: Double, anchor: Point) {
        self.position = position
        self.scale = scale
        self.rotation = rotation
        self.anchor = anchor
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isEnabled = try container.decodeIfPresent(Bool.self, forKey: .isEnabled) ?? true
        position = try container.decodeIfPresent(Point.self, forKey: .position) ?? .zero
        scale = try container.decodeIfPresent(Point.self, forKey: .scale) ?? Point(x: 1, y: 1)
        rotation = try container.decodeIfPresent(Double.self, forKey: .rotation) ?? 0
        anchor = try container.decodeIfPresent(Point.self, forKey: .anchor) ?? .zero
        parameters = try container.decode([Parameter].self, forKey: .parameters)
    }
    
}

extension Transform: DynamicNodeEncoding {

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
