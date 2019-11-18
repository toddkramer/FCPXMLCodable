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
    
    /// The mask shapes of the video filter mask.
    public var maskShapes: [MaskShape] = []
    
    /// The mask isolations of the video filter mask.
    public var maskIsolations: [MaskIsolation] = []
    
    /// The video filters of the video filter mask.
    public var videoFilters: [VideoFilter]
    
    /// A Boolean value indicating whether the video filter mask is enabled.
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }
    
    /// A Boolean value indicating whether the video filter mask is inverted.
    public var isInverted: Bool {
        get { return inverted ?? false }
        set { inverted = newValue }
    }

    private var enabled: Bool?
    private var inverted: Bool?
    
    /// Initializes a new video filter mask.
    /// - Parameter maskShapes: The mask shapes of the video filter mask.
    /// - Parameter maskIsolations: The mask isolations of the video filter mask.
    /// - Parameter primaryVideoFilter: The primary video filter of the video filter mask.
    /// - Parameter secondaryVideoFilter: The secondary video filter of the video filter mask.
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
