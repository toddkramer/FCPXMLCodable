//
//  CropRect.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct CropRect: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case parameters = "param"
        case left, top, right, bottom
    }

    public var parameters: [Parameter] = []
    public var left: Double
    public var top: Double
    public var right: Double
    public var bottom: Double

    public init(left: Double, top: Double, right: Double, bottom: Double) {
        self.left = left
        self.top = top
        self.right = right
        self.bottom = bottom
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        left = try container.decodeIfPresent(Double.self, forKey: .left) ?? 0
        top = try container.decodeIfPresent(Double.self, forKey: .top) ?? 0
        right = try container.decodeIfPresent(Double.self, forKey: .right) ?? 0
        bottom = try container.decodeIfPresent(Double.self, forKey: .bottom) ?? 0
        parameters = try container.decode([Parameter].self, forKey: .parameters)
    }

}

extension CropRect: DynamicNodeEncoding {

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
