//
//  Video.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

public struct Video: XMLRepresentable, Offsettable {

    private enum CodingKeys: String, CodingKey {
        case conformRate, timeMap
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
        case videoFilters = "filter-video"
        case videoFilterMasks = "filter-video-mask"
        case referenceID = "ref"
        case lane, offset, name, start, duration, enabled
        case sourceID = "srcID"
        case role
    }

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

    public var videoFilters: [VideoFilter] = []
    public var videoFilterMasks: [VideoFilterMask] = []

    public var reserved: String?

    public let referenceID: String
    public var lane: Int?
    public var offset: CMTime?
    public var name: String?
    public var start: CMTime?
    public var duration: CMTime
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }
    public var sourceID: String?
    public var role: String?

    private var enabled: Bool?

    public init(referenceID: String, offset: CMTime = .zero, name: String? = nil, start: CMTime? = nil, duration: CMTime) {
        self.referenceID = referenceID
        self.offset = offset
        self.name = name
        self.start = start
        self.duration = duration
    }

}

extension Video: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .referenceID, .lane, .offset, .name, .start, .duration, .enabled, .sourceID, .role:
            return .attribute
        default:
            return .element
        }
    }

}
