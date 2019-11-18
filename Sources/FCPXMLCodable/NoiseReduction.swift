//
//  NoiseReduction.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct NoiseReduction: XMLRepresentable {
    
    /// The amount of the noise reduction.
    public var amount: Double
    
    /// Initializes a new noise reduction
    /// - Parameter amount: The amount of the noise reduction.
    public init(amount: Double) {
        self.amount = amount
    }

}

extension NoiseReduction: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
