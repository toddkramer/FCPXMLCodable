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

    public enum Interpolation: String, Codable {
        case smooth2, linear, smooth
    }

    public var time: CMTime
    public var value: CMTime
    public var interpolation: Interpolation {
        get { return _interpolation ?? .smooth2 }
        set { _interpolation = newValue }
    }
    public var inTime: CMTime?
    public var outTime: CMTime?

    private var _interpolation: Interpolation?

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
