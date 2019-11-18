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
    
    /// A Boolean value indicating whether the text match is enabled.
    public var isEnabled: Bool = true
    
    /// The rule to use for the text match.
    public var rule: Rule
    
    /// The text value to match.
    public var value: String
    
    /// Initializes a new text match.
    /// - Parameter rule: The rule to use for the text match, `includes` by default.
    /// - Parameter value: The text value to match.
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
