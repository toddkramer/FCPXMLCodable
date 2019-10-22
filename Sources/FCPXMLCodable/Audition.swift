//
//  Audition.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

/// A container of alternative elements, exactly one of which is currently active.
public struct Audition: XMLRepresentable, Offsettable {

    private enum CodingKeys: String, CodingKey {
        case audios = "audio"
        case videos = "video"
        case titles = "title"
        case referenceClips = "ref-clip"
        case assetClips = "asset-clip"
        case clips = "clip"
        case syncClips = "sync-clip"
        case lane, offset
        case dateModified = "modDate"
    }
    
    /// The audios of the audition.
    public var audios: [Audio] = []

    /// The videos of the audition.
    public var videos: [Video] = []

    /// The titles of the audition.
    public var titles: [Title] = []

    /// The reference clips of the audition.
    public var referenceClips: [ReferenceClip] = []

    /// The asset clips of the audition.
    public var assetClips: [AssetClip] = []

    /// The clips of the audition.
    public var clips: [Clip] = []

    /// The sync clips of the audition.
    public var syncClips: [SyncClip] = []
    
    /// The lane of the audition.
    public var lane: Int?

    /// The offset of the audition.
    public var offset: CMTime?

    /// The date modified of the audition.
    public var dateModified: Date?

    /// Initializes a new audition.
    /// - Parameter offset: The offset of the audition.
    public init(offset: CMTime = .zero) {
        self.offset = offset
    }

}

extension Audition: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .lane, .offset, .dateModified:
            return .attribute
        default:
            return .element
        }
    }

}
