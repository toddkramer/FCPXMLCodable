//
//  Multicam.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

public struct Multicam: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case multicamAngles = "mc-angle"
        case _metadata = "metadata"
        case formatID = "format"
        case duration
        case timecodeStart = "tcStart"
        case timecodeFormat = "tcFormat"
        case renderFormat
    }

    public var multicamAngles: [MulticamAngle] = []
    public var metadata: [Metadatum]? {
        get { return _metadata?.metadata }
        set { _metadata = Metadata(metadata: newValue) }
    }

    public let formatID: String
    public var duration: CMTime?
    public var timecodeStart: CMTime?
    public var timecodeFormat: TimecodeFormat?
    public var renderFormat: String?

    private var _metadata: Metadata?

    public init(formatID: String, duration: CMTime? = nil, timecodeStart: CMTime? = nil, timecodeFormat: TimecodeFormat? = nil) {
        self.formatID = formatID
        self.duration = duration
        self.timecodeStart = timecodeStart
        self.timecodeFormat = timecodeFormat
    }

}

extension Multicam: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? Multicam.CodingKeys else { return .element }
        switch key {
        case .multicamAngles, ._metadata:
            return .element
        default:
            return .attribute
        }
    }
}
