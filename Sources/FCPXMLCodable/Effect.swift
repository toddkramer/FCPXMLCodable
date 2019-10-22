//
//  Effect.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct Effect: Resource {

    private enum CodingKeys: String, CodingKey {
        case id, name, uid, sourceURL = "src"
    }

    public let id: String
    public var name: String?
    public var uid: String
    public var sourceURL: String?

    public init(id: String, name: String? = nil, uid: String) {
        self.id = id
        self.name = name
        self.uid = uid
    }

}

extension Effect: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
