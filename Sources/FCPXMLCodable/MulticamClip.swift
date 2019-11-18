//
//  MulticamClip.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

public struct MulticamClip: XMLRepresentable, Offsettable {

    private enum CodingKeys: String, CodingKey {
        case note
        case conformRate, timeMap
        case volume = "adjust-volume"
        case panner = "adjust-panner"
        case multicamSources = "mc-source"
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
        case _metadata = "metadata"
        case referenceID = "ref"
        case lane, offset, name, start, duration, enabled
        case _enabledSource = "srcEnable"
        case audioStart, audioDuration
        case dateModified = "modDate"
    }
    
    /// A note about the multicam clip.
    public var note: String?
    
    /// The conform rate of the multicam clip.
    public var conformRate: ConformRate?
    
    /// The time map of the multicam clip.
    public var timeMap: TimeMap?
    
    /// The volume adjustment applied to the multicam clip.
    public var volume: Volume?
    
    /// The panner adjustment applied to the multicam clip.
    public var panner: Panner?
    
    /// The multicam sources of the multicam clip.
    public var multicamSources: [MulticamSource] = []
    
    /// The audios anchored to the multicam clip.
    public var audios: [Audio] = []
    
    /// The videos anchored to the multicam clip.
    public var videos: [Video] = []
    
    /// The clips anchored to the multicam clip.
    public var clips: [Clip] = []
    
    /// The titles anchored to the multicam clip.
    public var titles: [Title] = []
    
    /// The captions anchored to the multicam clip.
    public var captions: [Caption] = []
    
    /// The multicam clips anchored to the multicam clip.
    public var multicamClips: [MulticamClip] = []
    
    /// The reference clips anchored to the multicam clip.
    public var referenceClips: [ReferenceClip] = []
    
    /// The sync clips anchored to the multicam clip.
    public var syncClips: [SyncClip] = []
    
    /// The asset clips anchored to the multicam clip.
    public var assetClips: [AssetClip] = []
    
    /// The auditions anchored to the multicam clip.
    public var auditions: [Audition] = []
    
    /// The spines anchored to the multicam clip.
    public var spines: [Spine] = []
    
    /// The markers attached to the multicam clip.
    public var markers: [Marker] = []
    
    /// The chapter markers attached to the multicam clip.
    public var chapterMarkers: [ChapterMarker] = []
    
    /// The ratings associated with the multicam clip.
    public var ratings: [Rating] = []
    
    /// The keywords associated with the multicam clip.
    public var keywords: [Keyword] = []
    
    /// The analysis markers attached to the multicam clip.
    public var analysisMarkers: [AnalysisMarker] = []
    
    /// The audio filters applied to the multicam clip.
    public var audioFilters: [AudioFilter] = []
    
    /// The metadata associated with the multicam clip.
    public var metadata: [Metadatum]? {
        get { return _metadata?.metadata }
        set { _metadata = Metadata(metadata: newValue) }
    }
    
    /// The reference identifier of the multicam clip.
    public var referenceID: String
    
    /// The lane of the multicam clip.
    public var lane: Int?
    
    /// The offset of the multicam clip.
    public var offset: CMTime?
    
    /// The name of the multicam clip.
    public var name: String?
    
    /// The start time of the multicam clip.
    public var start: CMTime?
    
    /// The duration of the multicam clip.
    public var duration: CMTime
    
    /// A Boolean value indicating whether the multicam clip is enabled.
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }
    
    /// Specifies which sources are enabled for the multicam clip.
    public var enabledSource: EnabledSource {
        get { return _enabledSource ?? .all }
        set { _enabledSource = newValue }
    }
    
    /// The audio start time of the multicam clip.
    public var audioStart: CMTime?
    
    /// The audio duration of the multicam clip.
    public var audioDuration: CMTime?
    
    /// The date modified of the multicam clip.
    public var dateModified: Date?

    private var _metadata: Metadata?
    private var enabled: Bool?
    private var _enabledSource: EnabledSource?
    
    /// Initializes a new multicam clip.
    /// - Parameter referenceID: The reference identifier of the multicam clip.
    /// - Parameter offset: The offset of the multicam clip.
    /// - Parameter name: The name of the multicam clip.
    /// - Parameter start: The start time of the multicam clip.
    /// - Parameter duration: The duration of the multicam clip.
    public init(referenceID: String, offset: CMTime = .zero, name: String? = nil, start: CMTime? = nil, duration: CMTime) {
        self.referenceID = referenceID
        self.offset = offset
        self.name = name
        self.start = start
        self.duration = duration
    }

}

extension MulticamClip: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .referenceID, .lane, .offset, .name, .start, .duration, .enabled, ._enabledSource, .audioStart, .audioDuration, .dateModified:
            return .attribute
        default:
            return .element
        }
    }

}
