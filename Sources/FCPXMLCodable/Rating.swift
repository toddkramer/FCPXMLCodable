//
//  Rating.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

public struct Rating: XMLRepresentable {

    public enum Value: String, Codable {
        case favorite, reject
    }

    public var name: String?
    public var start: CMTime?
    public var duration: CMTime?
    public var value: Value
    public var note: String?

    public init(start: CMTime? = nil, duration: CMTime? = nil, value: Value) {
        self.start = start
        self.duration = duration
        self.value = value
    }

}

extension Rating: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
