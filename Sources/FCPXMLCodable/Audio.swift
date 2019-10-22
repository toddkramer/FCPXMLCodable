//
//  Audio.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

/// A reference to audio data from an `Asset` or `Effect`.
public struct Audio: XMLRepresentable, Offsettable {

    private enum CodingKeys: String, CodingKey {
        case conformRate, timeMap
        case volume = "adjust-volume"
        case audios = "audio"
        case videos = "video"
        case clips = "clip"
        case titles = "title"
        case captions = "caption"
        case multicamClips = "mc-clip"
        case referenceClips = "ref-clip"
        case syncClips = "sync-clip"
        case assetClips = "asset-clip"
        case auditions = "audition"
        case spines = "spine"
        case markers = "marker"
        case chapterMarkers = "chapter-marker"
        case ratings = "rating"
        case keywords = "keyword"
        case analysisMarkers = "analysis-marker"
        case audioFilters = "filter-audio"
        case referenceID = "ref"
        case lane, offset, name, start, duration, enabled
        case sourceID = "srcID"
        case role
        case sourceChannels = "srcCh"
        case outputChannels = "outCh"
    }

    /// The conform rate of the audio.
    public var conformRate: ConformRate?

    /// The time map of the audio.
    public var timeMap: TimeMap?

    /// The volume adjustment applied to the audio.
    public var volume: Volume?

    /// The audios anchored to the audio.
    public var audios: [Audio] = []

    /// The videos anchored to the audio.
    public var videos: [Video] = []

    /// The clips anchored to the audio.
    public var clips: [Clip] = []

    /// The titles anchored to the audio.
    public var titles: [Title] = []

    /// The captions anchored to the audio.
    public var captions: [Caption] = []

    /// The multicam clips anchored to the audio.
    public var multicamClips: [MulticamClip] = []

    /// The reference clips anchored to the audio.
    public var referenceClips: [ReferenceClip] = []

    /// The sync clips anchored to the audio.
    public var syncClips: [SyncClip] = []

    /// The asset clips anchored to the audio.
    public var assetClips: [AssetClip] = []

    /// The auditions anchored to the audio.
    public var auditions: [Audition] = []

    /// The spines anchored to the audio.
    public var spines: [Spine] = []

    /// The markers attached to the audio.
    public var markers: [Marker] = []

    /// The chapter markers attached to the audio.
    public var chapterMarkers: [ChapterMarker] = []

    /// The ratings associated with the audio.
    public var ratings: [Rating] = []

    /// The keywords associated with the audio.
    public var keywords: [Keyword] = []

    /// The analysis markers attached to the audio.
    public var analysisMarkers: [AnalysisMarker] = []

    /// The audio filters applied to the audio.
    public var audioFilters: [AudioFilter] = []

    /// The identifier of the asset or effect referenced by this audio.
    public let referenceID: String

    /// The lane of the audio.
    public var lane: Int?

    /// The offset of the audio.
    public var offset: CMTime?

    /// The name of the audio.
    public var name: String?

    /// The start time of the audio.
    public var start: CMTime?

    /// The duration of the audio.
    public var duration: CMTime

    /// A Boolean value that indicates whether the audio is enabled.
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }

    /// References the specific audio source (or track) in the asset. The default value is `1`.
    public var sourceID: String?

    /// The role of the audio. Format is main-role.subrole.
    public var role: String?

    /// Identifies specific audio source channels in the asset. The value is a comma-separated series of 1-based channel indices.
    public var sourceChannels: String?

    /// Specifies output channels to send the audio. The value is a comma-separated series of channel tags: L, R, C, LFE, Ls, Rs, and X.
    public var outputChannels: String?

    private var enabled: Bool?

    
    /// Initializes a new audio with a reference identifier and duration.
    /// - Parameter referenceID: The reference identifier of the audio.
    /// - Parameter duration: The duration of the audio.

    
    /// Initializes a new audio.
    /// - Parameter referenceID: The reference identifier of the audio.
    /// - Parameter offset: The offset of the audio.
    /// - Parameter name: The name of the audio.
    /// - Parameter start: The start time of the audio.
    /// - Parameter duration: The duration of the audio.
    /// - Parameter role: The role of the audio.
    /// - Parameter sourceChannels: Identifies specific audio source channels in the asset.
    public init(referenceID: String, offset: CMTime = .zero, name: String? = nil, start: CMTime? = nil, duration: CMTime, role: String? = nil,
                sourceChannels: String? = nil) {
        self.referenceID = referenceID
        self.offset = offset
        self.name = name
        self.start = start
        self.duration = duration
        self.role = role
        self.sourceChannels = sourceChannels
    }

}

extension Audio: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .referenceID, .lane, .offset, .name, .start, .duration, .enabled, .sourceID, .role, .sourceChannels, .outputChannels:
            return .attribute
        default:
            return .element
        }
    }

}
