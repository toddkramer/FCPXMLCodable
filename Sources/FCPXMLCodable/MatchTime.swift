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

    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }
    public var type: TimeMatchType
    public var rule: Rule
    public var value: String

    private var enabled: Bool?

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
