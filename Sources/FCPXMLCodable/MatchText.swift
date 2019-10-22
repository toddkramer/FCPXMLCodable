//
//  MatchText.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct MatchText: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case isEnabled = "enabled"
        case rule, value
    }

    public var isEnabled: Bool = true
    public var rule: Rule
    public var value: String

    public init(rule: Rule = .includes, value: String) {
        self.rule = rule
        self.value = value
    }

    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isEnabled = try container.decodeIfPresent(Bool.self, forKey: .isEnabled) ?? true
        rule = try container.decodeIfPresent(Rule.self, forKey: .rule) ?? .includes
        value = try container.decode(String.self, forKey: .value)
    }

}

extension MatchText: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
