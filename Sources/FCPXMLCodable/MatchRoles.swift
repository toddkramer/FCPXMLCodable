//
//  MatchRoles.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct MatchRoles: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case roles = "role"
        case isEnabled = "enabled"
        case rule
    }

    public var roles: [Role]
    public var isEnabled: Bool = true
    public var rule: Rule

    public init(rule: Rule = .includesAny, roles: [Role]) {
        self.rule = rule
        self.roles = roles
    }

    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isEnabled = try container.decodeIfPresent(Bool.self, forKey: .isEnabled) ?? true
        rule = try container.decodeIfPresent(Rule.self, forKey: .rule) ?? .includesAny
        roles = try container.decode([Role].self, forKey: .roles)
    }

}

extension MatchRoles: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .roles:
            return .element
        default:
            return .attribute
        }
    }

}
