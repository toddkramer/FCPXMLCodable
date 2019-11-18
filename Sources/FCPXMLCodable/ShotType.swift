//
//  ShotType.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct ShotType: XMLRepresentable {
    
    /// Specifies the possible shot type values to use in a shot type match or analysis marker.
    public enum Value: String, XMLRepresentable {

        /// :nodoc:
        case onePerson

        /// :nodoc:
        case twoPersons

        /// :nodoc:
        case group

        /// :nodoc:
        case closeUp

        /// :nodoc:
        case mediumShot

        /// :nodoc:
        case wideShot

    }
    
    /// The value of the shot type.
    public var value: Value
    
    /// Initializes a new shot type.
    /// - Parameter value: The value of the shot type.
    public init(value: Value) {
        self.value = value
    }

}

extension ShotType: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
