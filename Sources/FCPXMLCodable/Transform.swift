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

    public var parameters: [Parameter] = []

    public var isEnabled: Bool = true
    public var position: Point
    public var scale: Point
    public var rotation: Double
    public var anchor: Point

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
