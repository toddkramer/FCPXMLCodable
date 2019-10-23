//
//  ChapterMarker.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

/// An annotation that applies to a range of time and indicates a chapter.
public struct ChapterMarker: XMLRepresentable {

    /// The start time of the chapter marker.
    public var start: CMTime
    
    /// The duration of the chapter marker.
    public var duration: CMTime?
    
    /// The value of the chapter marker.
    public var value: String
    
    /// A note associated with the chapter marker.
    public var note: String?
    
    /// The poster offset of the chapter marker.
    public var posterOffset: CMTime?
    
    /// Initializes a new chapter marker.
    /// - Parameter start: The start time of the chapter marker.
    /// - Parameter duration: The duration of the chapter marker.
    /// - Parameter value: The value of the chapter marker.
    /// - Parameter posterOffset: The poster offset of the chapter marker.
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
