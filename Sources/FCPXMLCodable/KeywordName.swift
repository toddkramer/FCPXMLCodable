//
//  KeywordName.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct KeywordName: XMLRepresentable {

    public var value: String

    public init(value: String) {
        self.value = value
    }

}

extension KeywordName: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
