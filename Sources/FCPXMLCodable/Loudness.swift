//
//  Loudness.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct Loudness: XMLRepresentable {

    public var amount: Double
    public var uniformity: Double

    public init(amount: Double, uniformity: Double) {
        self.amount = amount
        self.uniformity = uniformity
    }

}

extension Loudness: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
