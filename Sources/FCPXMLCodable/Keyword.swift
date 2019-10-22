//
//  Keyword.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

public struct Keyword: XMLRepresentable {

    public var start: CMTime?
    public var duration: CMTime?
    public var value: String
    public var note: String?

    public init(start: CMTime? = nil, duration: CMTime? = nil, value: String) {
        self.start = start
        self.duration = duration
        self.value = value
    }

}

extension Keyword: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
