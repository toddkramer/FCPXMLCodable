//
//  MatchKeywords.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct MatchKeywords: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case keywordNames = "keyword-name"
        case isEnabled = "enabled"
        case rule
    }
    
    /// The keyword names to match.
    public var keywordNames: [KeywordName]
    
    /// A Boolean value indicating whether the keywords match is enabled.
    public var isEnabled: Bool = true
    
    /// The rule to use for the keywords match.
    public var rule: Rule
    
    /// Initializes a new keywords match.
    /// - Parameter rule: The rule to use for the keywords match, `includesAny` by default.
    /// - Parameter keywordNames: The keyword names to match.
    public init(rule: Rule = .includesAny, keywordNames: [KeywordName]) {
        self.rule = rule
        self.keywordNames = keywordNames
    }

    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isEnabled = try container.decodeIfPresent(Bool.self, forKey: .isEnabled) ?? true
        rule = try container.decodeIfPresent(Rule.self, forKey: .rule) ?? .includesAny
        keywordNames = try container.decode([KeywordName].self, forKey: .keywordNames)
    }

}

extension MatchKeywords: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .keywordNames:
            return .element
        default:
            return .attribute
        }
    }

}
