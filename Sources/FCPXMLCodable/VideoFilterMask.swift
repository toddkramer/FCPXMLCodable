//
//  VideoFilterMask.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct VideoFilterMask: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case maskShapes = "mask-shape"
        case maskIsolations = "mask-isolation"
        case videoFilters = "filter-video"
        case enabled, inverted
    }

    public var maskShapes: [MaskShape] = []
    public var maskIsolations: [MaskIsolation] = []
    public var videoFilters: [VideoFilter]

    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }
    public var isInverted: Bool {
        get { return inverted ?? false }
        set { inverted = newValue }
    }

    private var enabled: Bool?
    private var inverted: Bool?

    public init(maskShapes: [MaskShape] = [], maskIsolations: [MaskIsolation] = [], primaryVideoFilter: VideoFilter,
                secondaryVideoFilter: VideoFilter? = nil) {
        self.maskShapes = maskShapes
        self.maskIsolations = maskIsolations
        self.videoFilters = [primaryVideoFilter, secondaryVideoFilter].compactMap { $0 }
    }

}

extension VideoFilterMask: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .maskShapes, .maskIsolations, .videoFilters:
            return .element
        default:
            return .attribute
        }
    }

}
