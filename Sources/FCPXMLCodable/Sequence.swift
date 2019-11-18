//
//  Sequence.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import Foundation
import XMLCoder

public struct Sequence: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case note
        case spine
        case _metadata = "metadata"
        case formatID = "format"
        case duration
        case timecodeStart = "tcStart"
        case timecodeFormat = "tcFormat"
        case renderFormat
        case audioLayout
        case audioRate
        case keywords
    }
    
    /// A note about the sequence.
    public var note: String?
    
    /// The spine of the sequence.
    public var spine: Spine
    
    /// The metadata associated with the sequence.
    public var metadata: [Metadatum]? {
        get { return _metadata?.metadata }
        set { _metadata = Metadata(metadata: newValue) }
    }
    
    /// The identifier of the `Format` resource referenced by the sequence.
    public let formatID: String
    
    /// The duration of the sequence.
    public var duration: CMTime?
    
    /// The timecode start time of the sequence.
    public var timecodeStart: CMTime?
    
    /// The timecode format of the sequence.
    public var timecodeFormat: TimecodeFormat?
    
    /// The audio layout of the sequence.
    public var audioLayout: AudioLayout?
    
    /// The audio rate of the sequence.
    public var audioRate: AudioRate?
    
    /// The render format of the sequence.
    public var renderFormat: String?
    
    /// The keywords associated with the sequence.
    public var keywords: String?

    private var _metadata: Metadata?
    
    /// Initializes a new sequence.
    /// - Parameter formatID: The identifier of the `Format` resource referenced by the sequence.
    /// - Parameter duration: The duration of the sequence.
    /// - Parameter timecodeStart: The timecode start time of the sequence.
    /// - Parameter timecodeFormat: The timecode format of the sequence.
    /// - Parameter audioLayout: The audio layout of the sequence.
    /// - Parameter audioRate: The audio rate of the sequence.
    /// - Parameter spine: The spine of the sequence.
    public init(formatID: String, duration: CMTime? = nil, timecodeStart: CMTime? = nil, timecodeFormat: TimecodeFormat? = nil,
                audioLayout: AudioLayout? = nil, audioRate: AudioRate? = nil, spine: Spine) {
        self.formatID = formatID
        self.duration = duration
        self.timecodeStart = timecodeStart
        self.timecodeFormat = timecodeFormat
        self.audioLayout = audioLayout
        self.audioRate = audioRate
        self.spine = spine
    }

}

extension Sequence: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? Sequence.CodingKeys else { return .element }
        switch key {
        case .note, .spine, ._metadata:
            return .element
        default:
            return .attribute
        }
    }
}
