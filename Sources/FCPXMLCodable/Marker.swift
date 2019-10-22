//
//  Marker.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

public struct Marker: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case start, duration, value
        case isCompleted = "completed"
        case note
    }

    public var start: CMTime
    public var duration: CMTime?
    public var value: String
    public var isCompleted: Bool?
    public var note: String?

    public init(start: CMTime, duration: CMTime? = nil, value: String) {
        self.start = start
        self.duration = duration
        self.value = value
    }

}

extension Marker: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
