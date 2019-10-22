//
//  Crop.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct Crop: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case cropRect = "crop-rect"
        case trimRect = "trim-rect"
        case panRects = "pan-rect"
        case mode, enabled
    }

    public enum Mode: String, XMLRepresentable {
        case trim, crop, pan
    }

    public var cropRect: CropRect?
    public var trimRect: TrimRect?
    public var panRects: [PanRect]?

    public var mode: Mode
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }

    private var enabled: Bool?

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
