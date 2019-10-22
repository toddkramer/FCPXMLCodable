//
//  Corners.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct Corners: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case parameters = "param"
        case isEnabled = "enabled"
        case bottomLeft = "botLeft"
        case topLeft
        case topRight
        case bottomRight = "botRight"
    }

    public var parameters: [Parameter] = []

    public var isEnabled: Bool = true
    public var bottomLeft: Point
    public var topLeft: Point
    public var topRight: Point
    public var bottomRight: Point

    public init(bottomLeft: Point, topLeft: Point, topRight: Point, bottomRight: Point) {
        self.bottomLeft = bottomLeft
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomRight = bottomRight
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isEnabled = try container.decodeIfPresent(Bool.self, forKey: .isEnabled) ?? true
        bottomLeft = try container.decodeIfPresent(Point.self, forKey: .bottomLeft) ?? .zero
        topLeft = try container.decodeIfPresent(Point.self, forKey: .topLeft) ?? .zero
        topRight = try container.decodeIfPresent(Point.self, forKey: .topRight) ?? .zero
        bottomRight = try container.decodeIfPresent(Point.self, forKey: .bottomRight) ?? .zero
        parameters = try container.decode([Parameter].self, forKey: .parameters)
    }

}

extension Corners: DynamicNodeEncoding {

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
