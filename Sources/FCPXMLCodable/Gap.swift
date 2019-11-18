//
//  Gap.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

public struct Gap: XMLRepresentable, Offsettable {

    private enum CodingKeys: String, CodingKey {
        case note
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
        case _metadata = "metadata"
        case name, offset, start, duration, enabled
    }
    
    /// A note about the gap.
    public var note: String?
    
    /// The audios anchored to the gap.
    public var audios: [Audio] = []
    
    /// The videos anchored to the gap.
    public var videos: [Video] = []
    
    /// The clips anchored to the gap.
    public var clips: [Clip] = []
    
    /// The titles anchored to the gap.
    public var titles: [Title] = []
    
    /// The captions anchored to the gap.
    public var captions: [Caption] = []
    
    /// The multicam clips anchored to the gap.
    public var multicamClips: [MulticamClip] = []
    
    /// The reference clips anchored to the gap.
    public var referenceClips: [ReferenceClip] = []
    
    /// The sync clips anchored to the gap.
    public var syncClips: [SyncClip] = []
    
    /// The asset clips anchored to the gap.
    public var assetClips: [AssetClip] = []
    
    /// The auditions anchored to the gap.
    public var auditions: [Audition] = []
    
    /// The spines anchored to the gap.
    public var spines: [Spine] = []
    
    /// The markers attached to the gap.
    public var markers: [Marker] = []
    
    /// The chapter markers attached to the gap.
    public var chapterMarkers: [ChapterMarker] = []
    
    /// The ratings associated with the gap.
    public var ratings: [Rating] = []
    
    /// The keywords associated with the gap.
    public var keywords: [Keyword] = []
    
    /// The analysis markers attached to the gap.
    public var analysisMarkers: [AnalysisMarker] = []
    
    /// The metadata associated with the gap.
    public var metadata: [Metadatum]? {
        get { return _metadata?.metadata }
        set { _metadata = Metadata(metadata: newValue) }
    }
    
    /// The name of the gap.
    public var name: String?
    
    /// The offset of the gap.
    public var offset: CMTime? = .zero
    
    /// The start time of the gap.
    public var start: CMTime?
    
    /// The duration of the gap.
    public var duration: CMTime
    
    /// A Boolean value indicating whether the gap is enabled.
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }

    private var _metadata: Metadata?
    private var enabled: Bool?
    
    /// Initializes a new gap.
    /// - Parameter name: The name of the gap.
    /// - Parameter offset: The offset of the gap.
    /// - Parameter start: The start time of the gap.
    /// - Parameter duration: The duration of the gap.
    public init(name: String? = nil, offset: CMTime = .zero, start: CMTime? = nil, duration: CMTime) {
        self.name = name
        self.offset = offset
        self.start = start
        self.duration = duration
    }

}

extension Gap: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .name, .offset, .start, .duration, .enabled:
            return .attribute
        default:
            return .element
        }
    }

}
