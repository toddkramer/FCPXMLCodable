//
//  KeywordCollection.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct KeywordCollection: XMLRepresentable {
    
    /// The name of the keyword collection.
    public var name: String
    
    /// Initializes a new keyword collection.
    /// - Parameter name: The name of the keyword collection.
    public init(name: String) {
        self.name = name
    }

}

extension KeywordCollection: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
