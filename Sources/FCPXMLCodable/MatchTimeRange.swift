//
//  MatchTimeRange.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct MatchTimeRange: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case enabled, type, rule, value, units
    }
    
    /// Specifies the possible units that can be used in a time range match.
    public enum Unit: String, Codable {

        /// :nodoc:
        case hour

        /// :nodoc:
        case day

        /// :nodoc:
        case week

        /// :nodoc:
        case month

        /// :nodoc:
        case year

    }
    
    /// A Boolean value indicating whether the time range match is enabled.
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }
    
    /// The type of the time range match.
    public var type: TimeMatchType
    
    /// The rule to use for the time range match.
    public var rule: Rule
    
    /// The time range value to match.
    public var value: String
    
    /// The unit to use for the time range match.
    public var units: Unit?

    private var enabled: Bool?
    
    /// Initializes a new time range match.
    /// - Parameter type: The type of the time range match.
    /// - Parameter rule: The rule to use for the time range match.
    /// - Parameter value: The time range value to match.
    /// - Parameter units: The unit to use for the time range match.
    public init(type: TimeMatchType, rule: Rule, value: String, units: Unit? = nil) {
        self.type = type
        self.rule = rule
        self.value = value
        self.units = units
    }

}

extension MatchTimeRange: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
