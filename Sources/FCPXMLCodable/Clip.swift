//
//  Clip.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

public struct Clip: XMLRepresentable, Offsettable {

    private enum CodingKeys: String, CodingKey {
        case note, conformRate, timeMap
        case crop = "adjust-crop"
        case corners = "adjust-corners"
        case conform = "adjust-conform"
        case transform = "adjust-transform"
        case blend = "adjust-blend"
        case stabilization = "adjust-stabilization"
        case rollingShutter = "adjust-rollingShutter"
        case transform360 = "adjust-360-transform"
        case reorient = "adjust-reorient"
        case orientation = "adjust-orientation"
        case volume = "adjust-volume"
        case panner = "adjust-panner"
        case spines = "spine"
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
        case captions = "caption"
        case markers = "marker"
        case chapterMarkers = "chapter-marker"
        case ratings = "rating"
        case keywords = "keyword"
        case analysisMarkers = "analysis-marker"
        case audioChannelSources = "audio-channel-source"
        case videoFilters = "filter-video"
        case videoFilterMasks = "filter-video-mask"
        case audioFilters = "filter-audio"
        case _metadata = "metadata"
        case lane, offset, name, start, duration, enabled
        case formatID = "format"
        case audioStart, audioDuration
        case timecodeStart = "tcStart"
        case timecodeFormat = "tcFormat"
        case dateModified = "modDate"
    }

    public var note: String?

    public var conformRate: ConformRate?
    public var timeMap: TimeMap?

    public var crop: Crop?
    public var corners: Corners?
    public var conform: Conform?
    public var transform: Transform?
    public var blend: Blend?
    public var stabilization: Stabilization?
    public var rollingShutter: RollingShutter?
    public var transform360: Transform360?
    public var reorient: Reorient?
    public var orientation: Orientation?

    public var volume: Volume?
    public var panner: Panner?

    public var spines: [Spine] = []
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
    public var captions: [Caption] = []

    public var markers: [Marker] = []
    public var chapterMarkers: [ChapterMarker] = []
    public var ratings: [Rating] = []
    public var keywords: [Keyword] = []
    public var analysisMarkers: [AnalysisMarker] = []

    public var audioChannelSources: [AudioChannelSource] = []
    public var videoFilters: [VideoFilter] = []
    public var videoFilterMasks: [VideoFilterMask] = []
    public var audioFilters: [AudioFilter] = []
    public var metadata: [Metadatum]? {
        get { return _metadata?.metadata }
        set { _metadata = Metadata(metadata: newValue) }
    }

    public var lane: Int?
    public var offset: CMTime?
    public var name: String?
    public var start: CMTime?
    public var duration: CMTime
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }
    public var formatID: String?
    public var audioStart: CMTime?
    public var audioDuration: CMTime?
    public var timecodeStart: CMTime?
    public var timecodeFormat: TimecodeFormat?
    public var dateModified: Date?

    private var _metadata: Metadata?
    private var enabled: Bool?

    public init(offset: CMTime = .zero, name: String? = nil, start: CMTime? = nil, duration: CMTime, timecodeFormat: TimecodeFormat? = nil) {
        self.offset = offset
        self.name = name
        self.start = start
        self.duration = duration
        self.timecodeFormat = timecodeFormat
    }

}

extension Clip: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .lane, .offset, .name, .start, .duration, .enabled, .formatID, .audioStart, .audioDuration, .timecodeStart, .timecodeFormat,
             .dateModified:
            return .attribute
        default:
            return .element
        }
    }

}
