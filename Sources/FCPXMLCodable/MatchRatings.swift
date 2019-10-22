//
//  MatchRatings.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct MatchRatings: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case isEnabled = "enabled"
        case value
    }

    public enum Value: String, Codable {
        case favorites, rejected
    }

    public var isEnabled: Bool = true
    public var value: Value

    public init(value: Value) {
        self.value = value
    }

    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isEnabled = try container.decodeIfPresent(Bool.self, forKey: .isEnabled) ?? true
        value = try container.decode(Value.self, forKey: .value)
    }

}

extension MatchRatings: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
