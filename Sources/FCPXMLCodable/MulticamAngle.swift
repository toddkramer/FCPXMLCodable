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

    public var audios: [Audio] = []
    public var videos: [Video] = []
    public var clips: [Clip] = []
    public var titles: [Title] = []
    public var multicamClips: [MulticamClip] = []
    public var referenceClips: [ReferenceClip] = []
    public var syncClips: [SyncClip] = []
    public var assetClips: [AssetClip] = []
    public var auditions: [Audition] = []
    public var gaps: [Gap] = []
    public var transitions: [Transition] = []

    public var name: String?
    public var angleID: String

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
