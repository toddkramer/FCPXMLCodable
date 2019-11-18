//
//  MulticamAngle.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

public struct MulticamAngle: XMLRepresentable, ClipItemOrdering {

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
        case name, angleID
    }
    
    /// The audios contained in the multicam angle.
    public var audios: [Audio] = []
    
    /// The videos contained in the multicam angle.
    public var videos: [Video] = []
    
    /// The clips contained in the multicam angle.
    public var clips: [Clip] = []
    
    /// The titles contained in the multicam angle.
    public var titles: [Title] = []
    
    /// The multicam clips contained in the multicam angle.
    public var multicamClips: [MulticamClip] = []
    
    /// The reference clips contained in the multicam angle.
    public var referenceClips: [ReferenceClip] = []
    
    /// The sync clips contained in the multicam angle.
    public var syncClips: [SyncClip] = []
    
    /// The asset clips contained in the multicam angle.
    public var assetClips: [AssetClip] = []
    
    /// The auditions contained in the multicam angle.
    public var auditions: [Audition] = []
    
    /// The gaps contained in the multicam angle.
    public var gaps: [Gap] = []
    
    /// The transitions contained in the multicam angle.
    public var transitions: [Transition] = []
    
    /// The name of the multicam angle.
    public var name: String?
    
    /// The identifier of the multicam angle.
    public var angleID: String
    
    /// Initializes a new multicam angle.
    /// - Parameter name: The name of the multicam angle.
    /// - Parameter angleID: The identifier of the multicam angle.
    public init(name: String? = nil, angleID: String) {
        self.name = name
        self.angleID = angleID
    }

    /// :nodoc:
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(angleID, forKey: .angleID)
        try encodeOrderedClipItems(to: encoder)
    }

}

extension MulticamAngle: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .name, .angleID:
            return .attribute
        default:
            return .element
        }
    }

}
