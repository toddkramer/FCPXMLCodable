//
//  Role.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct Role: XMLRepresentable {
    
    /// The name of the role.
    public var name: String
    
    /// Initializes a new role.
    /// - Parameter name: The name of the role.
    public init(name: String) {
        self.name = name
    }

}

extension Role: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
