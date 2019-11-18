//
//  MatchTime.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct MatchTime: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case enabled, type, rule, value
    }
    
    /// A Boolean value indicating whether the time match is enabled.
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }
    
    /// The type of the time match.
    public var type: TimeMatchType
    
    /// The rule to use for the time match.
    public var rule: Rule
    
    /// The time value to match.
    public var value: String

    private var enabled: Bool?
    
    /// Initializes a new time match.
    /// - Parameter type: The type of the time match.
    /// - Parameter rule: The rule to use for the time match.
    /// - Parameter value: The time value to match.
    public init(type: TimeMatchType, rule: Rule, value: String) {
        self.type = type
        self.rule = rule
        self.value = value
    }

}

extension MatchTime: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
