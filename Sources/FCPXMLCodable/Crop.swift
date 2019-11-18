//
//  Crop.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

/// Modifies the visible image width and height by cropping, trimming, or panning.
public struct Crop: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case cropRect = "crop-rect"
        case trimRect = "trim-rect"
        case panRects = "pan-rect"
        case mode, enabled
    }
    
    /// Specifies the mode of a crop adjustment.
    public enum Mode: String, XMLRepresentable {

        /// :nodoc:
        case trim

        /// :nodoc:
        case crop

        /// :nodoc:
        case pan

    }
    
    /// The crop rect used for a crop mode crop adjustment.
    public var cropRect: CropRect?
    
    /// The trim rect used for a trim mode crop adjustment.
    public var trimRect: TrimRect?
    
    /// The pan rects used for a pan mode crop adjustment.
    public var panRects: [PanRect]?
    
    /// The mode of the crop adjustment.
    public var mode: Mode
    
    /// A Boolean value indicating whether the crop adjustment is enabled.
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }

    private var enabled: Bool?
    
    /// Initializes a new crop adjustment.
    /// - Parameter mode: The mode of the crop adjustment.
    public init(mode: Mode) {
        self.mode = mode
    }

}

extension Crop: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .cropRect, .trimRect, .panRects:
            return .element
        default:
            return .attribute
        }
    }

}
