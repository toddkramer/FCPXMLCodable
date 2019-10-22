//
//  MatchStabilization.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct MatchStabilization: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case stabilizationTypes = "stabilization-type"
        case isEnabled = "enabled"
        case rule
    }

    public enum Value: String, Codable {
        case favorites, rejected
    }

    public var stabilizationTypes: [StabilizationType]

    public var isEnabled: Bool = true
    public var rule: Rule

    public init(rule: Rule = .includesAny, stabilizationTypes: [StabilizationType]) {
        self.rule = rule
        self.stabilizationTypes = stabilizationTypes
    }

    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isEnabled = try container.decodeIfPresent(Bool.self, forKey: .isEnabled) ?? true
        rule = try container.decodeIfPresent(Rule.self, forKey: .rule) ?? .includesAny
        stabilizationTypes = try container.decode([StabilizationType].self, forKey: .stabilizationTypes)
    }

}

extension MatchStabilization: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .stabilizationTypes:
            return .element
        default:
            return .attribute
        }
    }

}
