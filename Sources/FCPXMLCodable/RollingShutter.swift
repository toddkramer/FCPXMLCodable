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

    public enum Amount: String, Codable {
        case none, low, medium, high, extraHigh
    }

    public var amount: Amount {
        get { return _amount ?? .none }
        set { _amount = newValue }
    }

    private var _amount: Amount?

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
