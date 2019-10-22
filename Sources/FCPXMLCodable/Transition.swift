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

    public var videoFilters: [VideoFilter] = []
    public var audioFilters: [AudioFilter] = []

    public var markers: [Marker] = []
    public var chapterMarkers: [ChapterMarker] = []
    public var ratings: [Rating] = []
    public var keywords: [Keyword] = []
    public var analysisMarkers: [AnalysisMarker] = []

    public var metadata: [Metadatum]? {
        get { return _metadata?.metadata }
        set { _metadata = Metadata(metadata: newValue) }
    }
    public var reserved: String?

    public var name: String?
    public var offset: CMTime?
    public var duration: CMTime

    private var _metadata: Metadata?

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
