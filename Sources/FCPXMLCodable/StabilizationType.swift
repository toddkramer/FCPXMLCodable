//
//  StabilizationType.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct StabilizationType: XMLRepresentable {

    public enum Value: String, XMLRepresentable {
        case excessiveShake
    }

    public var value: Value

    public init(value: Value) {
        self.value = value
    }

}

extension StabilizationType: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
