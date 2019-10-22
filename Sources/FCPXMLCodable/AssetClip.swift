//
//  AssetClip.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

/// A clip referencing a single media asset.
public struct AssetClip: XMLRepresentable, Offsettable {

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
        case audioChannelSources = "audio-channel-source"
        case videoFilters = "filter-video"
        case videoFilterMasks = "filter-video-mask"
        case audioFilters = "filter-audio"
        case _metadata = "metadata"
        case referenceID = "ref"
        case lane, offset, name, start, duration, enabled
        case _enabledSource = "srcEnable"
        case audioStart, audioDuration
        case formatID = "format"
        case timecodeStart = "tcStart"
        case timecodeFormat = "tcFormat"
        case dateModified = "modDate"
        case audioRole, videoRole
    }

    /// A note about the asset clip.
    public var note: String?

    /// The conform rate of the asset clip.
    public var conformRate: ConformRate?

    /// The time map of the asset clip.
    public var timeMap: TimeMap?

    /// The crop adjustment applied to the asset clip.
    public var crop: Crop?

    /// The corners adjustment applied to the asset clip.
    public var corners: Corners?

    /// The conform adjustment applied to the asset clip.
    public var conform: Conform?

    /// The transform adjustment applied to the asset clip.
    public var transform: Transform?

    /// The blend adjustment applied to the asset clip.
    public var blend: Blend?

    /// The stabilization adjustment applied to the asset clip.
    public var stabilization: Stabilization?

    /// The rolling shutter adjustment applied to the asset clip.
    public var rollingShutter: RollingShutter?

    /// The 360 transform adjustment applied to the asset clip.
    public var transform360: Transform360?

    /// The reorient adjustment applied to the asset clip.
    public var reorient: Reorient?

    /// The orientation adjustment applied to the asset clip.
    public var orientation: Orientation?

    /// The volume adjustment applied to the asset clip.
    public var volume: Volume?

    /// The panner adjustment applied to the asset clip.
    public var panner: Panner?

    /// The audios anchored to the asset clip.
    public var audios: [Audio] = []

    /// The videos anchored to the asset clip.
    public var videos: [Video] = []

    /// The clips anchored to the asset clip.
    public var clips: [Clip] = []

    /// The titles anchored to the asset clip.
    public var titles: [Title] = []

    /// The captions anchored to the asset clip.
    public var captions: [Caption] = []

    /// The multicam clips anchored to the asset clip.
    public var multicamClips: [MulticamClip] = []

    /// The reference clips anchored to the asset clip.
    public var referenceClips: [ReferenceClip] = []

    /// The sync clips anchored to the asset clip.
    public var syncClips: [SyncClip] = []

    /// The asset clips anchored to the asset clip.
    public var assetClips: [AssetClip] = []

    /// The auditions anchored to the asset clip.
    public var auditions: [Audition] = []

    /// The spines anchored to the asset clip.
    public var spines: [Spine] = []

    /// The markers attached to the asset clip.
    public var markers: [Marker] = []

    /// The chapter markers attached to the asset clip.
    public var chapterMarkers: [ChapterMarker] = []

    /// The ratings associated with the asset clip.
    public var ratings: [Rating] = []

    /// The keywords associated with the asset clip.
    public var keywords: [Keyword] = []

    /// The analysis markers attached to the asset clip.
    public var analysisMarkers: [AnalysisMarker] = []

    /// The audio channel sources of the asset clip.
    public var audioChannelSources: [AudioChannelSource] = []

    /// The video filters applied to the asset clip.
    public var videoFilters: [VideoFilter] = []

    /// The video filter masks applied to the asset clip.
    public var videoFilterMasks: [VideoFilterMask] = []

    /// The audio filters applied to the asset clip.
    public var audioFilters: [AudioFilter] = []

    /// The metadata associated with the asset clip.
    public var metadata: [Metadatum]? {
        get { return _metadata?.metadata }
        set { _metadata = Metadata(metadata: newValue) }
    }

    /// The identifier of the asset referenced by this asset clip.
    public var referenceID: String

    /// The lane of the asset clip.
    public var lane: Int?

    /// The offset of the asset clip.
    public var offset: CMTime?

    /// The name of the asset clip.
    public var name: String?

    /// The start time of the asset clip.
    public var start: CMTime?

    /// The duration of the asset clip. The default value if `nil` is the duration of the referenced asset.
    public var duration: CMTime?

    /// A Boolean value that indicates whether the asset clip is enabled.
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }

    /// Specifies which sources are enabled for the asset clip.
    public var enabledSource: EnabledSource {
        get { return _enabledSource ?? .all }
        set { _enabledSource = newValue }
    }

    /// The audio start of the asset clip.
    public var audioStart: CMTime?

    /// The audio duration of the asset clip.
    public var audioDuration: CMTime?

    /// The identifier of the format referenced by this asset clip. The default value is the format identifier referenced by the asset clip's parent.
    public var formatID: String?

    /// The timecode origin of the asset clip.
    public var timecodeStart: CMTime?

    /// The timecode format of the asset clip.
    public var timecodeFormat: TimecodeFormat?

    /// The date modified of the asset clip.
    public var dateModified: Date?

    /// The main audio role of the asset clip. Subroles are generated using the main role name followed by a numerical suffix
    /// (e.g. dialogue.dialogue-1)
    public var audioRole: String?

    /// The main video role of the asset clip. Subroles are generated using the main role name followed by a numerical suffix
    /// (e.g. video.video-1)
    public var videoRole: String?

    private var _metadata: Metadata?
    private var enabled: Bool?
    private var _enabledSource: EnabledSource?
    
    /// Initializes a new asset clip.
    /// - Parameter referenceID: The identifier of the asset referenced by this asset clip.
    /// - Parameter offset: The offset of the asset clip.
    /// - Parameter name: The name of the asset clip.
    /// - Parameter start: The start time of the asset clip.
    /// - Parameter duration: The duration of the asset clip.
    /// - Parameter audioRole: The audio role of the asset clip.
    /// - Parameter timecodeFormat: The timecode format of the asset clip.
    public init(referenceID: String, offset: CMTime = .zero, name: String? = nil, start: CMTime? = nil, duration: CMTime? = nil,
                audioRole: String? = nil, timecodeFormat: TimecodeFormat? = nil) {
        self.referenceID = referenceID
        self.offset = offset
        self.name = name
        self.start = start
        self.duration = duration
        self.audioRole = audioRole
        self.timecodeFormat = timecodeFormat
    }

}

extension AssetClip: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .referenceID, .lane, .offset, .name, .start, .duration, .enabled, ._enabledSource, .audioStart, .audioDuration, .formatID,
             .timecodeStart, .timecodeFormat, .dateModified, .audioRole, .videoRole:
            return .attribute
        default:
            return .element
        }
    }

}
