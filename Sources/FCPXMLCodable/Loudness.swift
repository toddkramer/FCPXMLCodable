//
//  Loudness.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct Loudness: XMLRepresentable {
    
    /// The amount of the loudness adjustment.
    public var amount: Double
    
    /// The uniformity of the loudness adjustment.
    public var uniformity: Double
    
    /// Initializes a new loudness adjustment.
    /// - Parameter amount: The amount of the loudness adjustment.
    /// - Parameter uniformity: The uniformity of the loudness adjustment.
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
