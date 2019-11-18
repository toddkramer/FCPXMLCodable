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
    
    /// The stabilization types to match.
    public var stabilizationTypes: [StabilizationType]
    
    /// A Boolean value indicating whether the stabilization type match is enabled.
    public var isEnabled: Bool = true
    
    /// The rule to use for the stabilization type match.
    public var rule: Rule
    
    /// Initializes a new stabilization type match.
    /// - Parameter rule: The rule to use for the stabilization type match, `includesAny` by default.
    /// - Parameter stabilizationTypes: The stabilization types to match.
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
