//
//  HumReduction.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct HumReduction: XMLRepresentable {

    public enum Frequency: String, Codable {
        case k50 = "50"
        case k60 = "60"
    }

    public var frequency: Frequency

    public init(frequency: Frequency) {
        self.frequency = frequency
    }

}

extension HumReduction: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
