//
//  TimeMap.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct TimeMap: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case timePoints = "timept"
        case _preservesPitch = "preservesPitch"
        case _frameSampling = "frameSampling"
    }

    public var timePoints: [TimePoint]

    public var preservesPitch: Bool {
        get { return _preservesPitch ?? true }
        set { _preservesPitch = newValue }
    }
    public var frameSampling: FrameSampling {
        get { return _frameSampling ?? .floor }
        set { _frameSampling = newValue }
    }

    private var _preservesPitch: Bool?
    private var _frameSampling: FrameSampling?

    public init(timePoints: [TimePoint]) {
        self.timePoints = timePoints
    }

}

extension TimeMap: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .timePoints:
            return .element
        default:
            return .attribute
        }
    }

}
