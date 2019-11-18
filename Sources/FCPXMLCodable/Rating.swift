//
//  Rating.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

public struct Rating: XMLRepresentable {
    
    /// Specifies the possible rating values.
    public enum Value: String, Codable {

        /// :nodoc:
        case favorite

        /// :nodoc:
        case reject

    }
    
    /// The name of the rating.
    public var name: String?
    
    /// The start time of the rating.
    public var start: CMTime?
    
    /// The duration of the rating.
    public var duration: CMTime?
    
    /// The value of the rating.
    public var value: Value
    
    /// A note about the rating.
    public var note: String?
    
    /// Initializes a new rating.
    /// - Parameter start: The start time of the rating.
    /// - Parameter duration: The duration of the rating.
    /// - Parameter value: The value of the rating.
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
