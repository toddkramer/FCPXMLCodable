//
//  Format.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

/// A reference to a Final Cut Pro X video format definition.
/// - SeeAlso:
/// [FCPXML Resources Documentation](https://developer.apple.com/library/archive/documentation/FinalCutProX/Reference/FinalCutProXXMLFormat/Resources/Resources.html#//apple_ref/doc/uid/TP40011227-CH16-SW1)
public struct Format: Resource {

    /// The identifier of the format.
    /// This identifier is unique within the context of a FCPXML document and refers to the resource identifier (e.g. r1).
    public let id: String

    /// The name of the format.
    public var name: String?

    /// The frame duration of the format.
    public var frameDuration: CMTime?

    /// The field order of the format.
    public var fieldOrder: FieldOrder?

    /// The video frame width, in pixels.
    public var width: Int?

    /// The video frame height, in pixels.
    public var height: Int?

    /// The relative width of a pixel when video is encoded with non-square pixels.
    public var paspH: Int?

    /// The relative height of a pixel when video is encoded with non-square pixels.
    public var paspV: Int?

    /// The color space of the format.
    public var colorSpace: ColorSpace?

    /// The projection type of the format.
    public var projection: Projection?

    /// The stereoscopic mode of the format.
    public var stereoscopic: Stereoscopic?

    /// Initializes a new format with a resource identifier.
    /// - Parameter id: The identifier of the format.
    /// - Parameter name: The name of the format.
    /// - Parameter width: The video frame width, in pixels.
    /// - Parameter height: The video frame height, in pixels.
    public init(id: String, name: String? = nil, width: Int? = nil, height: Int? = nil) {
        self.id = id
        self.name = name
        self.width = width
        self.height = height
    }

}

extension Format: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
