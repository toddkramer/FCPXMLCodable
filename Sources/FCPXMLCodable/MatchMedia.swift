//
//  MatchMedia.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct MatchMedia: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case isEnabled = "enabled"
        case rule, type
    }

    public enum MatchType: String, Codable {
        case videoWithAudio, videoOnly, audioOnly, stills
    }

    public var isEnabled: Bool = true
    public var rule: Rule
    public var type: MatchType

    public init(rule: Rule = .isExactly, type: MatchType) {
        self.rule = rule
        self.type = type
    }

    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isEnabled = try container.decodeIfPresent(Bool.self, forKey: .isEnabled) ?? true
        rule = try container.decodeIfPresent(Rule.self, forKey: .rule) ?? .isExactly
        type = try container.decode(MatchType.self, forKey: .type)
    }

}

extension MatchMedia: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
