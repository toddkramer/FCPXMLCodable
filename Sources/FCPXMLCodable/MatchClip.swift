//
//  MatchClip.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct MatchClip: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case isEnabled = "enabled"
        case rule, type
    }

    public enum ItemType: String, XMLRepresentable {
        case audition, synchronized, compound, multicam, layeredGraphic, project
    }

    public var isEnabled: Bool = true
    public var rule: Rule
    public var type: ItemType

    public init(rule: Rule = .isExactly, type: ItemType) {
        self.rule = rule
        self.type = type
    }

    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isEnabled = try container.decodeIfPresent(Bool.self, forKey: .isEnabled) ?? true
        rule = try container.decodeIfPresent(Rule.self, forKey: .rule) ?? .isExactly
        type = try container.decode(ItemType.self, forKey: .type)
    }

}

extension MatchClip: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
