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
    
    /// The multicam angles contained in the multicam.
    public var multicamAngles: [MulticamAngle] = []
    
    /// The metadata associated with the multicam.
    public var metadata: [Metadatum]? {
        get { return _metadata?.metadata }
        set { _metadata = Metadata(metadata: newValue) }
    }
    
    /// The identifier of the `Format` resource referenced by the multicam.
    public let formatID: String

    /// The duration of the multicam.
    public var duration: CMTime?
    
    /// The timecode start time of the multicam.
    public var timecodeStart: CMTime?
    
    /// The timecode format of the multicam.
    public var timecodeFormat: TimecodeFormat?
    
    /// The render format of the multicam.
    public var renderFormat: String?

    private var _metadata: Metadata?
    
    /// Initializes a new multicam.
    /// - Parameter formatID: The identifier of the `Format` resource referenced by the multicam.
    /// - Parameter duration: The duration of the multicam.
    /// - Parameter timecodeStart: The timecode start time of the multicam.
    /// - Parameter timecodeFormat: The timecode format of the multicam.
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
