//
//  Spine.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

public struct Spine: XMLRepresentable, ClipItemOrdering, Offsettable {

    private enum CodingKeys: String, CodingKey {
        case audios = "audio"
        case videos = "video"
        case clips = "clip"
        case titles = "title"
        case multicamClips = "mc-clip"
        case referenceClips = "ref-clip"
        case syncClips = "sync-clip"
        case assetClips = "asset-clip"
        case auditions = "audition"
        case gaps = "gap"
        case transitions = "transition"
        case lane, offset, name
        case formatID = "format"
    }
    
    /// The audios contained in the spine.
    public var audios: [Audio] = []
    
    /// The videos contained in the spine.
    public var videos: [Video] = []
    
    /// The clips contained in the spine.
    public var clips: [Clip] = []
    
    /// The titles contained in the spine.
    public var titles: [Title] = []
    
    /// The multicam clips contained in the spine.
    public var multicamClips: [MulticamClip] = []
    
    /// The reference clips contained in the spine.
    public var referenceClips: [ReferenceClip] = []
    
    /// The sync clips contained in the spine.
    public var syncClips: [SyncClip] = []
    
    /// The asset clips contained in the spine.
    public var assetClips: [AssetClip] = []
    
    /// The auditions contained in the spine.
    public var auditions: [Audition] = []
    
    /// The gaps contained in the spine.
    public var gaps: [Gap] = []
    
    /// The transitions contained in the spine.
    public var transitions: [Transition] = []
    
    /// The lane of the spine.
    public var lane: Int?
    
    /// The offset of the spine.
    public var offset: CMTime?
    
    /// The name of the spine.
    public var name: String?
    
    /// The identifier of the `Format` resource referenced by the asset.
    public var formatID: String?

    /// :nodoc:
    public init() {}

    /// :nodoc:
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(lane, forKey: .lane)
        try container.encode(offset, forKey: .offset)
        try container.encode(name, forKey: .name)
        try container.encode(formatID, forKey: .formatID)
        try encodeOrderedClipItems(to: encoder)
    }

}

extension Spine: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .lane, .offset, .name, .formatID:
            return .attribute
        default:
            return .element
        }
    }

}
