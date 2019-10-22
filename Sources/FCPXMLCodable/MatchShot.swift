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

    public enum Value: String, Codable {
        case favorites, rejected
    }

    public var shotTypes: [ShotType]

    public var isEnabled: Bool = true
    public var rule: Rule

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
