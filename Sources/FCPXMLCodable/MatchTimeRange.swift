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

    public enum Unit: String, Codable {
        case hour, day, week, month, year
    }

    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }
    public var type: TimeMatchType
    public var rule: Rule
    public var value: String
    public var units: Unit?

    private var enabled: Bool?

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
