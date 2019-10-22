//
//  NoiseReduction.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct NoiseReduction: XMLRepresentable {

    public var amount: Double

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
