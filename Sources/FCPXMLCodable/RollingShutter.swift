//
//  RollingShutter.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct RollingShutter: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case _amount = "amount"
    }
    
    /// Specifies the possible levels of a rolling shutter adjustment.
    public enum Amount: String, Codable {

        /// :nodoc:
        case none

        /// :nodoc:
        case low

        /// :nodoc:
        case medium

        /// :nodoc:
        case high

        /// :nodoc:
        case extraHigh

    }
    
    /// The amount of the rolling shutter adjustment.
    public var amount: Amount {
        get { return _amount ?? .none }
        set { _amount = newValue }
    }

    private var _amount: Amount?
    
    /// Initializes a new rolling shutter adjustment.
    /// - Parameter amount: The amount of the rolling shutter adjustment.
    public init(amount: Amount = .none) {
        self._amount = amount
    }

}

extension RollingShutter: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
