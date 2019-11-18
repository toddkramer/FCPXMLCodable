//
//  MatchShot.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct MatchShot: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case shotTypes = "shot-type"
        case isEnabled = "enabled"
        case rule
    }
    
    /// The shot types to match.
    public var shotTypes: [ShotType]
    
    /// A Boolean value indicating whether the shot type match is enabled.
    public var isEnabled: Bool = true
    
    /// The rule to use for the shot type match.
    public var rule: Rule
    
    /// Initializes a new shot type match.
    /// - Parameter rule: The rule to use for the shot type match, `includesAny` by default.
    /// - Parameter shotTypes: The shot types to match.
    public init(rule: Rule = .includesAny, shotTypes: [ShotType]) {
        self.rule = rule
        self.shotTypes = shotTypes
    }

    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isEnabled = try container.decodeIfPresent(Bool.self, forKey: .isEnabled) ?? true
        rule = try container.decodeIfPresent(Rule.self, forKey: .rule) ?? .includesAny
        shotTypes = try container.decode([ShotType].self, forKey: .shotTypes)
    }

}

extension MatchShot: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .shotTypes:
            return .element
        default:
            return .attribute
        }
    }

}
