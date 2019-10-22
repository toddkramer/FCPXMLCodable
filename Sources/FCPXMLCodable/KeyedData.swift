//
//  KeyedData.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct KeyedData: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case key
        case value = ""
    }

    public var key: String?
    public var value: String

    public init(key: String? = nil, value: String) {
        self.key = key
        self.value = value
    }

}

extension KeyedData: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .value:
            return .element
        default:
            return .attribute
        }
    }

}
