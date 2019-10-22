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

    public var note: String?

    public var conformRate: ConformRate?
    public var timeMap: TimeMap?

    public var volume: Volume?
    public var panner: Panner?

    public var multicamSources: [MulticamSource] = []

    public var audios: [Audio] = []
    public var videos: [Video] = []
    public var clips: [Clip] = []
    public var titles: [Title] = []
    public var captions: [Caption] = []
    public var multicamClips: [MulticamClip] = []
    public var referenceClips: [ReferenceClip] = []
    public var syncClips: [SyncClip] = []
    public var assetClips: [AssetClip] = []
    public var auditions: [Audition] = []
    public var spines: [Spine] = []

    public var markers: [Marker] = []
    public var chapterMarkers: [ChapterMarker] = []
    public var ratings: [Rating] = []
    public var keywords: [Keyword] = []
    public var analysisMarkers: [AnalysisMarker] = []

    public var audioFilters: [AudioFilter] = []
    public var metadata: [Metadatum]? {
        get { return _metadata?.metadata }
        set { _metadata = Metadata(metadata: newValue) }
    }

    public var referenceID: String
    public var lane: Int?
    public var offset: CMTime?
    public var name: String?
    public var start: CMTime?
    public var duration: CMTime
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }
    public var enabledSource: EnabledSource {
        get { return _enabledSource ?? .all }
        set { _enabledSource = newValue }
    }
    public var audioStart: CMTime?
    public var audioDuration: CMTime?
    public var dateModified: Date?

    private var _metadata: Metadata?
    private var enabled: Bool?
    private var _enabledSource: EnabledSource?

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
