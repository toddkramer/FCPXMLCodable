//
//  Blend.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

/// Modifies the compositing blend mode and opacity percentage of the visible image.
public struct Blend: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case parameters = "param"
        case reserved
        case _amount = "amount"
        case mode
    }

    /// The parameters of the blend adjustment.
    public var parameters: [Parameter] = []

    /// The reserved field of the blend adjustment.
    public var reserved: String?
    
    /// The amount of the blend adjustment, from 0.0 to 1.0.
    public var amount: Double {
        get { return _amount ?? 1.0 }
        set { return _amount = newValue }
    }
    
    /// The mode of the blend adjustment.
    public var mode: String?

    private var _amount: Double?
    
    /// Initializes a new blend adjustment.
    /// - Parameter mode: The mode of the blend adjustment.
    /// - Parameter amount: The amount of the blend adjustment.
    public init(mode: String? = nil, amount: Double = 1.0) {
        self.mode = mode
        self._amount = amount
    }

}

extension Blend: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .reserved, .parameters:
            return .element
        default:
            return .attribute
        }
    }

}
