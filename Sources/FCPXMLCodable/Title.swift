//
//  Title.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

public struct Title: XMLRepresentable, Offsettable {

    private enum CodingKeys: String, CodingKey {
        case parameters = "param"
        case texts = "text"
        case textStyleDefinitions = "text-style-def"
        case note
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
        case _metadata = "metadata"
        case referenceID = "ref"
        case lane, offset, name, start, duration, enabled
        case role
    }
    
    /// The parameters associated with the title.
    public var parameters: [Parameter] = []

    
    /// The texts of the title.
    public var texts: [Text] = []
    
    /// The text style definitions of the title.
    public var textStyleDefinitions: [TextStyleDefinition] = []
    
    /// A note about the title.
    public var note: String?
    
    /// The crop adjustment applied to the title.
    public var crop: Crop?
    
    /// The corners adjustment applied to the title.
    public var corners: Corners?
    
    /// The conform adjustment applied to the title.
    public var conform: Conform?
    
    /// The transform adjustment applied to the title.
    public var transform: Transform?
    
    /// The blend adjustment applied to the title.
    public var blend: Blend?
    
    /// The stabilization adjustment applied to the title.
    public var stabilization: Stabilization?
    
    /// The rolling shutter adjustment applied to the title.
    public var rollingShutter: RollingShutter?
    
    /// The 360 transform adjustment applied to the title.
    public var transform360: Transform360?
    
    /// The reorient adjustment applied to the title.
    public var reorient: Reorient?
    
    /// The orientation adjustment applied to the title.
    public var orientation: Orientation?
    
    /// The audios anchored to the title.
    public var audios: [Audio] = []
    
    /// The videos anchored to the title.
    public var videos: [Video] = []
    
    /// The clips anchored to the title.
    public var clips: [Clip] = []
    
    /// The titles anchored to the title.
    public var titles: [Title] = []
    
    /// The captions anchored to the title.
    public var captions: [Caption] = []
    
    /// The multicam clips anchored to the title.
    public var multicamClips: [MulticamClip] = []
    
    /// The reference clips anchored to the title.
    public var referenceClips: [ReferenceClip] = []
    
    /// The sync clips anchored to the title.
    public var syncClips: [SyncClip] = []
    
    /// The asset clips anchored to the title.
    public var assetClips: [AssetClip] = []
    
    /// The auditions anchored to the title.
    public var auditions: [Audition] = []
    
    /// The spines anchored to the title.
    public var spines: [Spine] = []
    
    /// The markers attached to the title.
    public var markers: [Marker] = []
    
    /// The chapter markers attached to the title.
    public var chapterMarkers: [ChapterMarker] = []
    
    /// The ratings associated with the title.
    public var ratings: [Rating] = []
    
    /// The keywords associated with the title.
    public var keywords: [Keyword] = []
    
    /// The analysis markers attached to the title.
    public var analysisMarkers: [AnalysisMarker] = []
    
    /// The video filters applied to the title.
    public var videoFilters: [VideoFilter] = []
    
    /// The video filter masks applied to the title.
    public var videoFilterMasks: [VideoFilterMask] = []
    
    /// The metadata associated with the title.
    public var metadata: [Metadatum]? {
        get { return _metadata?.metadata }
        set { _metadata = Metadata(metadata: newValue) }
    }
    
    /// The reference identifier of the title.
    public var referenceID: String
    
    /// The lane of the title.
    public var lane: Int?
    
    /// The offset of the title.
    public var offset: CMTime?
    
    /// The name of the title.
    public var name: String?
    
    /// The start time of the title.
    public var start: CMTime?
    
    /// The duration of the title.
    public var duration: CMTime
    
    /// A Boolean value indicating whether the title is enabled.
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }
    
    /// The role of the title.
    public var role: String?

    private var _metadata: Metadata?
    private var enabled: Bool?
    
    /// Initializes a new title.
    /// - Parameter referenceID: The reference identifier of the title.
    /// - Parameter offset: The offset of the title.
    /// - Parameter name: The name of the title.
    /// - Parameter start: The start time of the title.
    /// - Parameter duration: The duration of the title.
    public init(referenceID: String, offset: CMTime = .zero, name: String? = nil, start: CMTime? = nil, duration: CMTime) {
        self.referenceID = referenceID
        self.offset = offset
        self.name = name
        self.start = start
        self.duration = duration
    }

}

extension Title: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .referenceID, .lane, .offset, .name, .start, .duration, .enabled, .role:
            return .attribute
        default:
            return .element
        }
    }

}
