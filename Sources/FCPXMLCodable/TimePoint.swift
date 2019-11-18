//
//  TimePoint.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

public struct TimePoint: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case time, value
        case _interpolation = "interp"
        case inTime, outTime
    }
    
    /// Specifies the possible interpolation modes of a time point.
    public enum Interpolation: String, Codable {

        /// :nodoc:
        case smooth2

        /// :nodoc:
        case linear

        /// :nodoc:
        case smooth

    }
    
    /// The time of the time point.
    public var time: CMTime
    
    /// The value of the time point.
    public var value: CMTime
    
    /// The interpolation mode of the time point.
    public var interpolation: Interpolation {
        get { return _interpolation ?? .smooth2 }
        set { _interpolation = newValue }
    }
    
    /// The in time of the time point.
    public var inTime: CMTime?
    
    /// The out time of the time point.
    public var outTime: CMTime?

    private var _interpolation: Interpolation?
    
    /// Initializes a new time point.
    /// - Parameter time: The time of the time point.
    /// - Parameter value: The value of the time point.
    public init(time: CMTime, value: CMTime) {
        self.time = time
        self.value = value
    }

}

extension TimePoint: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
