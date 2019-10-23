//
//  Clip.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

/// An annotation that applies to a range of time and indicates a chapter.
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
    
    /// A note associated with the clip.
    public var note: String?
    
    /// The conform rate of the clip.
    public var conformRate: ConformRate?
    
    /// The time map of the clip.
    public var timeMap: TimeMap?

    /// The crop adjustment applied to the clip.
    public var crop: Crop?

    /// The corners adjustment applied to the clip.
    public var corners: Corners?

    /// The conform adjustment applied to the clip.
    public var conform: Conform?

    /// The transform adjustment applied to the clip.
    public var transform: Transform?

    /// The blend adjustment applied to the clip.
    public var blend: Blend?

    /// The stabilization adjustment applied to the clip.
    public var stabilization: Stabilization?

    /// The rolling shutter adjustment applied to the clip.
    public var rollingShutter: RollingShutter?

    /// The 360 transform adjustment applied to the clip.
    public var transform360: Transform360?

    /// The reorient adjustment applied to the clip.
    public var reorient: Reorient?

    /// The orientation adjustment applied to the clip.
    public var orientation: Orientation?

    /// The volume adjustment applied to the clip.
    public var volume: Volume?

    /// The panner adjustment applied to the clip.
    public var panner: Panner?

    /// The spines contained in the clip.
    public var spines: [Spine] = []

    /// The audios contained in the clip.
    public var audios: [Audio] = []

    /// The videos contained in the clip.
    public var videos: [Video] = []

    /// The clips contained in the clip.
    public var clips: [Clip] = []

    /// The titles contained in the clip.
    public var titles: [Title] = []

    /// The multicam clips contained in the clip.
    public var multicamClips: [MulticamClip] = []
    
    /// The reference clips contained in the clip.
    public var referenceClips: [ReferenceClip] = []
    
    /// The sync clips contained in the clip.
    public var syncClips: [SyncClip] = []
    
    /// The asset clips contained in the clip.
    public var assetClips: [AssetClip] = []
    
    /// The auditions contained in the clip.
    public var auditions: [Audition] = []
    
    /// The gaps contained in the clip.
    public var gaps: [Gap] = []
    
    /// The captions contained in the clip.
    public var captions: [Caption] = []
    
    /// The markers attached to the clip.
    public var markers: [Marker] = []
    
    /// The chapter markers attached to the clip.
    public var chapterMarkers: [ChapterMarker] = []
    
    /// The ratings associated with the clip.
    public var ratings: [Rating] = []
    
    /// The keywords associated with the clip.
    public var keywords: [Keyword] = []
    
    /// The analysis markers attached to the clip.
    public var analysisMarkers: [AnalysisMarker] = []
    
    /// The audio channel sources of the clip.
    public var audioChannelSources: [AudioChannelSource] = []
    
    /// The video filters applied to the clip.
    public var videoFilters: [VideoFilter] = []
    
    /// The video filter masks applied to the clip.
    public var videoFilterMasks: [VideoFilterMask] = []
    
    /// The audio filters applied to the clip.
    public var audioFilters: [AudioFilter] = []
    
    /// The metadata associated with the clip.
    public var metadata: [Metadatum]? {
        get { return _metadata?.metadata }
        set { _metadata = Metadata(metadata: newValue) }
    }

    /// The lane of the clip.
    public var lane: Int?
    
    /// The offset of the clip.
    public var offset: CMTime?
    
    /// The name of the clip.
    public var name: String?
    
    /// The start time of the clip.
    public var start: CMTime?
    
    /// The duration of the clip.
    public var duration: CMTime
    
    /// A Boolean value that indicates whether the clip is enabled.
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }
    
    /// The identifier of the `Format` referenced by this clip.
    public var formatID: String?
    
    /// The audio start time of the clip.
    public var audioStart: CMTime?
    
    /// The audio duration of the clip.
    public var audioDuration: CMTime?

    /// The timecode start of the clip.
    public var timecodeStart: CMTime?
    
    /// The timecode format of the clip.
    public var timecodeFormat: TimecodeFormat?
    
    /// The date modified of the clip.
    public var dateModified: Date?

    private var _metadata: Metadata?
    private var enabled: Bool?
    
    /// Initializes a new clip.
    /// - Parameter offset: The offset of the clip.
    /// - Parameter name: The name of the clip.
    /// - Parameter start: The start time of the clip.
    /// - Parameter duration: The duration of the clip.
    /// - Parameter timecodeFormat: The timecode format of the clip.
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
