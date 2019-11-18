//
//  HumReduction.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct HumReduction: XMLRepresentable {
    
    /// Specifies the possible frequencies of a hum reduction adjustment.
    public enum Frequency: String, Codable {

        /// :nodoc:
        case k50 = "50"

        /// :nodoc:
        case k60 = "60"

    }
    
    /// The frequency of the hum reduction.
    public var frequency: Frequency
    
    /// Initializes a new hum reduction adjustment.
    /// - Parameter frequency: The frequency of the hum reduction.
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
