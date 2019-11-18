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
    
    /// Specifies the possible media types to match in a media match.
    public enum MatchType: String, Codable {

        /// :nodoc:
        case videoWithAudio

        /// :nodoc:
        case videoOnly

        /// :nodoc:
        case audioOnly

        /// :nodoc:
        case stills

    }
    
    /// A Boolean value indicating whether the media match is enabled.
    public var isEnabled: Bool = true
    
    /// The rule to use for the media match.
    public var rule: Rule
    
    /// The media type to match.
    public var type: MatchType
    
    /// Initializes a new media match.
    /// - Parameter rule: The rule to use for the media match, `isExactly` by default.
    /// - Parameter type: The media type to match.
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
