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
    
    /// The start time of the marker.
    public var start: CMTime
    
    /// The duration of the marker.
    public var duration: CMTime?
    
    /// The value of the marker.
    public var value: String
    
    /// A Boolean value indicating whether the marker is completed.
    public var isCompleted: Bool?
    
    /// A note about the marker.
    public var note: String?
    
    /// Initializes a new marker.
    /// - Parameter start: The start time of the marker.
    /// - Parameter duration: The duration of the marker.
    /// - Parameter value: The value of the marker.
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
