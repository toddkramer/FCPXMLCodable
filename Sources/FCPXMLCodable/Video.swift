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
    
    /// The conform rate of the video.
    public var conformRate: ConformRate?
    
    /// The time map of the video.
    public var timeMap: TimeMap?
    
    /// The crop adjustment applied to the video.
    public var crop: Crop?
    
    /// The corners adjustment applied to the video.
    public var corners: Corners?
    
    /// The conform adjustment applied to the video.
    public var conform: Conform?
    
    /// The transform adjustment applied to the video.
    public var transform: Transform?
    
    /// The blend adjustment applied to the video.
    public var blend: Blend?
    
    /// The stabilization adjustment applied to the video.
    public var stabilization: Stabilization?
    
    /// The rolling shutter adjustment applied to the video.
    public var rollingShutter: RollingShutter?
    
    /// The 360 transform adjustment applied to the video.
    public var transform360: Transform360?
    
    /// The reorient adjustment applied to the video.
    public var reorient: Reorient?
    
    /// The orientation adjustment applied to the video.
    public var orientation: Orientation?
    
    /// The audios anchored to the video.
    public var audios: [Audio] = []
    
    /// The videos anchored to the video.
    public var videos: [Video] = []
    
    /// The clips anchored to the video.
    public var clips: [Clip] = []
    
    /// The titles anchored to the video.
    public var titles: [Title] = []
    
    /// The captions anchored to the video.
    public var captions: [Caption] = []
    
    /// The multicam clips anchored to the video.
    public var multicamClips: [MulticamClip] = []
    
    /// The reference clips anchored to the video.
    public var referenceClips: [ReferenceClip] = []
    
    /// The sync clips anchored to the video.
    public var syncClips: [SyncClip] = []
    
    /// The asset clips anchored to the video.
    public var assetClips: [AssetClip] = []
    
    /// The auditions anchored to the video.
    public var auditions: [Audition] = []
    
    /// The spines anchored to the video.
    public var spines: [Spine] = []
    
    /// The markers attached to the video.
    public var markers: [Marker] = []
    
    /// The chapter markers attached to the video.
    public var chapterMarkers: [ChapterMarker] = []
    
    /// The ratings associated with the video.
    public var ratings: [Rating] = []
    
    /// The keywords associated with the video.
    public var keywords: [Keyword] = []
    
    /// The analysis markers attached to the video.
    public var analysisMarkers: [AnalysisMarker] = []
    
    /// The video filters applied to the video.
    public var videoFilters: [VideoFilter] = []
    
    /// The video filter masks applied to the video.
    public var videoFilterMasks: [VideoFilterMask] = []
    
    /// The reserved field of the video.
    public var reserved: String?
    
    /// The reference identifier of the video.
    public let referenceID: String
    
    /// The lane of the video.
    public var lane: Int?
    
    /// The offset of the video.
    public var offset: CMTime?
    
    /// The name of the video.
    public var name: String?
    
    /// The start time of the video.
    public var start: CMTime?
    
    /// The duration of the video.
    public var duration: CMTime
    
    /// A Boolean value indicating whether the video is enabled.
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }
    
    /// The source identifier of the video.
    public var sourceID: String?
    
    /// The role of the video.
    public var role: String?

    private var enabled: Bool?
    
    /// Initializes a new video.
    /// - Parameter referenceID: The reference identifier of the video.
    /// - Parameter offset: The offset of the video.
    /// - Parameter name: The name of the video.
    /// - Parameter start: The start time of the video.
    /// - Parameter duration: The duration of the video.
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
