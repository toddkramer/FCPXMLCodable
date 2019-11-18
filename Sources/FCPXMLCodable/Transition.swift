//
//  Transition.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

public struct Transition: XMLRepresentable, Offsettable {

    private enum CodingKeys: String, CodingKey {
        case videoFilters = "filter-video"
        case audioFilters = "filter-audio"
        case markers = "marker"
        case chapterMarkers = "chapter-marker"
        case ratings = "rating"
        case keywords = "keyword"
        case analysisMarkers = "analysis-marker"
        case _metadata = "metadata"
        case reserved
        case name, offset, duration
    }
    
    /// The video filters applied to the transition.
    public var videoFilters: [VideoFilter] = []
    
    /// The audio filters applied to the transition.
    public var audioFilters: [AudioFilter] = []
    
    /// The markers attached to the transition.
    public var markers: [Marker] = []
    
    /// The chapter markers attached to the transition.
    public var chapterMarkers: [ChapterMarker] = []
    
    /// The ratings associated with the transition.
    public var ratings: [Rating] = []
    
    /// The keywords associated with the transition.
    public var keywords: [Keyword] = []
    
    /// The analysis markers attached to the transition.
    public var analysisMarkers: [AnalysisMarker] = []
    
    /// The metadata associated with the transition.
    public var metadata: [Metadatum]? {
        get { return _metadata?.metadata }
        set { _metadata = Metadata(metadata: newValue) }
    }
    
    /// The reserved field of the transition.
    public var reserved: String?
    
    /// The name of the transition.
    public var name: String?
    
    /// The offset of the transition.
    public var offset: CMTime?
    
    /// The duration of the transition.
    public var duration: CMTime

    private var _metadata: Metadata?
    
    /// Initializes a new transition.
    /// - Parameter offset: The offset of the transition.
    /// - Parameter name: The name of the transition.
    /// - Parameter duration: The duration of the transition.
    public init(offset: CMTime = .zero, name: String? = nil, duration: CMTime) {
        self.offset = offset
        self.name = name
        self.duration = duration
    }

}

extension Transition: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .name, .offset, .duration:
            return .attribute
        default:
            return .element
        }
    }

}
