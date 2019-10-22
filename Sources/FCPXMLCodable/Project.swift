//
//  Project.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation
import XMLCoder

public struct Project: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case sequence
        case name, uid, id
        case dateModified = "modDate"
    }

    public var sequence: Sequence

    public var name: String?
    public var uid: String?
    public var id: String?
    public var dateModified: Date?

    public init(name: String? = nil, uid: String? = nil, dateModified: Date? = nil, sequence: Sequence) {
        self.name = name
        self.uid = uid
        self.dateModified = dateModified
        self.sequence = sequence
    }

}

extension Project: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .sequence:
            return .element
        default:
            return .attribute
        }
    }

}
