//
//  ShotType.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct ShotType: XMLRepresentable {

    public enum Value: String, XMLRepresentable {
        case onePerson, twoPersons, group, closeUp, mediumShot, wideShot
    }

    public var value: Value

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
