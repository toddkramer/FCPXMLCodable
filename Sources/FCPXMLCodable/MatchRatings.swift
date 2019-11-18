//
//  MatchRatings.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct MatchRatings: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case isEnabled = "enabled"
        case value
    }
    
    /// Specifies the possible ratings values to match in a ratings match.
    public enum Value: String, Codable {

        /// :nodoc:
        case favorites

        /// :nodoc:
        case rejected

    }
    
    /// A Boolean value indicating whether the ratings match is enabled.
    public var isEnabled: Bool = true
    
    /// The ratings value to match.
    public var value: Value
    
    /// Initializes a new ratings match.
    /// - Parameter value: The ratings value to match.
    public init(value: Value) {
        self.value = value
    }

    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isEnabled = try container.decodeIfPresent(Bool.self, forKey: .isEnabled) ?? true
        value = try container.decode(Value.self, forKey: .value)
    }

}

extension MatchRatings: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
