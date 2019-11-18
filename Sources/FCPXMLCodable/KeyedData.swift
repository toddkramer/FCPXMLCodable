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
    
    /// The key of the keyed data.
    public var key: String?
    
    /// The value of the keyed data.
    public var value: String
    
    /// Initializes a new keyed data value.
    /// - Parameter key: The key of the keyed data.
    /// - Parameter value: The value of the keyed data.
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
