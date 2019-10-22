//
//  ChapterMarker.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

public struct ChapterMarker: XMLRepresentable {

    public var start: CMTime
    public var duration: CMTime?
    public var value: String
    public var note: String?
    public var posterOffset: CMTime?

    public init(start: CMTime, duration: CMTime? = nil, value: String, posterOffset: CMTime? = nil) {
        self.start = start
        self.duration = duration
        self.value = value
        self.posterOffset = posterOffset
    }

}

extension ChapterMarker: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
