//
//  Keyword.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

public struct Keyword: XMLRepresentable {
    
    /// The start time of the keyword.
    public var start: CMTime?
    
    /// The duration of the keyword.
    public var duration: CMTime?
    
    /// The value of the keyword.
    public var value: String
    
    /// A note about the keyword.
    public var note: String?
    
    /// Initializes a new keyword.
    /// - Parameter start: The start time of the keyword.
    /// - Parameter duration: The duration of the keyword.
    /// - Parameter value: The value of the keyword.
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
