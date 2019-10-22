//
//  Media.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation
import XMLCoder

public struct Media: Resource {

    private enum CodingKeys: String, CodingKey {
        case multicam, sequence
        case id, name, uid
        case dateModified = "modDate"
        case projectID = "projectRef"
    }

    public var multicam: Multicam?
    public var sequence: Sequence?

    public let id: String
    public var name: String?
    public var uid: String?
    public var projectID: String?
    public var dateModified: Date?

    public init(id: String, name: String? = nil, uid: String? = nil, dateModified: Date? = nil) {
        self.id = id
        self.name = name
        self.uid = uid
        self.dateModified = dateModified
    }

}

extension Media: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? Media.CodingKeys else { return .element }
        switch key {
        case .multicam, .sequence:
            return .element
        default:
            return .attribute
        }
    }

}
