//
//  ReferenceClip.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

public struct ReferenceClip: XMLRepresentable, Offsettable {

    private enum CodingKeys: String, CodingKey {
        case note
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
        case volume = "adjust-volume"
        case panner = "adjust-panner"
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
        case audioRoleSources = "audio-role-source"
        case videoFilters = "filter-video"
        case videoFilterMasks = "filter-video-mask"
        case audioFilters = "filter-audio"
        case _metadata = "metadata"
        case referenceID = "ref"
        case lane, offset, name, start, duration, enabled
        case _enabledSource = "srcEnable"
        case audioStart, audioDuration
        case _useAudioSubroles = "useAudioSubroles"
        case dateModified = "modDate"
    }
    
    /// A note about the reference clip.
    public var note: String?
    
    /// The conform rate of the reference clip.
    public var conformRate: ConformRate?
    
    /// The time map of the reference clip.
    public var timeMap: TimeMap?
    
    /// The crop adjustment applied to the reference clip.
    public var crop: Crop?
    
    /// The corners adjustment applied to the reference clip.
    public var corners: Corners?
    
    /// The conform adjustment applied to the reference clip.
    public var conform: Conform?
    
    /// The transform adjustment applied to the reference clip.
    public var transform: Transform?
    
    /// The blend adjustment applied to the reference clip.
    public var blend: Blend?
    
    /// The stabilization adjustment applied to the reference clip.
    public var stabilization: Stabilization?
    
    /// The rolling shutter adjustment applied to the reference clip.
    public var rollingShutter: RollingShutter?
    
    /// The 360 transform adjustment applied to the reference clip.
    public var transform360: Transform360?
    
    /// The reorient adjustment applied to the reference clip.
    public var reorient: Reorient?
    
    /// The orientation adjustment applied to the reference clip.
    public var orientation: Orientation?
    
    /// The volume adjustment applied to the reference clip.
    public var volume: Volume?
    
    /// The panner adjustment applied to the reference clip.
    public var panner: Panner?
    
    /// The audios anchored to the reference clip.
    public var audios: [Audio] = []
    
    /// The videos anchored to the reference clip.
    public var videos: [Video] = []
    
    /// The clips anchored to the reference clip.
    public var clips: [Clip] = []
    
    /// The titles anchored to the reference clip.
    public var titles: [Title] = []
    
    /// The captions anchored to the reference clip.
    public var captions: [Caption] = []
    
    /// The multicam clips anchored to the reference clip.
    public var multicamClips: [MulticamClip] = []
    
    /// The reference clips anchored to the reference clip.
    public var referenceClips: [ReferenceClip] = []
    
    /// The sync clips anchored to the reference clip.
    public var syncClips: [SyncClip] = []
    
    /// The asset clips anchored to the reference clip.
    public var assetClips: [AssetClip] = []
    
    /// The auditions anchored to the reference clip.
    public var auditions: [Audition] = []
    
    /// The spines anchored to the reference clip.
    public var spines: [Spine] = []
    
    /// The markers attached to the reference clip.
    public var markers: [Marker] = []
    
    /// The chapter markers attached to the reference clip.
    public var chapterMarkers: [ChapterMarker] = []
    
    /// The ratings associated with the reference clip.
    public var ratings: [Rating] = []
    
    /// The keywords associated with the reference clip.
    public var keywords: [Keyword] = []
    
    /// The analysis markers attached to the reference clip.
    public var analysisMarkers: [AnalysisMarker] = []
    
    /// The audio role sources of the reference clip.
    public var audioRoleSources: [AudioRoleSource] = []
    
    /// The video filters applied to the reference clip.
    public var videoFilters: [VideoFilter] = []
    
    /// The video filter masks applied to the reference clip.
    public var videoFilterMasks: [VideoFilterMask] = []
    
    /// The audio filters applied to the reference clip.
    public var audioFilters: [AudioFilter] = []
    
    /// The metadata associated with the reference clip.
    public var metadata: [Metadatum]? {
        get { return _metadata?.metadata }
        set { _metadata = Metadata(metadata: newValue) }
    }
    
    /// The reference identifier of the reference clip.
    public var referenceID: String
    
    /// The lane of the reference clip.
    public var lane: Int?
    
    /// The offset of the reference clip.
    public var offset: CMTime?
    
    /// The name of the reference clip.
    public var name: String?
    
    /// The start time of the reference clip.
    public var start: CMTime?
    
    /// The duration of the reference clip.
    public var duration: CMTime
    
    /// A Boolean value indicating whether the reference clip is enabled.
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }
    
    /// Specifies the sources enabled for the reference clip.
    public var enabledSource: EnabledSource {
        get { return _enabledSource ?? .all }
        set { _enabledSource = newValue }
    }
    
    /// The audio start time of the reference clip.
    public var audioStart: CMTime?
    
    /// The audio duration of the reference clip.
    public var audioDuration: CMTime?
    
    /// A Boolean value indicating whether the reference clip uses audio subroles.
    public var useAudioSubroles: Bool {
        get { return _useAudioSubroles ?? false }
        set { _useAudioSubroles = newValue }
    }
    
    /// The date modified of the reference clip.
    public var dateModified: Date?

    private var _metadata: Metadata?
    private var enabled: Bool?
    private var _enabledSource: EnabledSource?
    private var _useAudioSubroles: Bool?
    
    /// Initializes a new reference clip.
    /// - Parameter referenceID: The reference identifier of the reference clip.
    /// - Parameter offset: The offset of the reference clip.
    /// - Parameter name: The name of the reference clip.
    /// - Parameter start: The start time of the reference clip.
    /// - Parameter duration: The duration of the reference clip.
    public init(referenceID: String, offset: CMTime = .zero, name: String? = nil, start: CMTime? = nil, duration: CMTime) {
        self.referenceID = referenceID
        self.offset = offset
        self.name = name
        self.start = start
        self.duration = duration
    }

}

extension ReferenceClip: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .referenceID, .lane, .offset, .name, .start, .duration, .enabled, ._enabledSource, .audioStart, .audioDuration, ._useAudioSubroles, .dateModified:
            return .attribute
        default:
            return .element
        }
    }

}
