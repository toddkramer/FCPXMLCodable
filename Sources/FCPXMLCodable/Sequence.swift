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

    public var note: String?
    public var spine: Spine
    public var metadata: [Metadatum]? {
        get { return _metadata?.metadata }
        set { _metadata = Metadata(metadata: newValue) }
    }

    public let formatID: String
    public var duration: CMTime?
    public var timecodeStart: CMTime?
    public var timecodeFormat: TimecodeFormat?
    public var audioLayout: AudioLayout?
    public var audioRate: AudioRate?
    public var renderFormat: String?
    public var keywords: String?

    private var _metadata: Metadata?

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
