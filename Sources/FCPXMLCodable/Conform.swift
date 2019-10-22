//
//  Conform.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct Conform: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case type
    }

    public enum ConformType: String, Codable {
        case fit, fill, none
    }

    private var type: ConformType? = .fit

    public init(type: ConformType = .fit) {
        self.type = type
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decodeIfPresent(ConformType.self, forKey: .type) ?? .fit
    }

}

extension Conform: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
